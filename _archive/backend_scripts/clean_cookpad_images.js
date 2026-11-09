const mysql = require('mysql2/promise');

async function clean() {
  const conn = await mysql.createConnection({
    host: 'localhost',
    port: 3307,
    user: 'root',
    password: '7855',
    database: 'foodai'
  });

  console.log('🔄 Đang làm sạch và chuẩn hóa cookpad_dish_images...');

  // 1. Nâng cấp URL độ phân giải 1200x630cq80
  const [rows] = await conn.query('SELECT id, image_url, recipe_title FROM cookpad_dish_images');
  let upgraded = 0;
  for (const r of rows) {
    if (r.image_url && !r.image_url.includes('1200x630')) {
      const hqUrl = r.image_url.replace(
        /\/(?:120x160[^\s"'/]*|179x133[^\s"'/]*|300x200[^\s"'/]*|300x220[^\s"'/]*|400x400[^\s"'/]*|600x440[^\s"'/]*|680x482[^\s"'/]*)\//,
        '/1200x630cq80/'
      );
      if (hqUrl !== r.image_url) {
        await conn.query('UPDATE cookpad_dish_images SET image_url = ? WHERE id = ?', [hqUrl, r.id]);
        upgraded++;
      }
    }
  }
  console.log(`✅ Đã nâng cấp ${upgraded} ảnh sang độ phân giải HD 1200x630cq80.`);

  // 2. Làm sạch tiêu đề có tiền tố "Hình ảnh của..."
  const [cleanTitle] = await conn.query(`
    UPDATE cookpad_dish_images 
    SET recipe_title = TRIM(REGEXP_REPLACE(recipe_title, '^(Hình ảnh của|Hình của món)\\\\s+', ''))
    WHERE recipe_title LIKE 'Hình%'
  `);
  console.log(`✅ Đã làm sạch tiền tố tiêu đề cho ${cleanTitle.affectedRows} mục.`);

  // 3. Xóa các combo mâm cơm rác
  const [delCombo] = await conn.query(`
    DELETE FROM cookpad_dish_images 
    WHERE recipe_title LIKE '%+%' 
       OR recipe_title LIKE '%combo%' 
       OR recipe_title LIKE '%thực đơn%' 
       OR recipe_title LIKE '%mâm cơm%' 
       OR recipe_title LIKE '%bữa cơm%'
       OR recipe_title LIKE '%cơm ngon nhà huý%'
  `);
  console.log(`✅ Đã xóa ${delCombo.affectedRows} mục mâm cơm combo rác khỏi cookpad_dish_images.`);

  // 4. Đồng bộ cũng cho bảng recipes
  let recipeUpgraded = 0;
  const [recRows] = await conn.query('SELECT id, image_url FROM recipes');
  for (const r of recRows) {
    if (r.image_url && !r.image_url.includes('1200x630') && r.image_url.includes('cpcdn')) {
      const hq = r.image_url.replace(
        /\/(?:120x160[^\s"'/]*|179x133[^\s"'/]*|300x200[^\s"'/]*|300x220[^\s"'/]*|400x400[^\s"'/]*|600x440[^\s"'/]*|680x482[^\s"'/]*)\//,
        '/1200x630cq80/'
      );
      if (hq !== r.image_url) {
        await conn.query('UPDATE recipes SET image_url = ? WHERE id = ?', [hq, r.id]);
        recipeUpgraded++;
      }
    }
  }
  console.log(`✅ Đã nâng cấp ${recipeUpgraded} ảnh trong bảng recipes lên HD 1200x630cq80.`);

  await conn.end();
  console.log('🎉 Hoàn tất dọn dẹp cơ sở dữ liệu!');
}

clean().catch(console.error);
