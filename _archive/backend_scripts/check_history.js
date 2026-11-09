const mysql = require('mysql2/promise');
async function checkHistory() {
  const conn = await mysql.createConnection({
    host: 'localhost', port: 3307, user: 'root', password: '7855', database: 'foodai'
  });
  const [rows] = await conn.query(`
    SELECT DATE_FORMAT(created_at, '%Y-%m-%d %H:%i') as minute, COUNT(*) as count
    FROM recipes
    GROUP BY minute
    ORDER BY minute DESC
    LIMIT 20
  `);
  console.log('Recipes added by minute:');
  rows.forEach(r => console.log(' ', r.minute, '->', r.count, 'món'));
  await conn.end();
}
checkHistory().catch(console.error);
