const mysql = require('mysql2/promise');

async function main() {
  const conn = await mysql.createConnection({
    host: 'localhost',
    port: 3307,
    user: 'root',
    password: '7855',
    database: 'foodai'
  });

  const categories = {
    frog_dish: 'ếch',
    pork_ribs: 'sườn',
    eel_dish: 'lươn',
    duck_dish: 'vịt',
    chicken_porridge: 'cháo gà',
    porridge_general: 'cháo',
    chicken_salad: 'gỏi gà',
    salad_general: 'gỏi',
    egg_dish: 'trứng',
    egg_tomato: 'cà chua',
    fish_tuna: 'cá ngừ',
    fish_braised: 'cá kho',
    fish_fried: 'cá chiên',
    fish_soup: 'canh chua',
    shrimp_dish: 'tôm',
    squid_dish: 'mực',
    clam_snail_dish: 'nghêu',
    tofu_dish: 'đậu',
    beef_stir_fry: 'bò xào',
    beef_stew: 'bò kho',
    beef_soup: 'phở bò',
    pork_braised: 'thịt kho',
    pork_fried: 'thịt chiên',
    pork_soup: 'canh thịt',
    chicken_fried: 'gà chiên',
    chicken_braised: 'gà kho',
    chicken_soup: 'canh gà',
    veggie_stir_fry: 'rau muống xào',
    soup_general: 'canh',
    noodle_rice: 'cơm chiên',
    general_dish: 'cơm'
  };

  const results = {};

  for (const [cat, query] of Object.entries(categories)) {
    const [rows] = await conn.query(
      `SELECT name, image_url FROM recipes 
       WHERE name LIKE ? AND image_url LIKE '%cpcdn%' 
       LIMIT 4`,
      [`%${query}%`]
    );
    results[cat] = rows.map(r => ({ name: r.name, url: r.image_url }));
  }

  console.log(JSON.stringify(results, null, 2));
  await conn.end();
}

main().catch(console.error);
