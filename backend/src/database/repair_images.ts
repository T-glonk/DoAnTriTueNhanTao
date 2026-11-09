import { getPool } from './db';
import { CATEGORY_IMAGE_REGISTRY, classifyRecipeImageCategory } from '../services/category_images';
import { isImageUrlConflicting, scoreRecipeCard, removeVietnameseAccents } from '../services/image.service';

/**
 * Chuẩn hóa và khắc phục các hình ảnh bị lỗi, thiếu hoặc xung đột trong CSDL MySQL
 * Chỉ sửa chữa những món ăn có hình ảnh không hợp lệ hoặc bị xung đột, giữ nguyên các ảnh chuẩn đã có.
 */
export async function repairAllRecipeImages(): Promise<void> {
  const pool = getPool();
  console.log('🔄 Đang quét và kiểm tra toàn bộ hình ảnh món ăn trong CSDL MySQL...');

  const [rows] = await pool.query<any[]>('SELECT id, name, category, image_url FROM recipes');
  let repairedCount = 0;

  for (const r of rows) {
    const isMissing = !r.image_url || r.image_url.trim() === '';
    const isUnsplash = r.image_url && r.image_url.includes('unsplash');
    const isConflict = r.image_url ? isImageUrlConflicting(r.image_url, r.name) : false;

    // Chỉ sửa nếu bị thiếu, bị dính Unsplash hoặc bị xung đột với tên món
    if (isMissing || isUnsplash || isConflict) {
      let chosenUrl: string | null = null;
      const normName = removeVietnameseAccents(r.name);

      // 1. Tìm trong cookpad_dish_images xem có ảnh chuẩn xác không
      const [exactImgs] = await pool.query<any[]>(
        'SELECT image_url, recipe_title FROM cookpad_dish_images WHERE query_key = ? OR query_key = ? LIMIT 5',
        [normName, r.name.toLowerCase()]
      );

      for (const item of exactImgs) {
        if (item.image_url && !isImageUrlConflicting(item.image_url, r.name)) {
          const score = scoreRecipeCard(item.recipe_title || normName, r.name);
          if (score >= 40) {
            chosenUrl = item.image_url;
            break;
          }
        }
      }

      // 2. Nếu chưa có, lấy từ CATEGORY_IMAGE_REGISTRY sạch
      if (!chosenUrl) {
        const cat = classifyRecipeImageCategory(r.name);
        const poolImgs = CATEGORY_IMAGE_REGISTRY[cat] || CATEGORY_IMAGE_REGISTRY['general_dish'] || [];
        const safeFallback = poolImgs.find(img => !isImageUrlConflicting(img, r.name));
        chosenUrl = safeFallback || poolImgs[0];
      }

      if (chosenUrl) {
        // Đảm bảo URL luôn ở độ phân giải 1200x630cq80
        chosenUrl = chosenUrl.replace(
          /\/(?:120x160[^\s"'/]*|179x133[^\s"'/]*|300x200[^\s"'/]*|300x220[^\s"'/]*|400x400[^\s"'/]*|600x440[^\s"'/]*|680x482[^\s"'/]*)\//,
          '/1200x630cq80/'
        );

        await pool.query('UPDATE recipes SET image_url = ? WHERE id = ?', [chosenUrl, r.id]);
        repairedCount++;
        console.log(`🔧 [Đã sửa ảnh] "${r.name}" -> ${chosenUrl}`);
      }
    }
  }

  if (repairedCount > 0) {
    console.log(`✅ Đã khắc phục thành công ${repairedCount} món ăn có ảnh không chuẩn.`);
  } else {
    console.log(`✅ Tất cả ${rows.length} món ăn trong MySQL đều đã có ảnh chuẩn xác, không có lỗi xung đột.`);
  }
}
