const mysql = require('mysql2/promise');
async function find67() {
  const conn = await mysql.createConnection({
    host: 'localhost', port: 3307, user: 'root', password: '7855', database: 'foodai'
  });
  
  const queries = [
    "SELECT COUNT(*) as c FROM recipes WHERE author_name LIKE '%AI%'",
    "SELECT COUNT(*) as c FROM recipes WHERE author_name != 'Cookpad VN'",
    "SELECT COUNT(*) as c FROM recipes WHERE source_url LIKE '%foodai%'",
    "SELECT COUNT(*) as c FROM recipes WHERE image_url LIKE '%data:image%'",
    "SELECT COUNT(DISTINCT r.id) as c FROM recipes r JOIN recipe_ingredients ri ON r.id = ri.recipe_id",
    "SELECT COUNT(DISTINCT r.id) as c FROM recipes r WHERE EXISTS (SELECT 1 FROM recipe_ingredients ri WHERE ri.recipe_id = r.id)",
    "SELECT COUNT(DISTINCT r.id) as c FROM recipes r WHERE EXISTS (SELECT 1 FROM recipe_steps rs WHERE rs.recipe_id = r.id)",
    "SELECT COUNT(*) as c FROM recipes WHERE image_url LIKE '%cpcdn.com%'"
  ];

  for (const q of queries) {
    const [res] = await conn.query(q);
    console.log(q, '===>', res[0].c);
  }
  await conn.end();
}
find67().catch(console.error);
