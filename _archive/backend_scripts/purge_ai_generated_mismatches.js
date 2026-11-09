const mysql = require('mysql2/promise');
const fs = require('fs');
const path = require('path');

async function purge() {
  const conn = await mysql.createConnection({
    host: 'localhost',
    port: 3307,
    user: 'root',
    password: '7855',
    database: 'foodai'
  });

  // Load all verified original names from JSON files
  const files = [
    path.resolve(__dirname, '../../../crawler/cookpad_recipes.json'),
    path.resolve(__dirname, '../../../crawler/cookpad_rare_recipes.json'),
    path.resolve(__dirname, '../../../crawler/seed_recipes.json')
  ];

  const verifiedNames = new Set();
  const verifiedMap = new Map();

  for (const f of files) {
    if (!fs.existsSync(f)) continue;
    const list = JSON.parse(fs.readFileSync(f, 'utf8'));
    for (const item of list) {
      if (item.name && item.image_url && !item.image_url.includes('unsplash.com')) {
        const clean = item.name.replace(/^[0-9.\-\s]+/, '').replace(/^Hình của món\s+/i, '').trim().toLowerCase();
        verifiedNames.add(clean);
        verifiedMap.set(clean, item.image_url);
      }
    }
  }

  console.log(`Verified canonical Cookpad dishes: ${verifiedNames.size}`);

  // Fetch all recipes in DB
  const [rows] = await conn.query('SELECT id, name, image_url FROM recipes');
  let deletedCount = 0;
  let fixedCount = 0;

  for (const r of rows) {
    const clean = r.name.replace(/^[0-9.\-\s]+/, '').replace(/^Hình của món\s+/i, '').trim().toLowerCase();
    if (!verifiedNames.has(clean)) {
      // Check if image URL slug is blatantly wrong
      const imgLower = decodeURIComponent(r.image_url || '').toLowerCase();
      // If name has ech but image has goi-tien-vua or canh-dua-top-mo or unsplash
      if (
        (clean.includes('ếch') && (imgLower.includes('goi-tien-vua') || imgLower.includes('canh-dua') || imgLower.includes('unsplash'))) ||
        imgLower.includes('unsplash')
      ) {
        await conn.query('DELETE FROM recipes WHERE id = ?', [r.id]);
        deletedCount++;
      }
    } else {
      // Ensure image is the verified Cookpad image
      const canonicalImg = verifiedMap.get(clean);
      if (canonicalImg && canonicalImg !== r.image_url) {
        await conn.query('UPDATE recipes SET image_url = ? WHERE id = ?', [canonicalImg, r.id]);
        fixedCount++;
      }
    }
  }

  console.log(`Purged ${deletedCount} poisoned recipes and fixed ${fixedCount} recipe images.`);

  // Also clean up cookpad_dish_images
  const [delImgs] = await conn.query('DELETE FROM cookpad_dish_images WHERE image_url LIKE "%unsplash%" OR image_url LIKE "%goi-tien-vua%" OR image_url LIKE "%canh-dưa-top-mỡ%" OR query_key LIKE "%cơm ngon nhà huý%"');
  console.log(`Cleaned ${delImgs.affectedRows} bad entries from cookpad_dish_images.`);

  await conn.end();
}

purge();
