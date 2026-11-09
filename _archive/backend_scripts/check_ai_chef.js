const mysql = require('mysql2/promise');

async function main() {
  const conn = await mysql.createConnection({
    host: 'localhost',
    port: 3307,
    user: 'root',
    password: '7855',
    database: 'foodai'
  });

  const [rows] = await conn.query('SELECT id, name, image_url, author_name FROM recipes WHERE author_name LIKE "%AI Chef%"');
  console.log(`Found ${rows.length} AI Chef recipes:`);
  for (const r of rows) {
    console.log(`- ${r.name} -> ${r.image_url}`);
  }

  // Delete them because they were auto-generated with mismatched images
  if (rows.length > 0) {
    const ids = rows.map(r => r.id);
    await conn.query('DELETE FROM recipes WHERE id IN (?)', [ids]);
    console.log(`Cleaned up ${ids.length} unverified AI-generated recipes from database.`);
  }

  await conn.end();
}

main().catch(console.error);
