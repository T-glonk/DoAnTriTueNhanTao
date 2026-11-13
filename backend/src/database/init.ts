import { getPool } from './db';
import bcrypt from 'bcryptjs';
import { v4 as uuidv4 } from 'uuid';
import fs from 'fs';
import path from 'path';

export async function initializeDatabase(): Promise<void> {
  const pool = getPool();

  console.log('🔄 Đang kiểm tra và khởi tạo cơ sở dữ liệu MySQL...');

  // 1. Tạo bảng users
  await pool.query(`
    CREATE TABLE IF NOT EXISTS users (
      id          VARCHAR(36)  NOT NULL PRIMARY KEY,
      username    VARCHAR(50)  NOT NULL UNIQUE,
      email       VARCHAR(100) NOT NULL UNIQUE,
      password    VARCHAR(255) NOT NULL,
      full_name   VARCHAR(100) NOT NULL,
      role        VARCHAR(10)  NOT NULL DEFAULT 'user',
      avatar      VARCHAR(500) NULL,
      is_active   TINYINT(1)   NOT NULL DEFAULT 1,
      created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      INDEX idx_users_username (username),
      INDEX idx_users_email (email)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  // 2. Tạo bảng recipes (Chỉ chứa Tên món ăn, Hình ảnh từ Cookpad)
  await pool.query(`
    CREATE TABLE IF NOT EXISTS recipes (
      id           VARCHAR(36)   NOT NULL PRIMARY KEY,
      name         VARCHAR(255)  NOT NULL,
      description  TEXT          NULL,
      image_url    MEDIUMTEXT    NULL,
      cooking_time INT           NULL DEFAULT 30,
      difficulty   VARCHAR(20)   NOT NULL DEFAULT 'Trung bình',
      servings     VARCHAR(50)   NULL DEFAULT '2-4 người',
      category     VARCHAR(50)   NOT NULL DEFAULT 'Món chính',
      source_url   VARCHAR(500)  NULL,
      author_name  VARCHAR(100)  NULL DEFAULT 'Cookpad VN',
      created_at   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
      updated_at   DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
      INDEX idx_recipes_name (name),
      INDEX idx_recipes_category (category)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  // 3. Tạo bảng cookpad_dish_images (Lưu trữ ảnh cào từ Cookpad theo món ăn)
  await pool.query(`
    CREATE TABLE IF NOT EXISTS cookpad_dish_images (
      id           INT AUTO_INCREMENT PRIMARY KEY,
      query_key    VARCHAR(255)  NOT NULL,
      image_url    MEDIUMTEXT    NOT NULL,
      recipe_title VARCHAR(255)  NULL,
      source       VARCHAR(50)   DEFAULT 'cookpad',
      created_at   DATETIME      DEFAULT CURRENT_TIMESTAMP,
      INDEX idx_query_key (query_key)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  // 4. Bảng liên quan đến công thức chi tiết
  await pool.query(`
    CREATE TABLE IF NOT EXISTS recipe_ingredients (
      id              INT AUTO_INCREMENT PRIMARY KEY,
      recipe_id       VARCHAR(36)  NOT NULL,
      raw_text        VARCHAR(255) NOT NULL,
      ingredient_name VARCHAR(100) NOT NULL,
      quantity        VARCHAR(50)  NULL,
      is_main         TINYINT(1)   NOT NULL DEFAULT 1,
      CONSTRAINT fk_ingredient_recipe FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
      INDEX idx_ingredient_name (ingredient_name),
      INDEX idx_ingredient_recipe (recipe_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  await pool.query(`
    CREATE TABLE IF NOT EXISTS recipe_steps (
      id             INT AUTO_INCREMENT PRIMARY KEY,
      recipe_id      VARCHAR(36)   NOT NULL,
      step_number    INT           NOT NULL,
      instruction    TEXT          NOT NULL,
      step_image_url MEDIUMTEXT    NULL,
      CONSTRAINT fk_step_recipe FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
      INDEX idx_step_recipe (recipe_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  await pool.query(`
    CREATE TABLE IF NOT EXISTS recipe_nutrition (
      id            INT AUTO_INCREMENT PRIMARY KEY,
      recipe_id     VARCHAR(36) NOT NULL UNIQUE,
      calories      INT         NOT NULL DEFAULT 0,
      protein       FLOAT       NOT NULL DEFAULT 0,
      carbohydrates FLOAT       NOT NULL DEFAULT 0,
      fat           FLOAT       NOT NULL DEFAULT 0,
      fiber         FLOAT       NOT NULL DEFAULT 0,
      calcium       FLOAT       NULL DEFAULT 0,
      iron          FLOAT       NULL DEFAULT 0,
      CONSTRAINT fk_nutrition_recipe FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  await pool.query(`
    CREATE TABLE IF NOT EXISTS recipe_tags (
      id        INT AUTO_INCREMENT PRIMARY KEY,
      recipe_id VARCHAR(36) NOT NULL,
      tag_name  VARCHAR(50) NOT NULL,
      CONSTRAINT fk_tag_recipe FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
      INDEX idx_tag_name (tag_name),
      INDEX idx_tag_recipe (recipe_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  // 5. Tạo bảng search_history
  await pool.query(`
    CREATE TABLE IF NOT EXISTS search_history (
      id          VARCHAR(36) NOT NULL PRIMARY KEY,
      user_id     VARCHAR(36) NOT NULL,
      ingredients TEXT        NOT NULL,
      created_at  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
      CONSTRAINT fk_history_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
      INDEX idx_history_user (user_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  // 6. Tạo bảng favorite_recipes
  await pool.query(`
    CREATE TABLE IF NOT EXISTS favorite_recipes (
      id          VARCHAR(36) NOT NULL PRIMARY KEY,
      user_id     VARCHAR(36) NOT NULL,
      recipe_id   VARCHAR(36) NULL,
      recipe_data LONGTEXT    NOT NULL,
      created_at  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
      CONSTRAINT fk_favorite_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
      INDEX idx_favorite_user (user_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  // Tạo tài khoản Admin mặc định nếu chưa có
  const [adminRows] = await pool.query<any[]>('SELECT id FROM users WHERE role = ?', ['admin']);
  if (adminRows.length === 0) {
    const hashed = await bcrypt.hash('Admin@123456', 12);
    await pool.query(
      `INSERT INTO users (id, username, email, password, full_name, role, is_active)
       VALUES (?, ?, ?, ?, ?, ?, 1)`,
      ['admin-uuid-0000-1111-222233334444', 'admin', 'admin@foodsystem.com', hashed, 'Quản trị viên', 'admin']
    );
    console.log('✅ Đã tạo tài khoản Admin: admin@foodsystem.com / Admin@123456');
  }

  // Tạo tài khoản Test User nếu chưa có
  const [userRows] = await pool.query<any[]>('SELECT id FROM users WHERE username = ?', ['testuser']);
  if (userRows.length === 0) {
    const hashed = await bcrypt.hash('User@123456', 12);
    await pool.query(
      `INSERT INTO users (id, username, email, password, full_name, role, is_active)
       VALUES (?, ?, ?, ?, ?, ?, 1)`,
      ['user-uuid-1111-2222-333344445555', 'testuser', 'user@foodsystem.com', hashed, 'Người dùng thử nghiệm', 'user']
    );
    console.log('✅ Đã tạo tài khoản Người dùng: user@foodsystem.com / User@123456');
  }

  // Tự động seed dữ liệu Cookpad nếu bảng recipes trống
  const [recipeCount] = await pool.query<any[]>('SELECT COUNT(*) as total FROM recipes');
  if (recipeCount[0].total === 0) {
    const jsonPaths = [
      path.resolve(__dirname, '../../data/cookpad_recipes.json'),
      path.resolve(__dirname, '../data/cookpad_recipes.json'),
      path.resolve(process.cwd(), 'backend/data/cookpad_recipes.json'),
      path.resolve(process.cwd(), 'data/cookpad_recipes.json'),
      path.resolve(__dirname, '../../../_archive/crawler/cookpad_recipes.json'),
      path.resolve(process.cwd(), '_archive/crawler/cookpad_recipes.json'),
    ];

    let rawData = '';
    for (const p of jsonPaths) {
      if (fs.existsSync(p)) {
        rawData = fs.readFileSync(p, 'utf-8');
        break;
      }
    }

    if (rawData) {
      try {
        console.log('📦 Bắt đầu nạp dữ liệu Tên & Hình ảnh Cookpad vào MySQL từ file JSON...');
        const dishes = JSON.parse(rawData);
        for (const d of dishes) {
          const dishId = d.id || uuidv4();
          await pool.query(
            `INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
             ON DUPLICATE KEY UPDATE image_url=VALUES(image_url), category=VALUES(category)`,
            [
              dishId,
              d.name,
              d.description || `Món ${d.name} thơm ngon chuẩn vị Việt Nam.`,
              d.image_url,
              d.cooking_time || 30,
              d.difficulty || 'Trung bình',
              d.servings || '2-4 người',
              d.category || 'Món chính',
              d.source_url || 'https://cookpad.com/vn',
              d.author_name || 'Cookpad VN'
            ]
          );

          const normKey = d.name.toLowerCase().trim();
          await pool.query(
            `INSERT INTO cookpad_dish_images (query_key, image_url, recipe_title, source)
             VALUES (?, ?, ?, 'cookpad')
             ON DUPLICATE KEY UPDATE image_url=VALUES(image_url)`,
            [normKey, d.image_url, d.name]
          );
        }
        console.log(`✅ Đã nạp thành công ${dishes.length} món ăn từ Cookpad vào MySQL!`);
      } catch (seedErr) {
        console.error('⚠️ Lỗi khi nạp seed dữ liệu Cookpad:', seedErr);
      }
    }
  } else {
    console.log(`ℹ️ Cơ sở dữ liệu hiện có ${recipeCount[0].total} món ăn Cookpad (Tên & Hình ảnh).`);
  }

  console.log('✅ Cơ sở dữ liệu MySQL đã sẵn sàng!');
}
