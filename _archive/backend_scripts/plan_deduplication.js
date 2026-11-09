const mysql = require('mysql2/promise');

function removeAccents(str) {
  return str
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D')
    .toLowerCase();
}

function cleanTitle(str) {
  // Chuẩn hóa viết hoa chữ cái đầu mỗi từ quan trọng hoặc đầu câu
  let s = str.trim();
  s = s.replace(/\s+/g, ' ');
  return s.charAt(0).toUpperCase() + s.slice(1);
}

// Bảng ánh xạ các tên biến thể về Tên Món Ăn Chuẩn Nhất (Canonical Name)
const CANONICAL_MAP = [
  // Gà
  { pattern: /^(gà|thịt gà)\s+kho\s+gừng/i, canonical: 'Gà kho gừng' },
  { pattern: /gà\s+kho\s+gừng\s+thơm\s+lừng/i, canonical: 'Gà kho gừng' },
  { pattern: /công thức ướp.*gà/i, canonical: 'DELETE_COMBO' },
  { pattern: /cơm gà luộc và canh gà lá giang/i, canonical: 'DELETE_COMBO' },
  { pattern: /canh\s+gà\s+(nấu\s+)?lá\s+giang/i, canonical: 'Canh gà lá giang' },
  { pattern: /gỏi\s+gà.*cháo\s+gà/i, canonical: 'DELETE_COMBO' },
  { pattern: /gỏi\s+gà\s+bắp\s+cải/i, canonical: 'Gỏi gà bắp cải' },
  { pattern: /gỏi\s+gà\s+rau\s+mùi\s+trộn\s+bắp\s+cải/i, canonical: 'Gỏi gà bắp cải' },
  { pattern: /cánh\s+gà\s+chiên\s+giòn/i, canonical: 'Cánh gà chiên giòn' },
  { pattern: /cánh\s+gà\s+chiên\s+(giòn\s+)?nước\s+mắm/i, canonical: 'Cánh gà chiên nước mắm' },
  { pattern: /gà\s+chiên\s+nước\s+mắm/i, canonical: 'Cánh gà chiên nước mắm' },
  { pattern: /xôi\s+nghệ\s+gà\s+hấp/i, canonical: 'DELETE_COMBO' },
  { pattern: /gà\s+hấp\s+(muối\s+)?(sả\s+)?lá\s+chanh/i, canonical: 'Gà hấp lá chanh' },
  { pattern: /gà\s+xào\s+(sả|xả)\s+ớt/i, canonical: 'Gà xào sả ớt' },
  { pattern: /ức\s+gà\s+xào\s+(sả|xả)\s+ớt/i, canonical: 'Gà xào sả ớt' },
  { pattern: /gà\s+ác\s+tiềm/i, canonical: 'Gà ác tiềm thuốc bắc hạt sen' },
  
  // Bò
  { pattern: /bò\s+cuộn\s+nấm\s+kim\s+châm/i, canonical: 'Bò cuộn nấm kim châm' },
  { pattern: /^(thịt\s+)?bò\s+lúc\s+lắc$/i, canonical: 'Bò lúc lắc' },
  { pattern: /bò\s+xào\s+măng\s+tây/i, canonical: 'Bò xào măng tây' },
  { pattern: /bắp\s+bò\s+xào\s+măng\s+tây/i, canonical: 'Bò xào măng tây' },
  { pattern: /bò\s+kho\s+(tiêu|gừng|sả)/i, canonical: 'Bò kho' },
  { pattern: /bò\s+sốt\s+tiêu\s+đen/i, canonical: 'Bò sốt tiêu đen' },
  
  // Thịt Heo / Ba chỉ / Sườn
  { pattern: /sườn\s+(non\s+)?nướng\s+mật\s+ong/i, canonical: 'Sườn nướng mật ong' },
  { pattern: /sườn\s+(non\s+)?xào\s+chua\s+ngọt/i, canonical: 'Sườn xào chua ngọt' },
  { pattern: /sườn\s+xào\s+ớt\s+chuông\s+chua\s+ngọt/i, canonical: 'Sườn xào chua ngọt' },
  { pattern: /sườn\s+(non\s+)?kho\s+tiêu/i, canonical: 'Sườn non kho tiêu' },
  { pattern: /sườn\s+hầm\s+trái\s+vải/i, canonical: 'DELETE_COMBO' },
  { pattern: /(thịt\s+)?ba\s+chỉ\s+rang\s+cháy\s+cạnh/i, canonical: 'Thịt ba chỉ rang cháy cạnh' },
  { pattern: /thịt\s+(heo|lợn)\s+chiên\s+xù/i, canonical: 'Thịt heo chiên xù' },
  { pattern: /thịt\s+kho\s+tàu/i, canonical: 'Thịt kho tàu' },
  { pattern: /thịt\s+kho\s+trứng\s+cút/i, canonical: 'Thịt kho trứng cút' },
  { pattern: /thịt\s+kho\s+trứng/i, canonical: 'Thịt kho trứng' },
  { pattern: /thịt\s+kho\s+tiêu\s+.*đậu\s+bắp/i, canonical: 'DELETE_COMBO' },
  { pattern: /thịt\s+luộc\s+(cuốn\s+bánh\s+tráng\s+)?chấm\s+mắm\s+(nêm|tôm|mực)/i, canonical: 'Thịt luộc chấm mắm nêm' },
  { pattern: /bánh\s+tráng\s+(cuốn\s+)?thịt\s+luộc/i, canonical: 'Thịt luộc cuốn bánh tráng' },
  { pattern: /làm\s+chả\s+lụa\s+chiên/i, canonical: 'Chả lụa chiên' },

  // Hải sản / Tôm / Mực / Cá
  { pattern: /mực\s+chiên\s+nước\s+mắm/i, canonical: 'Mực chiên nước mắm' },
  { pattern: /tôm\s+(sú\s+)?hấp\s+(nước\s+dừa|sả|bia)/i, canonical: 'Tôm hấp sả' },
  { pattern: /tôm\s+(sú\s+)?nướng\s+muối\s+ớt/i, canonical: 'Tôm nướng muối ớt' },
  { pattern: /tôm\s+rim\s+mặn/i, canonical: 'Tôm rim mặn ngọt' },
  { pattern: /cá\s+nục\s+kho\s+(tiêu|rục|cà)/i, canonical: 'Cá nục kho cà' },
  { pattern: /cá\s+hú\s+kho\s+tộ/i, canonical: 'Cá hú kho tộ' },
  { pattern: /cá\s+basa\s+kho\s+tộ/i, canonical: 'Cá basa kho tộ' },
  { pattern: /cá\s+rô\s+kho\s+tộ/i, canonical: 'Cá rô kho tộ' },
  { pattern: /cá\s+lóc\s+kho\s+tộ/i, canonical: 'Cá lóc kho tộ' },

  // Canh / Rau
  { pattern: /canh\s+mướp\s+nấu\s+tôm/i, canonical: 'Canh mướp nấu tôm' },
  { pattern: /canh\s+bí\s+đỏ\s+nấu\s+tôm/i, canonical: 'Canh bí đỏ nấu tôm' },
  { pattern: /canh\s+bí\s+ngòi\s+nấu\s+tôm/i, canonical: 'Canh bí ngòi nấu tôm' },
  { pattern: /canh\s+ngao\s+chua/i, canonical: 'Canh ngao chua' },
  { pattern: /canh\s+cua\s+rau\s+đay/i, canonical: 'Canh cua rau đay mồng tơi' },
  { pattern: /canh\s+rau\s+ngót\s+thịt\s+bằm/i, canonical: 'Canh rau ngót nấu thịt băm' },
  { pattern: /rau\s+muống\s+xào\s+tỏi/i, canonical: 'Rau muống xào tỏi' },

  // Trứng / Đậu hũ
  { pattern: /trứng\s+(vịt\s+)?chiên\s+hành\s+lá/i, canonical: 'Trứng chiên hành lá' },
  { pattern: /trứng\s+(chiên\s+)?sốt\s+cà\s+chua/i, canonical: 'Trứng chiên sốt cà chua' },
  { pattern: /trứng\s+xào\s+cà\s+chua/i, canonical: 'Trứng xào cà chua' },
  { pattern: /trứng\s+ốp\s+la.*đậu\s+sốt\s+cà/i, canonical: 'DELETE_COMBO' },
  { pattern: /trứng\s+hấp\s+đậu\s+hũ/i, canonical: 'Trứng hấp đậu hũ' },
  { pattern: /đậu\s+hũ\s+nhồi\s+thịt\s+sốt\s+cà/i, canonical: 'Đậu hũ dồn thịt sốt cà chua' },
  { pattern: /đậu\s+phụ\s+sốt\s+cà\s+chua/i, canonical: 'Đậu hũ sốt cà chua' }
];

