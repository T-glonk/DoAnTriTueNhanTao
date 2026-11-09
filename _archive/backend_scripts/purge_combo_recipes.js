const { getPool } = require('../../dist/database/db');

async function purgeCombos() {
  const pool = getPool();

  // 1. Delete combo recipes from recipes table
  const [delRecipes] = await pool.query(`
    DELETE FROM recipes 
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
       OR name LIKE '% - %'
       OR name LIKE '%cơm nhà%'
       OR name LIKE '%ăn kèm%'
  `);
  console.log(`Deleted ${delRecipes.affectedRows} combo/polluted recipes from recipes table.`);

  // 2. Delete combo images from cookpad_dish_images
  const [delImgs] = await pool.query(`
    DELETE FROM cookpad_dish_images 
    WHERE recipe_title LIKE '%+%' 
       OR recipe_title LIKE '%combo%' 
       OR recipe_title LIKE '%thực đơn%' 
       OR recipe_title LIKE '%bữa cơm%' 
       OR recipe_title LIKE '%mâm cơm%' 
       OR recipe_title LIKE '%thịt bò xào giá%' 
       OR recipe_title LIKE '%bò sốt vang%' 
       OR recipe_title LIKE '%thịt bò ba chỉ mỹ%' 
       OR recipe_title LIKE '%cá cơm chiên%' 
       OR recipe_title LIKE '%mì tôm%'
       OR recipe_title LIKE '% - %'
       OR recipe_title LIKE '%cơm nhà%'
       OR query_key LIKE '%+%'
       OR query_key LIKE '%mì tôm%'
       OR query_key LIKE '%bò sốt vang%'
  `);
  console.log(`Deleted ${delImgs.affectedRows} combo/polluted images from cookpad_dish_images.`);

  const [totalR] = await pool.query('SELECT count(*) as cnt FROM recipes');
  const [totalI] = await pool.query('SELECT count(*) as cnt FROM cookpad_dish_images');
  console.log(`Remaining authentic single-dish recipes: ${totalR[0].cnt}`);
  console.log(`Remaining authentic single-dish images: ${totalI[0].cnt}`);

  process.exit(0);
}

purgeCombos();
