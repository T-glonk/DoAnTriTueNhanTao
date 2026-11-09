const mysql = require('mysql2/promise');

function removeAccents(str) {
  return str
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D')
    .toLowerCase();
}

// Chuẩn hóa tên món ăn để rút ra "Tên chuẩn cốt lõi" (Core Dish Identity)
function extractCoreTokens(name) {
  let cleaned = name.toLowerCase();

  // Bỏ html entities & ký tự đặc biệt
  cleaned = cleaned.replace(/&amp;/g, ' ').replace(/[!?,;:()[\]{}"'`~@#$%^&*_\-+=/\\|<>\.]/g, ' ');

  // Loại bỏ các cụm từ hoa mỹ, cảm thán, dụng cụ, mẹo nấu
  const noisePhrases = [
    'thơm lừng', 'hao cơm lắm', 'hao cơm', 'đậm đà', 'chuẩn vị', 'siêu ngon', 'bất bại', 'đơn giản', 'cực ngon',
    'ngày mưa', 'dễ làm', 'ngon tuyệt', 'hấp dẫn', 'chuẩn mẹ nấu', 'tại nhà', 'ngon bất bại',
    'bằng nồi chiên không dầu', 'nồi chiên không dầu', 'nckd', 'bằng chảo chống dính', 'dùng nồi chiên không dầu',
    'eatclean', 'healthy', 'kfc', 'chua dịu nam bộ', 'nam bộ', 'kiểu hàn quốc', 'kiểu nhật', 'kiểu thái',
    'không bị khô', 'không bị ngấy', 'công thức ướp', 'cách làm', 'bí quyết', 'làm', 'công thức'
  ];

  for (const phrase of noisePhrases) {
    cleaned = cleaned.split(phrase).join(' ');
  }

  // Chuẩn hóa từ đồng nghĩa
  cleaned = cleaned
    .replace(/\bthịt gà\b/g, 'gà')
    .replace(/\bthịt bò\b/g, 'bò')
    .replace(/\bthịt lợn\b/g, 'thịt heo')
    .replace(/\bxả\b/g, 'sả');

  const words = cleaned.trim().split(/\s+/).filter(w => w.length > 0);
  return {
    cleanedName: words.join(' '),
    noAccent: removeAccents(words.join(' ')),
    tokens: new Set(words.map(w => removeAccents(w)))
  };
}

// Tính độ tương đồng Jaccard giữa 2 tập từ
function jaccardSimilarity(setA, setB) {
  let intersection = 0;
  for (const item of setA) {
    if (setB.has(item)) intersection++;
  }
  const union = new Set([...setA, ...setB]).size;
  return union === 0 ? 0 : intersection / union;
}

// Kiểm tra xem món A có phải là tập con hoặc biến thể trực tiếp của món B không
function isSemanticDuplicate(dishA, dishB) {
  const infoA = extractCoreTokens(dishA.name);
  const infoB = extractCoreTokens(dishB.name);

  // 1. Trùng 100% sau khi bỏ rác và bỏ dấu
  if (infoA.noAccent === infoB.noAccent) return true;

  // 2. Một tên chứa hoàn toàn tên kia (substring match ở cấp core)
  // Ví dụ: "ga kho gung" nằm trong "ga kho gung thom lung"
  if (infoA.noAccent.includes(infoB.noAccent) || infoB.noAccent.includes(infoA.noAccent)) {
    // Chỉ coi là trùng nếu độ lệch từ không quá lớn (ví dụ không phải "gà kho" với "gà kho nấm sả ớt nước dừa")
    const wordsA = infoA.noAccent.split(' ');
    const wordsB = infoB.noAccent.split(' ');
    const diff = Math.abs(wordsA.length - wordsB.length);
    if (diff <= 2) return true;
  }

  // 3. Jaccard similarity >= 0.7
  const sim = jaccardSimilarity(infoA.tokens, infoB.tokens);
  if (sim >= 0.7) return true;

  return false;
}

async function findClusters() {
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

  const visited = new Set();
  const clusters = [];

  for (let i = 0; i < recipes.length; i++) {
    if (visited.has(recipes[i].id)) continue;

    const cluster = [recipes[i]];
    visited.add(recipes[i].id);

    for (let j = i + 1; j < recipes.length; j++) {
      if (visited.has(recipes[j].id)) continue;

      if (isSemanticDuplicate(recipes[i], recipes[j])) {
        cluster.push(recipes[j]);
        visited.add(recipes[j].id);
      }
    }

    if (cluster.length > 1) {
      clusters.push(cluster);
    }
  }

  console.log(`🔍 Tìm thấy ${clusters.length} cụm món ăn bị trùng lặp ngữ nghĩa / biến thể:\n`);

  clusters.forEach((c, idx) => {
    console.log(`--- Cụm ${idx + 1} (${c.length} món) ---`);
    c.forEach(r => {
      console.log(`  * [${r.id}] "${r.name}" (${r.ing_count} NL, ${r.step_count} bước, Ảnh: ${r.image_url ? (r.image_url.startsWith('data:') ? 'Base64' : 'CDN') : 'NULL'})`);
    });
  });

  await conn.end();
}

findClusters().catch(console.error);
