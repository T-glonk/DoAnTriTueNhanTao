const mysql = require('mysql2/promise');
async function testExact67() {
  const conn = await mysql.createConnection({
    host: 'localhost', port: 3307, user: 'root', password: '7855', database: 'foodai'
  });
  
  // 1. Kiểm tra theo từng category
  const [cats] = await conn.query('SELECT category, COUNT(*) as c FROM recipes GROUP BY category');
  for (const c of cats) {
    if (c.c === 67) console.log('Match category:', c.category);
  }

  // 2. Kiểm tra các món do người dùng thêm hoặc món Cookpad có ảnh hợp lệ
  const [q1] = await conn.query("SELECT COUNT(*) as c FROM recipes WHERE author_name = 'Cookpad VN' AND (image_url IS NOT NULL AND image_url != '')");
  console.log('Cookpad with valid image:', q1[0].c);

  // 3. Kiểm tra các món có đủ steps & ingredients
  const [q2] = await conn.query(`
    SELECT COUNT(DISTINCT r.id) as c 
    FROM recipes r 
    WHERE EXISTS (SELECT 1 FROM recipe_ingredients ri WHERE ri.recipe_id = r.id)
      AND EXISTS (SELECT 1 FROM recipe_steps rs WHERE rs.recipe_id = r.id)
  `);
  console.log('Recipes with both ingredients and steps:', q2[0].c);

  // 4. Kiểm tra lịch sử xóa/thêm gần đây: các món được tạo gần đây
  const [q3] = await conn.query(`
    SELECT COUNT(*) as c FROM recipes WHERE created_at >= NOW() - INTERVAL 1 DAY
  `);
  console.log('Recipes created in last 24h:', q3[0].c);

  await conn.end();
}
testExact67().catch(console.error);
