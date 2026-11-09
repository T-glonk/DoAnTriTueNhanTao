const mysql = require('mysql2/promise');
async function findComBoXao() {
  const conn = await mysql.createConnection({
    host: 'localhost', port: 3307, user: 'root', password: '7855', database: 'foodai'
  });
  const [rows] = await conn.query("SELECT id, name, image_url, author_name FROM recipes WHERE name LIKE '%bò xào%' OR name LIKE '%bò áp chảo%'");
  console.log('Recipes in DB:', rows.length);
  rows.forEach(r => console.log('Recipe:', r.name, '| author:', r.author_name, '| image:', r.image_url));

  const [imgRows] = await conn.query("SELECT * FROM cookpad_dish_images WHERE recipe_title LIKE '%bò xào%' OR query_key LIKE '%bo xao%' LIMIT 10");
  console.log('\nCookpad images count:', imgRows.length);
  imgRows.forEach(r => console.log('Image:', r.recipe_title, '| url:', r.image_url));
  await conn.end();
}
findComBoXao();
