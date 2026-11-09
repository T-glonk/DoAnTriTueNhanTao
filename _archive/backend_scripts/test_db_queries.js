const mysql = require('mysql2/promise');

async function test() {
  const conn = await mysql.createConnection({
    host: 'localhost',
    port: 3307,
    user: 'root',
    password: '7855',
    database: 'foodai'
  });

  const [ech] = await conn.query('SELECT name, image_url FROM recipes WHERE name LIKE ? LIMIT 10;', ['%ếch%']);
  console.log('🐸 Món Ếch trong DB:', ech);

  const [suon] = await conn.query('SELECT name, image_url FROM recipes WHERE name LIKE ? LIMIT 10;', ['%sườn%']);
  console.log('🍖 Món Sườn trong DB:', suon);

  await conn.end();
}

test();
