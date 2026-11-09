const mysql = require('mysql2/promise');

function removeAccents(str) {
  return str
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D');
}

// Hàm chuẩn hóa tìm tên món ăn chuẩn (Canonical Root Name)
function getCanonicalDishName(rawName) {
  let name = rawName.trim();

  // Bỏ ký tự html entities
  name = name.replace(/&amp;/g, '&');

  // Loại bỏ các từ hoa mỹ, cảm thán, dụng cụ, mẹo:
  const stopPatterns = [
    /\b(thơm lừng|hao cơm|đậm đà|chuẩn vị|siêu ngon|bất bại|đơn giản|cực ngon|ngày mưa|dễ làm)\b/gi,
    /\b(bằng nồi chiên không dầu|nồi chiên không dầu|nckd|bằng chảo chống dính)\b/gi,
    /\b(eatclean|healthy|kfc|chua dịu nam bộ|nam bộ|kiểu hàn quốc|kiểu nhật|kiểu thái)\b/gi,
    /\b(không bị khô|không bị ngấy|tại nhà)\b/gi,
    /\b(công thức ướp|cách làm|bí quyết)\b/gi,
    /\b(thịt gà)\b/gi // Thịt gà -> Gà
  ];

  let cleaned = name;
  for (const pat of stopPatterns) {
    cleaned = cleaned.replace(pat, ' ');
  }

  // Dọn dẹp khoảng trắng, dấu ngoặc, dấu chấm than
  cleaned = cleaned.replace(/[!?,;()\[\]&+\-\/]/g, ' ').replace(/\s+/g, ' ').trim();

  return cleaned;
}

async function analyzeAll() {
  const conn = await mysql.createConnection({
    host: 'localhost',
    port: 3307,
    user: 'root',
    password: '7855',
    database: 'foodai'
  });

  const [recipes] = await conn.query(`
    SELECT r.id, r.name, r.category, r.image_url,
      (SELECT COUNT(*) FROM recipe_ingredients ri WHERE ri.recipe_id = r.id) as ing_count,
      (SELECT COUNT(*) FROM recipe_steps rs WHERE rs.recipe_id = r.id) as step_count
    FROM recipes r
    ORDER BY r.name ASC
  `);

  console.log(`📊 Tổng số món hiện có: ${recipes.length}`);

  // Phân tích các món ghép (" và ", " & ", " amp; ", " kèm ")
  const comboDishes = recipes.filter(r => /\b(và|kèm)\b/i.test(r.name) || /&|amp;/i.test(r.name));
  console.log(`\n🍱 Danh sách các món ghép / mâm cơm combo (${comboDishes.length} món):`);
  comboDishes.forEach(r => console.log(`  - [${r.id}] "${r.name}"`));

  // Phân tích các món có tên dài bất thường hoặc chứa từ quảng cáo / giật tít
  const buzzwordDishes = recipes.filter(r => 
    /\b(thơm lừng|hao cơm|bất bại|nckd|nồi chiên không dầu|kfc|eatclean|công thức|ngày mưa)\b/i.test(r.name)
  );
  console.log(`\n📢 Danh sách các món có tên giật tít / dụng cụ (${buzzwordDishes.length} món):`);
  buzzwordDishes.forEach(r => console.log(`  - [${r.id}] "${r.name}"`));

  await conn.end();
}

analyzeAll().catch(console.error);
