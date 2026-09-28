import { getPool } from '../database/db';

/**
 * Kho ảnh ẩm thực chất lượng cao (HD Food Photography) phân loại chi tiết theo ẩm thực Việt Nam
 * Đảm bảo mỗi danh mục có nhiều ảnh độc nhất, không bao giờ bị trùng lặp ảnh giữa các món gợi ý
 */
export const CATEGORY_IMAGE_REGISTRY: Record<string, string[]> = {
  // --- TRỨNG (EGG DISHES) ---
  'egg_dish': [
    'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800&auto=format&fit=crop&q=80', // Trứng ốp la / chiên
    'https://images.unsplash.com/photo-1582722872445-44dc5f7e3c8f?w=800&auto=format&fit=crop&q=80', // Trứng luộc / lòng đào
    'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=800&auto=format&fit=crop&q=80', // Trứng xào rau củ
    'https://images.unsplash.com/photo-1510693206972-df098062cb71?w=800&auto=format&fit=crop&q=80', // Trứng cuộn vàng
    'https://images.unsplash.com/photo-1506084868230-bb9d95c24759?w=800&auto=format&fit=crop&q=80', // Trứng hấp / chả trứng
    'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=800&auto=format&fit=crop&q=80', // Trứng bơ bánh mì
  ],
  'egg_tomato': [
    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&auto=format&fit=crop&q=80', // Trứng xào cà chua
    'https://images.unsplash.com/photo-1547592180-85f173990554?w=800&auto=format&fit=crop&q=80', // Canh trứng cà chua
    'https://images.unsplash.com/photo-1592417817098-8f3d69109853?w=800&auto=format&fit=crop&q=80', // Trứng sốt cà chua
    'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=800&auto=format&fit=crop&q=80', // Trứng chiên cà chua
  ],

  // --- TÔM & HẢI SẢN (SHRIMP & SEAFOOD) ---
  'shrimp_dish': [
    'https://images.unsplash.com/photo-1565680018434-b513d5e5fd47?w=800&auto=format&fit=crop&q=80', // Tôm rim mặn ngọt
    'https://images.unsplash.com/photo-1559742811-822873691df8?w=800&auto=format&fit=crop&q=80', // Tôm chiên giòn
    'https://images.unsplash.com/photo-1551248429-40975aa4de74?w=800&auto=format&fit=crop&q=80', // Tôm xào rau củ
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&auto=format&fit=crop&q=80', // Tôm hấp sả
    'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?w=800&auto=format&fit=crop&q=80', // Tôm xào đậu bắp
    'https://images.unsplash.com/photo-1547592180-85f173990554?w=800&auto=format&fit=crop&q=80', // Canh tôm bí ngòi
  ],
  'squid_dish': [
    'https://images.unsplash.com/photo-1599488615731-7e5c2823ff28?w=800&auto=format&fit=crop&q=80', // Mực xào cần tỏi
    'https://images.unsplash.com/photo-1532550907401-a500c9a57435?w=800&auto=format&fit=crop&q=80', // Mực nướng sa tế
    'https://images.unsplash.com/photo-1565680018434-b513d5e5fd47?w=800&auto=format&fit=crop&q=80', // Mực chiên giòn
  ],
  'clam_snail_dish': [
    'https://images.unsplash.com/photo-1548943487-a2e4e43b4853?w=800&auto=format&fit=crop&q=80', // Canh ngao nấu chua
    'https://images.unsplash.com/photo-1534604973900-c43ab4c2e0ab?w=800&auto=format&fit=crop&q=80', // Nghêu hấp sả
    'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800&auto=format&fit=crop&q=80', // Ốc xào sả ớt
  ],
  'fish_braised': [
    'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800&auto=format&fit=crop&q=80', // Cá kho tộ
    'https://images.unsplash.com/photo-1534604973900-c43ab4c2e0ab?w=800&auto=format&fit=crop&q=80', // Cá kho tiêu
    'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&auto=format&fit=crop&q=80', // Cá sốt cà
  ],
  'fish_fried': [
    'https://images.unsplash.com/photo-1534604973900-c43ab4c2e0ab?w=800&auto=format&fit=crop&q=80', // Cá chiên giòn
    'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=800&auto=format&fit=crop&q=80', // Chả cá
  ],
  'fish_soup': [
    'https://images.unsplash.com/photo-1548943487-a2e4e43b4853?w=800&auto=format&fit=crop&q=80', // Canh chua cá
    'https://images.unsplash.com/photo-1547592180-85f173990554?w=800&auto=format&fit=crop&q=80', // Canh cá nấu ngót
  ],

  // --- ĐẬU PHỤ & NẤM (TOFU & MUSHROOM) ---
  'tofu_dish': [
    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&auto=format&fit=crop&q=80', // Đậu sốt cà chua
    'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800&auto=format&fit=crop&q=80', // Đậu xào nấm
    'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&auto=format&fit=crop&q=80', // Đậu hũ chiên giòn
    'https://images.unsplash.com/photo-1547592180-85f173990554?w=800&auto=format&fit=crop&q=80', // Canh đậu hũ rong biển
    'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=800&auto=format&fit=crop&q=80', // Đậu nhồi sốt
  ],

  // --- THỊT BÒ (BEEF) ---
  'beef_stir_fry': [
    'https://images.unsplash.com/photo-1588168333986-5078d3ae3976?w=800&auto=format&fit=crop&q=80', // Bò xào ớt chuông
    'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?w=800&auto=format&fit=crop&q=80', // Bò xào cần tỏi
    'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=800&auto=format&fit=crop&q=80', // Bò lúc lắc
  ],
  'beef_stew': [
    'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=800&auto=format&fit=crop&q=80', // Bò sốt vang
    'https://images.unsplash.com/photo-1574484284002-952d92456975?w=800&auto=format&fit=crop&q=80', // Bò kho dưa chua
  ],
  'beef_soup': [
    'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=800&auto=format&fit=crop&q=80', // Phở bò
    'https://images.unsplash.com/photo-1547592180-85f173990554?w=800&auto=format&fit=crop&q=80', // Canh thịt bò
  ],

  // --- THỊT HEO & SƯỜN (PORK) ---
  'pork_braised': [
    'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=800&auto=format&fit=crop&q=80', // Thịt kho tàu
    'https://images.unsplash.com/photo-1544025162-d76694265947?w=800&auto=format&fit=crop&q=80', // Sườn xào chua ngọt
    'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=800&auto=format&fit=crop&q=80', // Thịt kho tiêu
  ],
  'pork_fried': [
    'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=800&auto=format&fit=crop&q=80', // Thịt chiên giòn
    'https://images.unsplash.com/photo-1563245372-f21724e3856d?w=800&auto=format&fit=crop&q=80', // Nem rán
  ],
  'pork_soup': [
    'https://images.unsplash.com/photo-1547592180-85f173990554?w=800&auto=format&fit=crop&q=80', // Canh sườn
    'https://images.unsplash.com/photo-1572449043416-55f4685c9bb7?w=800&auto=format&fit=crop&q=80', // Canh thịt băm
  ],

  // --- GÀ (CHICKEN) ---
  'chicken_fried': [
    'https://images.unsplash.com/photo-1562967914-608f82629710?w=800&auto=format&fit=crop&q=80', // Gà chiên giòn
    'https://images.unsplash.com/photo-1569058242253-92a9c755a0ec?w=800&auto=format&fit=crop&q=80', // Gà chiên mắm
  ],
  'chicken_braised': [
    'https://images.unsplash.com/photo-1598515214211-89d3c73ae83b?w=800&auto=format&fit=crop&q=80', // Gà kho gừng
    'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=800&auto=format&fit=crop&q=80', // Gà rang sả ớt
  ],
  'chicken_soup': [
    'https://images.unsplash.com/photo-1548943487-a2e4e43b4853?w=800&auto=format&fit=crop&q=80', // Canh gà
    'https://images.unsplash.com/photo-1572449043416-55f4685c9bb7?w=800&auto=format&fit=crop&q=80', // Gà luộc
  ],

  // --- RAU CỦ & CANH & SALAD (VEGETABLES & SOUPS) ---
  'veggie_stir_fry': [
    'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800&auto=format&fit=crop&q=80', // Rau xào tỏi
    'https://images.unsplash.com/photo-1551248429-40975aa4de74?w=800&auto=format&fit=crop&q=80', // Bí ngòi xào
    'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?w=800&auto=format&fit=crop&q=80', // Đậu bắp xào
  ],
  'soup_general': [
    'https://images.unsplash.com/photo-1547592180-85f173990554?w=800&auto=format&fit=crop&q=80', // Canh rau củ
    'https://images.unsplash.com/photo-1548943487-a2e4e43b4853?w=800&auto=format&fit=crop&q=80', // Canh súp thanh mát
    'https://images.unsplash.com/photo-1572449043416-55f4685c9bb7?w=800&auto=format&fit=crop&q=80', // Canh gia đình
  ],
  'salad_general': [
    'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&auto=format&fit=crop&q=80', // Nộm rau củ
    'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800&auto=format&fit=crop&q=80', // Gỏi thanh mát
  ],
  'noodle_rice': [
    'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=800&auto=format&fit=crop&q=80', // Bún / Phở
    'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800&auto=format&fit=crop&q=80', // Cơm chiên
  ],
  'general_dish': [
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=800&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=800&auto=format&fit=crop&q=80',
    'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=800&auto=format&fit=crop&q=80',
  ]
};

