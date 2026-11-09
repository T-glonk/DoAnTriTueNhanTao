const https = require('https');
const mysql = require('mysql2/promise');
const { v4: uuidv4 } = require('uuid');

const KEYWORDS = [
  // --- TÔM & HẢI SẢN ---
  'tôm rim mặn ngọt', 'tôm hấp sả', 'tôm xào đậu bắp', 'canh tôm bí ngòi', 'tôm cuộn lá lốt',
  'tôm chiên xù', 'tôm sốt chua ngọt', 'tôm nướng muối ớt', 'tôm hấp nước dừa', 'canh rau ngót nấu tôm',
  'mực xào cần tỏi', 'mực hấp gừng sả', 'mực chiên nước mắm', 'nghêu hấp sả ớt', 'canh ngao nấu chua',

  // --- TRỨNG & ĐẬU PHỤ ---
  'trứng xào cà chua', 'canh trứng cà chua', 'trứng chiên hành lá', 'trứng cuộn',
  'trứng ốp la sốt cà', 'trứng hấp nấm', 'chả trứng hấp', 'trứng sốt cà chua',
  'đậu phụ sốt cà chua', 'đậu hũ chiên sả ớt', 'đậu non sốt nấm', 'canh đậu hũ rong biển', 'đậu hũ lướt ván',

  // --- RAU CỦ & CANH ---
  'rau muống xào tỏi', 'bí ngòi xào tỏi', 'đậu bắp xào tỏi', 'đậu bắp luộc', 'cải thìa xào nấm',
  'canh bí đỏ nấu tôm', 'canh mướp nấu tôm', 'nộm hoa chuối', 'gỏi ngó sen tôm',

  // --- BÒ ---
  'thịt bò xào cần tỏi', 'bò sốt vang', 'bò lúc lắc', 'bò cuộn nấm kim châm', 'bò xào măng tây',
  'thịt bò xào ớt chuông', 'phở bò truyền thống', 'canh dưa chua thịt bò',

  // --- GÀ ---
  'gà rang sả ớt', 'gà chiên nước mắm', 'gà kho gừng', 'canh gà lá giang', 'gà hấp lá chanh',
  'cánh gà chiên giòn', 'ức gà áp chảo sốt bơ tỏi', 'gỏi gà bắp cải',

  // --- HEO & SƯỜN ---
  'sườn xào chua ngọt', 'thịt kho tàu', 'thịt ba chỉ rang cháy cạnh', 'sườn kho tiêu',
  'thịt heo chiên xù', 'thịt nướng than hoa', 'thịt luộc chấm mắm tỏi', 'sườn non nướng mật ong',

  // --- CÁ ---
  'cá kho tộ', 'canh chua cá lóc', 'cá điêu hồng chiên giòn', 'cá thu sốt cà chua',
  'cá hấp xì dầu', 'cá hồi áp chảo sốt bơ tỏi', 'cá bớp nấu ngót', 'cá nục kho tiêu'
];

function cleanTitle(str) {
  if (!str) return '';
  return str
    .replace(/^Hình của món\s+/i, '')
    .replace(/^Hình ảnh của\s+/i, '')
    .replace(/^SP\.\d+\s*-\s*/i, '')
    .replace(/^(Món|Cách làm|Hướng dẫn nấu)\s+/i, '')
    .replace(/\s+(chuẩn vị|kiểu việt|đơn giản|nhanh gọn|thơm ngon|siêu ngon).*$/i, '')
    .trim();
}

function removeAccents(str) {
  return str.normalize('NFD').replace(/[\u0300-\u036f]/g, '').replace(/đ/g, 'd').replace(/Đ/g, 'D').toLowerCase().trim();
}

function detectCategory(name) {
  const n = name.toLowerCase();
  if (n.includes('canh') || n.includes('súp') || n.includes('soup')) return 'Súp/Canh';
  if (n.includes('kho') || n.includes('om') || n.includes('rim')) return 'Món kho';
  if (n.includes('xào') || n.includes('áp chảo')) return 'Món xào';
  if (n.includes('chiên') || n.includes('rán') || n.includes('quay')) return 'Món chiên';
  if (n.includes('nướng')) return 'Món nướng';
  if (n.includes('hấp') || n.includes('luộc')) return 'Món hấp/luộc';
  if (n.includes('gỏi') || n.includes('nộm') || n.includes('salad')) return 'Salad';
  if (n.includes('bún') || n.includes('phở') || n.includes('bánh mì') || n.includes('cơm')) return 'Ăn sáng';
  return 'Món chính';
}

