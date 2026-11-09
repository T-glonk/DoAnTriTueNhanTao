const { getPool } = require('../../dist/database/db');

async function inspect() {
  const pool = getPool();
  const [comboRows] = await pool.query(`
    SELECT id, name, image_url 
    FROM recipes 
    WHERE name LIKE '%+%' 
       OR name LIKE '%combo%' 
       OR name LIKE '%thực đơn%' 
       OR name LIKE '%bữa cơm%' 
       OR name LIKE '%mâm cơm%' 
       OR name LIKE '%thịt bò xào giá%' 
       OR name LIKE '%bò sốt vang%' 
       OR name LIKE '%thịt bò ba chỉ mỹ%' 
       OR name LIKE '%cá cơm chiên%' 
       OR name LIKE '%mì tôm%'
  `);
  console.log('Found', comboRows.length, 'polluted/combo recipes in DB:');
  for (const r of comboRows) {
    console.log('-', r.id, '|', r.name, '|', r.image_url);
  }
  process.exit(0);
}

inspect();