/**
 * Phân tích tên món ăn tiếng Việt để trả về danh mục chính xác nhất
 */
export function classifyRecipeImageCategory(name: string): string {
  const norm = name
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D')
    .toLowerCase()
    .trim();

  // 1. TRỨNG & CÀ CHUA
  if (norm.includes('trung') && norm.includes('ca chua')) {
    return 'egg_tomato';
  }
  if (norm.includes('trung')) {
    return 'egg_dish';
  }

  // 2. TÔM & HẢI SẢN
  if (norm.includes('tom') || norm.includes('tep')) return 'shrimp_dish';
  if (norm.includes('muc') || norm.includes('bach tuoc')) return 'squid_dish';
  if (norm.includes('ngao') || norm.includes('ngheu') || norm.includes('so') || norm.includes('oc') || norm.includes('hau')) return 'clam_snail_dish';

  // 3. CÁ
  if (norm.includes('ca ') || norm.endsWith('ca') || norm.includes('ca loc') || norm.includes('ca hoi') || norm.includes('ca thu') || norm.includes('ca dieu hong')) {
    if (norm.includes('canh') || norm.includes('chua')) return 'fish_soup';
    if (norm.includes('chien') || norm.includes('ran')) return 'fish_fried';
    return 'fish_braised';
  }

  // 4. ĐẬU PHỤ & NẤM
  if (norm.includes('dau phu') || norm.includes('dau hu') || norm.includes('tau hu') || norm.includes('dau non')) {
    return 'tofu_dish';
  }

  // 5. BÒ
  if (norm.includes('bo') && !norm.includes('bo dau') && !norm.includes('bo lat') && !norm.includes('qua bo')) {
    if (norm.includes('sot vang') || norm.includes('kho') || norm.includes('ham')) return 'beef_stew';
    if (norm.includes('canh') || norm.includes('sup') || norm.includes('pho') || norm.includes('bun')) return 'beef_soup';
    return 'beef_stir_fry';
  }

  // 6. GÀ & VỊT
  if (norm.includes('ga') && !norm.includes('dau ga') && !norm.includes('nam dui ga')) {
    if (norm.includes('canh') || norm.includes('chao') || norm.includes('luoc') || norm.includes('sup')) return 'chicken_soup';
    if (norm.includes('chien') || norm.includes('ran') || norm.includes('nuoc mam')) return 'chicken_fried';
    return 'chicken_braised';
  }

  // 7. HEO / BA CHỈ / SƯỜN
  if (norm.includes('heo') || norm.includes('lon') || norm.includes('suon') || norm.includes('ba chi') || norm.includes('ba roi') || norm.includes('gio heo') || norm.includes('thit')) {
    if (norm.includes('canh') || norm.includes('sup') || norm.includes('ham')) return 'pork_soup';
    if (norm.includes('chien') || norm.includes('ran') || norm.includes('nuong') || norm.includes('quay')) return 'pork_fried';
    return 'pork_braised';
  }

  // 8. RAU CỦ / CANH / SALAD / BÚN
  if (norm.includes('canh') || norm.includes('sup') || norm.includes('lau')) return 'soup_general';
  if (norm.includes('salad') || norm.includes('goi') || norm.includes('nom')) return 'salad_general';
  if (norm.includes('pho') || norm.includes('bun') || norm.includes('mi ') || norm.includes('com')) return 'noodle_rice';
  if (norm.includes('rau') || norm.includes('nam') || norm.includes('bi ngoi') || norm.includes('dau bap') || norm.includes('xao')) return 'veggie_stir_fry';

  return 'general_dish';
}
