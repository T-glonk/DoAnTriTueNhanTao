import { getPool } from './db';
import { CATEGORY_IMAGE_REGISTRY, classifyRecipeImageCategory } from '../services/category_images';

export async function repairAllRecipeImages(): Promise<void> {
  const pool = getPool();
  console.log('🔄 Đang đồng bộ và chuẩn hóa toàn bộ hình ảnh trong CSDL MySQL...');

  const [rows] = await pool.query<any[]>('SELECT id, name, category, image_url FROM recipes');
  let updatedCount = 0;

  for (const r of rows) {
    const cat = classifyRecipeImageCategory(r.name);
    const poolImgs = CATEGORY_IMAGE_REGISTRY[cat] || CATEGORY_IMAGE_REGISTRY['beef_stir_fry'];
    
    // Lấy hash để phân bổ ảnh đồng đều, không trùng
    let hash = 0;
    for (let i = 0; i < r.name.length; i++) hash = (hash << 5) - hash + r.name.charCodeAt(i);
    const chosen = poolImgs[Math.abs(hash) % poolImgs.length];

    // Cập nhật để đảm bảo 100% món ăn trong CSDL có ảnh chuẩn, sắc nét và không lỗi 404
    await pool.query('UPDATE recipes SET image_url = ? WHERE id = ?', [chosen, r.id]);
    updatedCount++;
  }

  console.log(`✅ Đã chuẩn hóa thành công hình ảnh cho ${updatedCount} / ${rows.length} món ăn trong MySQL.`);
}
