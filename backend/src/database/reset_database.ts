import { getPool } from './db';
import bcrypt from 'bcryptjs';
import { v4 as uuidv4 } from 'uuid';
import fs from 'fs';
import path from 'path';

export async function resetAndRebuildDatabase(): Promise<void> {
  const pool = getPool();

  console.log('🗑️  Bắt đầu xóa sạch toàn bộ dữ liệu trong cơ sở dữ liệu MySQL (foodai)...');

  // Tắt kiểm tra khóa ngoại để xóa bảng an toàn
  await pool.query('SET FOREIGN_KEY_CHECKS = 0;');

  const tables = [
    'recipe_ingredients',
    'recipe_steps',
    'recipe_nutrition',
    'recipe_tags',
    'favorite_recipes',
    'search_history',
    'cookpad_dish_images',
    'recipes',
    'users'
  ];

  for (const table of tables) {
    await pool.query(`DROP TABLE IF EXISTS ${table};`);
  }

  await pool.query('SET FOREIGN_KEY_CHECKS = 1;');
  console.log('✅ Đã xóa sạch toàn bộ bảng cũ!');

  console.log('🏗️  Đang tạo mới cấu trúc cơ sở dữ liệu MySQL...');

  // 1. Tạo bảng users
  await pool.query(`
    CREATE TABLE users (
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

  // 2. Tạo bảng recipes (Chỉ chứa Tên món ăn, Hình ảnh từ Cookpad & phân loại)
  await pool.query(`
    CREATE TABLE recipes (
      id           VARCHAR(36)   NOT NULL PRIMARY KEY,
      name         VARCHAR(255)  NOT NULL,
      description  TEXT          NULL,
      image_url    VARCHAR(1000) NULL,
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

  // 3. Tạo bảng cookpad_dish_images (Lưu ảnh chất lượng cao cào từ Cookpad)
  await pool.query(`
    CREATE TABLE cookpad_dish_images (
      id           INT AUTO_INCREMENT PRIMARY KEY,
      query_key    VARCHAR(255)  NOT NULL,
      image_url    VARCHAR(1000) NOT NULL,
      recipe_title VARCHAR(255)  NULL,
      source       VARCHAR(50)   DEFAULT 'cookpad',
      created_at   DATETIME      DEFAULT CURRENT_TIMESTAMP,
      INDEX idx_query_key (query_key)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  // 4. Tạo bảng recipe_ingredients, recipe_steps, recipe_nutrition, recipe_tags
  await pool.query(`
    CREATE TABLE recipe_ingredients (
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
    CREATE TABLE recipe_steps (
      id             INT AUTO_INCREMENT PRIMARY KEY,
      recipe_id      VARCHAR(36)   NOT NULL,
      step_number    INT           NOT NULL,
      instruction    TEXT          NOT NULL,
      step_image_url VARCHAR(1000) NULL,
      CONSTRAINT fk_step_recipe FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
      INDEX idx_step_recipe (recipe_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  await pool.query(`
    CREATE TABLE recipe_nutrition (
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
    CREATE TABLE recipe_tags (
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
    CREATE TABLE search_history (
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
    CREATE TABLE favorite_recipes (
      id          VARCHAR(36) NOT NULL PRIMARY KEY,
      user_id     VARCHAR(36) NOT NULL,
      recipe_id   VARCHAR(36) NULL,
      recipe_data LONGTEXT    NOT NULL,
      created_at  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
      CONSTRAINT fk_favorite_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
      INDEX idx_favorite_user (user_id)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
  `);

  console.log('✅ Đã tạo cấu trúc các bảng MySQL mới thành công!');

  // 7. Tạo tài khoản Admin mặc định
  const adminHashed = await bcrypt.hash('Admin@123456', 12);
  await pool.query(
    `INSERT INTO users (id, username, email, password, full_name, role, is_active)
     VALUES (?, ?, ?, ?, ?, ?, 1)`,
    [uuidv4(), 'admin', 'admin@foodsystem.com', adminHashed, 'Quản trị viên', 'admin']
  );
  console.log('👤 Đã tạo tài khoản Admin: admin@foodsystem.com / Admin@123456');

  // 8. Tạo tài khoản Người dùng mặc định
  const userHashed = await bcrypt.hash('User@123456', 12);
  await pool.query(
    `INSERT INTO users (id, username, email, password, full_name, role, is_active)
     VALUES (?, ?, ?, ?, ?, ?, 1)`,
    [uuidv4(), 'testuser', 'user@foodsystem.com', userHashed, 'Người dùng thử nghiệm', 'user']
  );
  console.log('👤 Đã tạo tài khoản Người dùng: user@foodsystem.com / User@123456');

  // 9. Nạp dữ liệu các món ăn cào từ Cookpad (CHỈ TÊN VÀ HÌNH ẢNH)
  const jsonPaths = [
    path.resolve(__dirname, '../../../crawler/cookpad_recipes.json'),
    path.resolve(process.cwd(), 'crawler/cookpad_recipes.json'),
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
      const dishes = JSON.parse(rawData);
      console.log(`📦 Bắt đầu nạp ${dishes.length} món ăn (Tên & Hình ảnh Cookpad) vào MySQL...`);

      for (const d of dishes) {
        const dishId = d.id || uuidv4();
        await pool.query(
          `INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
           VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
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

        // Lưu vào cookpad_dish_images
        const normKey = d.name.toLowerCase().trim();
        await pool.query(
          `INSERT INTO cookpad_dish_images (query_key, image_url, recipe_title, source)
           VALUES (?, ?, ?, 'cookpad')`,
          [normKey, d.image_url, d.name]
        );
      }

      console.log(`🎉 Đã nạp thành công ${dishes.length} món ăn từ Cookpad vào Database!`);
    } catch (parseErr) {
      console.error('❌ Lỗi khi đọc dữ liệu Cookpad JSON:', parseErr);
    }
  } else {
    console.warn('⚠️ Không tìm thấy file crawler/cookpad_recipes.json');
  }

  console.log('🚀 Database mới đã được tái thiết lập thành công!');
}

if (require.main === module) {
  resetAndRebuildDatabase()
    .then(() => {
      console.log('✅ Hoàn tất Reset Database!');
      process.exit(0);
    })
    .catch((err) => {
      console.error('❌ Lỗi Reset Database:', err);
      process.exit(1);
    });
}
