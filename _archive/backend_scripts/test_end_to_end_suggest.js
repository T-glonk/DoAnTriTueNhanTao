require('dotenv').config({ path: require('path').resolve(__dirname, '../../.env') });
const { suggestRecipes } = require('../../dist/services/recipe.service.js');
const { isImageUrlConflicting } = require('../../dist/services/image.service.js');

async function testQuery(ingredients, mode = 'ai') {
  console.log(`\n======================================================`);
  console.log(`🔍 KIỂM THỬ: [${ingredients.join(', ')}] | Chế độ: ${mode.toUpperCase()}`);
  console.log(`======================================================`);

  try {
    const result = await suggestRecipes(ingredients, 'test-user', 5, mode);
    console.log(`✅ Nguồn kết quả: ${result.source.toUpperCase()} | AI Enabled: ${result.ai_enabled}`);
    console.log(`Tổng số món gợi ý: ${result.recipes.length}`);

    let allPassed = true;
    for (let i = 0; i < result.recipes.length; i++) {
      const r = result.recipes[i];
      const conflict = isImageUrlConflicting(r.image_url, r.name);
      const isCookpad = r.image_url.includes('cpcdn.com');
      const passed = !conflict && isCookpad;

      if (!passed) allPassed = false;

      console.log(`\n[${i + 1}] ${r.name}`);
      console.log(`    - Danh mục: ${r.category} | Thời gian: ${r.cooking_time} phút | Độ khó: ${r.difficulty}`);
      console.log(`    - Tỷ lệ khớp: ${r.match_percentage}% (${r.matched_ingredients?.join(', ') || ''})`);
      console.log(`    - Ảnh: ${r.image_url}`);
      console.log(`    - Kiểm tra Cookpad CDN: ${isCookpad ? '✅ ĐẠT' : '❌ SAI'}`);
      console.log(`    - Xung đột tên/ảnh: ${conflict ? '❌ CÓ XUNG ĐỘT' : '✅ 100% TRÙNG KHỚP'}`);
      console.log(`    - AI Chef phân tích: ${r.ai_reasoning?.substring(0, 100)}...`);
    }

    console.log(`\n🎯 KẾT LUẬN TEST: ${allPassed ? '🎉 100% ĐẠT TIÊU CHUẨN CHUẨN XÁC' : '⚠️ CÓ MÓN CHƯA ĐẠT'}`);
    return allPassed;
  } catch (err) {
    console.error('❌ Lỗi khi thực hiện kiểm thử:', err);
    return false;
  }
}

async function run() {
  await testQuery(['sườn', 'ớt chuông'], 'ai');
  await testQuery(['ếch', 'sả', 'ớt'], 'ai');
  process.exit(0);
}

run();
