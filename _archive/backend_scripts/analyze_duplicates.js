const mysql = require('mysql2/promise');

async function analyze() {
  const conn = await mysql.createConnection({
    host: 'localhost',
    port: 3307,
    user: 'root',
    password: '7855',
    database: 'foodai'
  });

  const [recipes] = await conn.query('SELECT id, name, category, image_url, description FROM recipes ORDER BY id ASC');
  console.log(`📊 Tổng số món hiện có: ${recipes.length}`);

  // Tìm các món liên quan đến 'gà', 'sườn', 'bò', 'heo', 'tôm', 'canh', 'cá' v.v.
  const gaRecipes = recipes.filter(r => /gà/i.test(r.name));
  console.log(`\n🍗 Các món Gà (${gaRecipes.length} món):`);
  gaRecipes.forEach(r => console.log(`  [ID: ${r.id}] ${r.name} | Ảnh: ${r.image_url ? r.image_url.substring(0, 45) + '...' : 'NULL'}`));

  await conn.end();
}

analyze().catch(console.error);