function fetchCards(keyword) {
  return new Promise((resolve) => {
    const encoded = encodeURIComponent(keyword);
    const url = `https://cookpad.com/vn/tim-kiem/${encoded}`;
    const req = https.get(url, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36',
        'Accept-Language': 'vi-VN,vi;q=0.9,en-US;q=0.8',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8'
      },
      timeout: 4000
    }, (res) => {
      if (res.statusCode !== 200) return resolve([]);
      let html = '';
      res.on('data', chunk => html += chunk);
      res.on('end', () => {
        try {
          const cards = [];
          const imgRegex = /<img[^>]+src=["'](https:\/\/img-global\.cpcdn\.com\/recipes\/[a-zA-Z0-9_-]+\/[^"']+)["'][^>]*>/gi;
          let match;
          while ((match = imgRegex.exec(html)) !== null) {
            const tag = match[0];
            const src = match[1];
            const altMatch = tag.match(/alt=["']([^"']*)["']/i);
            let alt = altMatch ? cleanTitle(altMatch[1]) : '';
            if (alt && alt.length >= 4 && !alt.toLowerCase().includes('bento') && !alt.toLowerCase().includes('ăn dặm')) {
              const hqUrl = src.replace(/\/(?:120x160[^\s"'/]*|179x133[^\s"'/]*|300x200[^\s"'/]*|300x220[^\s"'/]*|400x400[^\s"'/]*|600x440[^\s"'/]*|680x482[^\s"'/]*)\//, '/1200x630cq80/');
              cards.push({ title: alt, imageUrl: hqUrl });
            }
          }
          resolve(cards);
        } catch(e) {
          resolve([]);
        }
      });
    });
    req.on('timeout', () => { req.destroy(); resolve([]); });
    req.on('error', () => resolve([]));
  });
}

(async () => {
  console.log('🚀 Bắt đầu thu thập các món ăn chuẩn Cookpad theo từng nhóm nguyên liệu...');
  const conn = await mysql.createConnection({
    host: 'localhost',
    port: 3307,
    user: 'root',
    password: '7855',
    database: 'foodai'
  });

  const seenNames = new Set();
  const seenImages = new Set();

  let insertedCount = 0;

  for (let i = 0; i < KEYWORDS.length; i++) {
    const kw = KEYWORDS[i];
    process.stdout.write(`[${i+1}/${KEYWORDS.length}] Cào "${kw}"... `);
    const cards = await fetchCards(kw);
    let addedKw = 0;

    for (const card of cards) {
      const norm = removeAccents(card.title);
      if (seenNames.has(norm) || seenImages.has(card.imageUrl)) continue;
      seenNames.add(norm);
      seenImages.add(card.imageUrl);

      const id = uuidv4();
      const cat = detectCategory(card.title);
      const cookingTime = [20, 25, 30, 35, 40][Math.floor(Math.random() * 5)];
      const difficulty = ['Dễ', 'Trung bình', 'Dễ', 'Trung bình', 'Khó'][Math.floor(Math.random() * 5)];

      // 1. Thêm vào recipes
      await conn.query(
        `INSERT IGNORE INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        [id, card.title, `Món ${card.title} thơm ngon, đậm đà chuẩn vị truyền thống Việt Nam.`, card.imageUrl, cookingTime, difficulty, '2-4 người', cat, `https://cookpad.com/vn/tim-kiem/${encodeURIComponent(kw)}`, 'Cookpad VN']
      );

      // 2. Thêm vào cookpad_dish_images
      await conn.query(
        `INSERT IGNORE INTO cookpad_dish_images (query_key, image_url, recipe_title, source) VALUES (?, ?, ?, "cookpad")`,
        [norm, card.imageUrl, card.title]
      );
      await conn.query(
        `INSERT IGNORE INTO cookpad_dish_images (query_key, image_url, recipe_title, source) VALUES (?, ?, ?, "cookpad")`,
        [card.title.toLowerCase(), card.imageUrl, card.title]
      );

      addedKw++;
      insertedCount++;
      if (addedKw >= 5) break; // Lấy tối đa 5 món xuất sắc nhất cho mỗi từ khóa
    }

    console.log(`+${addedKw} món`);
    await new Promise(r => setTimeout(r, 400));
  }

  const [totalR] = await conn.query('SELECT count(*) as count FROM recipes');
  const [totalI] = await conn.query('SELECT count(*) as count FROM cookpad_dish_images');
  console.log('\n🎉 Hoàn thành cập nhật! Tổng cộng:');
  console.log(`- Món ăn trong Database: ${totalR[0].count} món`);
  console.log(`- Hình ảnh Cookpad chuẩn: ${totalI[0].count} ảnh`);

  await conn.end();
})();
