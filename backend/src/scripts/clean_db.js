const mysql = require('mysql2/promise');

(async () => {
  try {
    const conn = await mysql.createConnection({
      host: 'localhost',
      port: 3307,
      user: 'root',
      password: '7855',
      database: 'foodai'
    });

    function removeAccents(str) {
      return str
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '')
        .replace(/đ/g, 'd')
        .replace(/Đ/g, 'D')
        .toLowerCase()
        .trim();
    }

    function upgradeUrl(url) {
      if (!url) return '';
      return url.replace(
        /\/(?:120x160[^\s"'/]*|179x133[^\s"'/]*|300x200[^\s"'/]*|300x220[^\s"'/]*|400x400[^\s"'/]*|600x440[^\s"'/]*|680x482[^\s"'/]*)\//,
        '/1200x630cq80/'
      );
    }

    function cleanName(n) {
      return n
        .replace(/^Hình ảnh của\s+/i, '')
        .replace(/^SP\.\d+\s*-\s*/i, '')
        .replace(/[\.]$/, '')
        .trim();
    }

    const [recipes] = await conn.query('SELECT id, name, image_url FROM recipes');
    console.log('Total recipes in DB:', recipes.length);

    for (const r of recipes) {
      const cName = cleanName(r.name);
      const cUrl = upgradeUrl(r.image_url);
      await conn.query('UPDATE recipes SET name = ?, image_url = ? WHERE id = ?', [cName, cUrl, r.id]);

      const normKey = removeAccents(cName);
      await conn.query(
        'INSERT IGNORE INTO cookpad_dish_images (query_key, image_url, recipe_title, source) VALUES (?, ?, ?, "cookpad")',
        [normKey, cUrl, cName]
      );
      await conn.query(
        'INSERT IGNORE INTO cookpad_dish_images (query_key, image_url, recipe_title, source) VALUES (?, ?, ?, "cookpad")',
        [cName.toLowerCase(), cUrl, cName]
      );
    }

    const [imgCount] = await conn.query('SELECT count(*) as cnt FROM cookpad_dish_images');
    console.log('Cleanup complete. Total cookpad dish images in DB:', imgCount[0].cnt);

    await conn.end();
  } catch (err) {
    console.error('Error during cleanup:', err);
  }
})();
