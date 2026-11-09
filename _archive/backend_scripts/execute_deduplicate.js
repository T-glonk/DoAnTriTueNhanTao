const mysql = require('mysql2/promise');

// Bảng quy tắc phân nhóm ngữ nghĩa và Tên Món Chuẩn (Canonical Name)
const SEMANTIC_RULES = [
  // MÂM CƠM COMBO / MẸO ƯỚP / NƯỚC SỐT CẦN XÓA
  { pattern: /công thức ướp.*gà/i, action: 'DELETE' },
  { pattern: /sốt sườn xào chua ngọt/i, action: 'DELETE' },
  { pattern: /cơm gà luộc và canh gà lá giang/i, action: 'DELETE' },
  { pattern: /gỏi gà.*cháo gà/i, action: 'DELETE' },
  { pattern: /sườn hầm trái vải và trứng hấp/i, action: 'DELETE' },
  { pattern: /thịt heo kho tiêu.*đậu bắp/i, action: 'DELETE' },
  { pattern: /trứng ốp la đám mây.*đậu sốt cà/i, action: 'DELETE' },
  { pattern: /trứng hấp đậu hũ trứng, nấm.*bắc thảo/i, action: 'DELETE' },
  { pattern: /xôi nghệ gà hấp/i, action: 'DELETE' },
  { pattern: /nay mình làm cá lóc hấp sả và thịt luộc/i, action: 'DELETE' },
  { pattern: /thịt kho trứng và canh cải cúc/i, action: 'DELETE' },

  // GÀ
  { pattern: /^(gà|thịt gà)\s+kho\s+gừng/i, canonical: 'Gà kho gừng', category: 'Món kho' },
  { pattern: /gà\s+kho\s+gừng\s+thơm\s+lừng/i, canonical: 'Gà kho gừng', category: 'Món kho' },
  { pattern: /canh\s+gà\s+(nấu\s+)?lá\s+giang/i, canonical: 'Canh gà lá giang', category: 'Súp/Canh' },
  { pattern: /gỏi\s+gà\s+(bắp\s+cải|rau\s+mùi|càng\s+cua)/i, canonical: 'Gỏi gà bắp cải', category: 'Salad' },
  { pattern: /^cánh\s+gà\s+chiên\s+giòn/i, canonical: 'Cánh gà chiên giòn', category: 'Món chiên' },
  { pattern: /cánh\s+gà\s+chiên\s+(giòn\s+)?nước\s+mắm/i, canonical: 'Cánh gà chiên nước mắm', category: 'Món chiên' },
  { pattern: /^gà\s+chiên\s+nước\s+mắm/i, canonical: 'Cánh gà chiên nước mắm', category: 'Món chiên' },
  { pattern: /gà\s+hấp\s+(muối\s+)?(sả\s+)?lá\s+chanh/i, canonical: 'Gà hấp lá chanh', category: 'Món hấp/luộc' },
  { pattern: /gà\s+(xào|kho)\s+(sả|xả)\s+ớt/i, canonical: 'Gà xào sả ớt', category: 'Món xào' },
  { pattern: /ức\s+gà\s+xào\s+(sả|xả)\s+ớt/i, canonical: 'Gà xào sả ớt', category: 'Món xào' },
  { pattern: /gà\s+ác\s+tiềm/i, canonical: 'Gà ác tiềm hạt sen', category: 'Món hầm/tiềm' },

  // BÒ
  { pattern: /bò\s+cuộn\s+nấm\s+kim\s+châm/i, canonical: 'Bò cuộn nấm kim châm', category: 'Món nướng' },
  { pattern: /^(thịt\s+)?bò\s+lúc\s+lắc$/i, canonical: 'Bò lúc lắc', category: 'Món xào' },
  { pattern: /(bắp\s+)?bò\s+xào\s+măng\s+tây/i, canonical: 'Bò xào măng tây', category: 'Món xào' },
  { pattern: /bò\s+kho\s+(tiêu|gừng)/i, canonical: 'Bò kho tiêu', category: 'Món kho' },

  // SƯỜN
  { pattern: /sườn\s+(non\s+)?nướng\s+mật\s+ong/i, canonical: 'Sườn nướng mật ong', category: 'Món nướng' },
  { pattern: /sườn\s+(non\s+)?(xào|kho|sốt)?\s*chua\s+ngọt/i, canonical: 'Sườn xào chua ngọt', category: 'Món xào' },
  { pattern: /sườn\s+(non|heo|sụn)?\s+kho\s+tiêu/i, canonical: 'Sườn non kho tiêu', category: 'Món kho' },

  // THỊT HEO / BA CHỈ
  { pattern: /(thịt\s+)?ba\s+chỉ\s+rang\s+cháy\s+cạnh/i, canonical: 'Thịt ba chỉ rang cháy cạnh', category: 'Món xào' },
  { pattern: /(cơm\s+)?thịt\s+(heo|lợn|chiên)\s+chiên\s+xù.*(tonkatsu|curry|cà ri|kiểu nhật)?/i, canonical: 'Thịt heo chiên xù Tonkatsu', category: 'Món chiên' },
  { pattern: /^thịt\s+chiên\s+xù/i, canonical: 'Thịt heo chiên xù', category: 'Món chiên' },
  { pattern: /thịt\s+kho\s+tàu/i, canonical: 'Thịt kho tàu', category: 'Món kho' },
  { pattern: /thịt\s+kho\s+trứng\s+cút/i, canonical: 'Thịt kho trứng cút', category: 'Món kho' },
  { pattern: /thịt\s+kho\s+trứng/i, canonical: 'Thịt kho trứng', category: 'Món kho' },
  { pattern: /thịt\s+luộc\s+(cuốn\s+bánh\s+tráng\s+)?chấm\s+mắm\s+(nêm|tôm|mực)/i, canonical: 'Thịt luộc chấm mắm nêm', category: 'Món hấp/luộc' },
  { pattern: /bánh\s+tráng\s+(cuốn\s+)?thịt\s+luộc/i, canonical: 'Bánh tráng cuốn thịt luộc', category: 'Món cuốn' },
  { pattern: /chả\s+lụa\s+chiên/i, canonical: 'Chả lụa chiên', category: 'Món chiên' },

  // TÔM / MỰC / CÁ / HẢI SẢN
  { pattern: /mực\s+chiên\s+nước\s+mắm/i, canonical: 'Mực chiên nước mắm', category: 'Món chiên' },
  { pattern: /tôm\s+(sú\s+)?(hấp\s+sả|hấp\s+bia|hấp\s+nước\s+dừa)/i, canonical: 'Tôm hấp sả', category: 'Món hấp/luộc' },
  { pattern: /tôm\s+(sú\s+)?nướng\s+muối\s+ớt/i, canonical: 'Tôm nướng muối ớt', category: 'Món nướng' },
  { pattern: /tôm\s+rim\s+mặn/i, canonical: 'Tôm rim mặn ngọt', category: 'Món kho' },
  { pattern: /tôm\s+(tẩm\s+bột\s+)?chiên\s+xù/i, canonical: 'Tôm chiên xù', category: 'Món chiên' },
  { pattern: /cá\s+nục\s+kho\s+(tiêu|rục|cà)/i, canonical: 'Cá nục kho cà', category: 'Món kho' },

  // CANH / RAU
  { pattern: /canh\s+mướp\s+nấu\s+tôm/i, canonical: 'Canh mướp nấu tôm', category: 'Súp/Canh' },
  { pattern: /canh\s+bí\s+đỏ\s+nấu\s+tôm/i, canonical: 'Canh bí đỏ nấu tôm', category: 'Súp/Canh' },
  { pattern: /canh\s+bí\s+ngòi\s+nấu\s+tôm/i, canonical: 'Canh bí ngòi nấu tôm', category: 'Súp/Canh' },
  { pattern: /canh\s+ngao\s+chua/i, canonical: 'Canh ngao chua', category: 'Súp/Canh' },
  { pattern: /rau\s+muống\s+xào\s+tỏi/i, canonical: 'Rau muống xào tỏi', category: 'Món xào' },
  { pattern: /vịt\s+om\s+sấu/i, canonical: 'Vịt om sấu', category: 'Súp/Canh' },
  { pattern: /ếch.*singapore.*kung\s+pao/i, canonical: 'Ếch xào Kung Pao', category: 'Món xào' },

  // TRỨNG / ĐẬU HŨ
  { pattern: /trứng\s+(vịt\s+)?chiên\s+hành\s+lá/i, canonical: 'Trứng chiên hành lá', category: 'Món chiên' },
  { pattern: /trứng\s+(chiên\s+)?sốt\s+cà\s+chua/i, canonical: 'Trứng chiên sốt cà chua', category: 'Món chiên' },
  { pattern: /^trứng\s+xào\s+cà\s+chua$/i, canonical: 'Trứng xào cà chua', category: 'Món xào' },
  { pattern: /đậu\s+(hũ|phụ)\s+sốt\s+cà\s+chua/i, canonical: 'Đậu hũ sốt cà chua', category: 'Món xào' },
  { pattern: /đậu\s+hũ\s+(dồn|nhồi)\s+thịt\s+sốt\s+cà/i, canonical: 'Đậu hũ dồn thịt sốt cà chua', category: 'Món xào' }
];

