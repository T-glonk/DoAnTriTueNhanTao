const mysql = require('mysql2/promise');
const fs = require('fs');
const path = require('path');
const { v4: uuidv4 } = require('uuid');

async function main() {
  console.log('🔄 Bắt đầu dọn dẹp và nạp dữ liệu chuẩn xác vào MySQL...');
  const conn = await mysql.createConnection({
    host: 'localhost',
    port: 3307,
    user: 'root',
    password: '7855',
    database: 'foodai'
  });

  // 1. Dọn dẹp các ảnh Unsplash và ảnh rác bị gán sai
  console.log('🧹 Xóa các ảnh Unsplash bị gán sai trong CSDL...');
  await conn.query('ALTER TABLE recipe_ingredients MODIFY COLUMN quantity VARCHAR(500) NULL');
  await conn.query('ALTER TABLE recipe_ingredients MODIFY COLUMN raw_text VARCHAR(500) NOT NULL');
  await conn.query('ALTER TABLE recipe_ingredients MODIFY COLUMN ingredient_name VARCHAR(255) NOT NULL');

  const [delRes] = await conn.query('DELETE FROM recipes WHERE image_url LIKE "%unsplash%" OR image_url IS NULL OR image_url = ""');
  console.log(`Đã xóa ${delRes.affectedRows} món ăn chứa ảnh Unsplash bị gán sai.`);

  const [delImgRes] = await conn.query('DELETE FROM cookpad_dish_images WHERE image_url LIKE "%unsplash%" OR recipe_title LIKE "%cơm ngon nhà huý%"');
  console.log(`Đã xóa ${delImgRes.affectedRows} ảnh rác trong cookpad_dish_images.`);

  // 2. Thu thập dữ liệu từ các file JSON Cookpad chuẩn
  const files = [
    path.resolve(__dirname, '../../../crawler/cookpad_recipes.json'),
    path.resolve(__dirname, '../../../crawler/cookpad_rare_recipes.json'),
    path.resolve(__dirname, '../../../crawler/seed_recipes.json')
  ];

  const uniqueDishes = new Map();

  for (const filePath of files) {
    if (!fs.existsSync(filePath)) continue;
    const raw = fs.readFileSync(filePath, 'utf8');
    try {
      const list = JSON.parse(raw);
      for (const item of list) {
        if (!item.name || !item.image_url) continue;
        // Bỏ qua nếu là ảnh Unsplash
        if (item.image_url.includes('unsplash.com')) continue;

        // Chuẩn hóa tên món
        const cleanName = item.name.replace(/^[0-9.\-\s]+/, '').replace(/^Hình của món\s+/i, '').trim();
        const normKey = cleanName.toLowerCase();

        if (!uniqueDishes.has(normKey)) {
          uniqueDishes.set(normKey, {
            ...item,
            name: cleanName
          });
        }
      }
    } catch (e) {
      console.error(`Lỗi đọc file ${filePath}:`, e.message);
    }
  }

  console.log(`📦 Tổng số món ăn Cookpad thực tế hợp lệ: ${uniqueDishes.size}`);

  // 3. Nạp vào MySQL
  let inserted = 0;
  for (const dish of uniqueDishes.values()) {
    const dishId = dish.id || uuidv4();
    const cookingTime = dish.cooking_time || 30;
    const difficulty = dish.difficulty || 'Trung bình';
    const servings = dish.servings || '2-4 người';
    const category = dish.category || 'Món chính';
    const sourceUrl = dish.source_url || 'https://cookpad.com/vn';
    const authorName = dish.author_name || 'Cookpad VN';
    const desc = dish.description || `Món ${dish.name} thơm ngon chuẩn vị truyền thống Việt Nam.`;

    await conn.query(
      `INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
       ON DUPLICATE KEY UPDATE 
         image_url = VALUES(image_url),
         description = VALUES(description),
         category = VALUES(category)`,
      [dishId, dish.name, desc, dish.image_url, cookingTime, difficulty, servings, category, sourceUrl, authorName]
    );

    // Lưu vào cookpad_dish_images
    const normKey = dish.name.toLowerCase().trim();
    await conn.query(
      `INSERT INTO cookpad_dish_images (query_key, image_url, recipe_title, source)
       VALUES (?, ?, ?, 'cookpad')
       ON DUPLICATE KEY UPDATE image_url = VALUES(image_url)`,
      [normKey, dish.image_url, dish.name]
    );

    // Nạp ingredients nếu có
    if (Array.isArray(dish.ingredients) && dish.ingredients.length > 0) {
      for (const ing of dish.ingredients) {
        const rawText = (ing.raw_text || ing.name || (typeof ing === 'string' ? ing : '')).substring(0, 490);
        const ingName = (ing.ingredient_name || ing.name || rawText).substring(0, 250);
        const qty = (ing.quantity || '').substring(0, 490);
        if (rawText) {
          await conn.query(
            `INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main)
             VALUES (?, ?, ?, ?, 1)`,
            [dishId, rawText, ingName, qty]
          );
        }
      }
    }

    // Nạp steps nếu có
    if (Array.isArray(dish.steps) && dish.steps.length > 0) {
      for (const st of dish.steps) {
        const stepNum = st.step_number || 1;
        const instr = st.instruction || (typeof st === 'string' ? st : '');
        const stepImg = st.step_image_url || null;
        if (instr) {
          await conn.query(
            `INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url)
             VALUES (?, ?, ?, ?)`,
            [dishId, stepNum, instr, stepImg]
          );
        }
      }
    }

    inserted++;
  }

  // 4. Kiểm tra lại dữ liệu
  const [totalRes] = await conn.query('SELECT count(*) as cnt FROM recipes');
  const [cpRes] = await conn.query('SELECT count(*) as cnt FROM recipes WHERE image_url LIKE "%cpcdn%"');
  console.log(`✅ Hoàn tất! Hiện có ${totalRes[0].cnt} món ăn trong MySQL (Trong đó ${cpRes[0].cnt} món có ảnh thật 100% từ Cookpad CDN).`);

  await conn.end();
}

main().catch(err => {
  console.error('Lỗi thực thi:', err);
  process.exit(1);
});
