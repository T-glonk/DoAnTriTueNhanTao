const { getPool } = require('../../dist/database/db');

async function cleanDatabase() {
  console.log('🧹 [Cleanup] Bắt đầu dọn dẹp cơ sở dữ liệu...');
  const pool = getPool();

  // 1. Xóa các món ăn do AI sinh ra khỏi bảng recipes (để chấm dứt vòng lặp ô nhiễm Grounded RAG)
  const [deleteRecipesResult] = await pool.query(
    'DELETE FROM recipes WHERE author_name = ? OR source_url LIKE ?',
    ['AI Chef & Nutritionist', '%foodai%']
  );
  console.log(`✅ [Recipes] Đã xóa ${deleteRecipesResult.affectedRows} món ăn do AI sinh ra khỏi bảng recipes.`);

  // 2. Xóa các bản ghi ảnh có nguồn 'ai' hoặc URL hỏng trong cookpad_dish_images
  const [deleteAiImagesResult] = await pool.query(
    'DELETE FROM cookpad_dish_images WHERE source = ? OR image_url LIKE ?',
    ['ai', '%5d54a22a89ee1915%']
  );
  console.log(`✅ [Cookpad Images] Đã xóa ${deleteAiImagesResult.affectedRows} ảnh lỗi/nguồn AI khỏi cookpad_dish_images.`);

  // 3. Xóa các bản ghi cookpad_dish_images chứa combo hoặc tiêu đề rác
  const [deleteGarbageResult] = await pool.query(
    `DELETE FROM cookpad_dish_images 
     WHERE recipe_title LIKE '%+%' 
        OR recipe_title LIKE '%bento%' 
        OR recipe_title LIKE '%mâm cơm%' 
        OR recipe_title LIKE '%bữa cơm%' 
        OR recipe_title LIKE '%combo%'
        OR query_key LIKE '%+%'`
  );
  console.log(`✅ [Cookpad Images] Đã dọn dẹp ${deleteGarbageResult.affectedRows} bản ghi tiêu đề combo/mâm cơm/bento khỏi cookpad_dish_images.`);

  // 4. Kiểm tra tổng số món ăn authentic còn lại trong CSDL
  const [countRecipes] = await pool.query('SELECT count(*) as count FROM recipes');
  const [countImages] = await pool.query('SELECT count(*) as count FROM cookpad_dish_images');
  console.log(`📊 Hiện tại CSDL còn lại: ${countRecipes[0].count} công thức chuẩn Cookpad và ${countImages[0].count} ảnh đĩa món ăn.`);

  process.exit(0);
}

cleanDatabase().catch(err => {
  console.error('❌ Lỗi khi dọn dẹp CSDL:', err);
  process.exit(1);
});