async function runDeduplication() {
  console.log('🚀 [Deduplication] Khởi chạy khử trùng lặp ngữ nghĩa kho món ăn...');
  const conn = await mysql.createConnection({
    host: 'localhost',
    port: 3307,
    user: 'root',
    password: '7855',
    database: 'foodai'
  });

  const [recipes] = await conn.query(`
    SELECT r.id, r.name, r.category, r.image_url, r.description,
      (SELECT COUNT(*) FROM recipe_ingredients ri WHERE ri.recipe_id = r.id) as ing_count,
      (SELECT COUNT(*) FROM recipe_steps rs WHERE rs.recipe_id = r.id) as step_count
    FROM recipes r
    ORDER BY r.name ASC
  `);

  console.log(`📊 Tổng số món ăn trước khi lọc: ${recipes.length}`);

  const deleteIds = new Set();
  const updateNames = new Map(); // id -> { newName, newCategory }

  // 1. Phân nhóm
  const groups = new Map();

  for (const r of recipes) {
    let matched = null;
    for (const rule of SEMANTIC_RULES) {
      if (rule.pattern.test(r.name)) {
        matched = rule;
        break;
      }
    }

    if (!matched) continue;

    if (matched.action === 'DELETE') {
      deleteIds.add(r.id);
      console.log(`🗑️ Đánh dấu xóa combo/mẹo: [${r.id}] "${r.name}"`);
      continue;
    }

    const key = matched.canonical;
    if (!groups.has(key)) {
      groups.set(key, { canonical: matched.canonical, category: matched.category, items: [] });
    }
    groups.get(key).items.push(r);
  }

  // 2. Với mỗi nhóm, chọn bản ghi tốt nhất và đánh dấu xóa các bản ghi còn lại
  for (const [canonicalName, group] of groups.entries()) {
    const items = group.items;
    if (items.length <= 1) {
      // Chỉ có 1 bản ghi trong nhóm: chuẩn hóa lại tên cho đẹp
      if (items.length === 1 && items[0].name !== canonicalName) {
        updateNames.set(items[0].id, { name: canonicalName, category: group.category || items[0].category });
      }
      continue;
    }

    // Chấm điểm từng bản ghi
    items.sort((a, b) => {
      let scoreA = 0;
      let scoreB = 0;

      // Ưu tiên bản ghi có đầy đủ nguyên liệu và bước
      scoreA += (a.ing_count * 10) + (a.step_count * 10);
      scoreB += (b.ing_count * 10) + (b.step_count * 10);

      // Ưu tiên có ảnh hợp lệ
      if (a.image_url && a.image_url.startsWith('data:')) scoreA += 50;
      else if (a.image_url && a.image_url.includes('cpcdn.com')) scoreA += 40;
      else if (a.image_url) scoreA += 20;

      if (b.image_url && b.image_url.startsWith('data:')) scoreB += 50;
      else if (b.image_url && b.image_url.includes('cpcdn.com')) scoreB += 40;
      else if (b.image_url) scoreB += 20;

      // Ưu tiên tên khớp chính xác hoặc ngắn gọn
      if (a.name.toLowerCase() === canonicalName.toLowerCase()) scoreA += 30;
      if (b.name.toLowerCase() === canonicalName.toLowerCase()) scoreB += 30;

      scoreA -= a.name.length;
      scoreB -= b.name.length;

      return scoreB - scoreA; // Giảm dần
    });

    const best = items[0];
    updateNames.set(best.id, { name: canonicalName, category: group.category || best.category });
    console.log(`\n👑 Giữ lại món tốt nhất: [${best.id}] "${best.name}" -> Chuẩn hóa: "${canonicalName}"`);

    // Các món còn lại trong nhóm sẽ bị xóa
    for (let i = 1; i < items.length; i++) {
      deleteIds.add(items[i].id);
      console.log(`   ❌ Xóa biến thể trùng: [${items[i].id}] "${items[i].name}"`);
    }
  }

  // 3. Thực thi cập nhật tên chuẩn cho các món giữ lại
  for (const [id, update] of updateNames.entries()) {
    if (!deleteIds.has(id)) {
      await conn.query('UPDATE recipes SET name = ?, category = ? WHERE id = ?', [update.name, update.category, id]);
    }
  }
  console.log(`\n✅ Đã cập nhật ${updateNames.size} món về tên gọi chuẩn ngữ nghĩa tiếng Việt.`);

  // 4. Thực thi xóa các bản ghi thừa
  const deleteList = Array.from(deleteIds);
  if (deleteList.length > 0) {
    // Xóa trong bảng con trước để an toàn (dù đã có cascade)
    await conn.query(`DELETE FROM recipe_ingredients WHERE recipe_id IN (?)`, [deleteList]);
    await conn.query(`DELETE FROM recipe_steps WHERE recipe_id IN (?)`, [deleteList]);
    await conn.query(`DELETE FROM recipe_nutrition WHERE recipe_id IN (?)`, [deleteList]);
    await conn.query(`DELETE FROM recipe_tags WHERE recipe_id IN (?)`, [deleteList]);
    
    // Xóa bảng chính recipes
    const [delRes] = await conn.query(`DELETE FROM recipes WHERE id IN (?)`, [deleteList]);
    console.log(`\n🔥 Đã xóa thành công ${delRes.affectedRows} món ăn trùng lặp ngữ nghĩa khỏi cơ sở dữ liệu!`);
  }

  // 5. Kiểm tra lại số lượng món ăn còn lại trong database
  const [finalCount] = await conn.query('SELECT COUNT(*) as count FROM recipes');
  console.log(`\n🎉 KHO MÓN ĂN SAU KHI TINH GỌN HOÀN TOÀN: ${finalCount[0].count} món chuẩn, không còn trùng lặp!`);

  await conn.end();
}

runDeduplication().catch(console.error);
