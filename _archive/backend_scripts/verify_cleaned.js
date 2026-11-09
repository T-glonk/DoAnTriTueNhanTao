const mysql = require('mysql2/promise');
async function check() {
  const conn = await mysql.createConnection({
    host: 'localhost', port: 3307, user: 'root', password: '7855', database: 'foodai'
  });
  const [rows] = await conn.query("SELECT id, name, category, image_url FROM recipes WHERE name LIKE '%gà%' OR name LIKE '%sườn%' OR name LIKE '%thịt kho%' ORDER BY name ASC");
  console.log(`Tổng số món liên quan đến Gà / Sườn / Thịt kho: ${rows.length}`);
  rows.forEach(r => console.log(` - ${r.name} | ${r.category} | Ảnh: ${r.image_url ? (r.image_url.startsWith('data:') ? 'Base64' : 'CDN') : 'NULL'}`));
  await conn.end();
}
check();