async function planDeduplication() {
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

  console.log(`📊 Tổng số món hiện tại: ${recipes.length}`);

  const groups = new Map();
  const toDeleteCombos = [];

  for (const r of recipes) {
    let matchedCanonical = null;

    for (const rule of CANONICAL_MAP) {
      if (rule.pattern.test(r.name)) {
        matchedCanonical = rule.canonical;
        break;
      }
    }

    if (matchedCanonical === 'DELETE_COMBO') {
      toDeleteCombos.push(r);
      continue;
    }

    if (matchedCanonical) {
      if (!groups.has(matchedCanonical)) {
        groups.set(matchedCanonical, []);
      }
      groups.get(matchedCanonical).push(r);
    }
  }

  console.log(`\n❌ Các món mâm cơm combo ghép cần xóa hoàn toàn (${toDeleteCombos.length} món):`);
  toDeleteCombos.forEach(r => console.log(`  - [ID: ${r.id}] "${r.name}"`));

  console.log(`\n✨ Các nhóm món ăn trùng lặp ngữ nghĩa được chuẩn hóa (${groups.size} nhóm):`);
  let duplicateCount = 0;
  for (const [canonicalName, items] of groups.entries()) {
    if (items.length > 1) {
      duplicateCount += (items.length - 1);
      console.log(`\n🍲 Nhóm "${canonicalName}" (${items.length} món):`);
      items.forEach(it => {
        console.log(`   - [ID: ${it.id}] "${it.name}" (Ảnh: ${it.image_url ? (it.image_url.startsWith('data:') ? 'Base64' : 'CDN') : 'NULL'}, NL: ${it.ing_count}, Bước: ${it.step_count})`);
      });
    }
  }

  console.log(`\n🎯 Dự kiến sẽ loại bỏ: ${toDeleteCombos.length} combo + ${duplicateCount} món trùng lặp = ${toDeleteCombos.length + duplicateCount} món dư thừa.`);
  console.log(`🎯 Số món chuẩn tinh gọn còn lại: ${recipes.length - toDeleteCombos.length - duplicateCount} món.`);

  await conn.end();
}

planDeduplication().catch(console.error);
