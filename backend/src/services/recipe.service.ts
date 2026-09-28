import { getPool } from '../database/db';
import { Recipe } from '../types';
import { v4 as uuidv4 } from 'uuid';
import { suggestWithGemini, isAiEnabled } from './gemini.service';
import { extractPrimaryIngredients } from './image.service';

export interface IngredientDetail {
  name: string;
  raw_text: string;
  quantity: string;
  matched: boolean;
}

export interface MatchedRecipe extends Recipe {
  match_percentage: number;
  matched_count: number;
  total_ingredients: number;
  matched_ingredients: string[];
  missing_ingredients: string[];
  ingredients_detail: IngredientDetail[];
  steps_detail: Array<{ step_number: number; instruction: string; step_image_url?: string }>;
  source_url?: string;
  author_name?: string;
  source: 'database' | 'ai';
}

/**
 * Loại bỏ dấu tiếng Việt để so khớp không phân biệt dấu
 */
export function removeVietnameseAccents(str: string): string {
  return str
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D')
    .toLowerCase()
    .trim();
}

/**
 * Kiểm tra xem chuỗi văn bản có chứa từ mục tiêu dưới dạng từ nguyên vẹn (Whole word)
 * Đồng thời ngăn chặn triệt để các trường hợp nhầm lẫn gia vị / cụm từ ghép đặc biệt
 */
export function containsWord(fullText: string, targetWord: string): boolean {
  const f = removeVietnameseAccents(fullText);
  const t = removeVietnameseAccents(targetWord);

  if (!f || !t) return false;

  // 1. Kiểm tra các ngoại lệ dính chữ đặc thù tiếng Việt
  if (t === 'tom' && (f.includes('mam tom') || f.includes('muoi tom') || f.includes('mam ruoc') || f.includes('tom chua') || f.includes('mam tep') || f.includes('mi tom') || f.includes('kho quet'))) {
    return false;
  }
  if (t === 'bo' && (f.includes('bo toi') || f.includes('bo lat') || f.includes('qua bo') || f.includes('trai bo') || f.includes('bo thuc vat') || f.includes('bo cuoi') || f.includes('bo huc'))) {
    return false;
  }
  if (t === 'ca' && (f.includes('ca chua') || f.includes('ca tim') || f.includes('ca rot') || f.includes('ca ri') || f.includes('ca phao') || f.includes('ca bien') || f.includes('nuoc mam'))) {
    return false;
  }
  if (t === 'ga' && (f.includes('dau ga') || f.includes('nam dui ga') || f.includes('hat nem ga') || f.includes('bot nem ga') || f.includes('nuoc cot ga'))) {
    return false;
  }
  if ((t === 'hau' || t === 'con hau') && (f.includes('dau hao') || f.includes('sot dau hao'))) {
    return false;
  }
  if (t === 'la lot' && (f.includes('la mo') || f.includes('la chuoi') || f.includes('la giang') || f.includes('la dong') || f.includes('tia to'))) {
    return false;
  }
  if (t === 'tia to' && (f.includes('la lot') || f.includes('la mo') || f.includes('la chuoi') || f.includes('la giang'))) {
    return false;
  }
  if (t === 'dau bap' && (f.includes('bap cai') || f.includes('bap ngo') || f.includes('ngo non'))) {
    return false;
  }
  if (t === 'bi ngoi' && (f.includes('bi do') || f.includes('bi xanh') || f.includes('bi dao'))) {
    return false;
  }

  // Nếu targetWord có nhiều từ (vd: "thịt bò", "măng chua", "hoa chuối", "đậu bắp")
  if (t.includes(' ')) {
    return f.includes(t);
  }

  // Nếu là từ đơn (vd: "bò", "gà", "ốc", "dê", "vịt", "mực", "tôm") -> Khớp ranh giới từ
  const escaped = t.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const regex = new RegExp(`(^|[^a-z0-9])${escaped}([^a-z0-9]|$)`, 'i');
  return regex.test(f);
}

/**
 * Từ điển các nhóm nguyên liệu đồng nghĩa và biến thể ẩm thực Việt Nam
 */
export const INGREDIENT_GROUPS: Array<{ key: string; variants: string[]; excludes?: string[] }> = [
  {
    key: 'thịt heo',
    variants: ['thịt heo', 'thịt lợn', 'heo', 'lợn', 'ba chỉ heo', 'ba chỉ', 'thịt ba chỉ', 'ba rọi', 'nạc heo', 'nạc vai', 'sườn heo', 'sườn non', 'sườn', 'giò heo', 'chân giò', 'giò', 'thịt nạc', 'thịt băm', 'tai heo', 'thịt xay'],
    excludes: ['mắm nêm', 'mắm tôm', 'bột ngọt']
  },
  {
    key: 'thịt bò',
    variants: ['thịt bò', 'thăn bò', 'bắp bò', 'nạm bò', 'gầu bò', 'ba chỉ bò', 'gân bò', 'đuôi bò', 'bò'],
    excludes: ['bơ', 'bơ tỏi', 'bơ lạt', 'quả bơ', 'trái bơ', 'bò húc', 'bò cười', 'pho mát', 'bo toi', 'bo lat', 'bo thuc vat']
  },
  {
    key: 'thịt gà',
    variants: ['thịt gà', 'ức gà', 'đùi gà', 'cánh gà', 'gà ta', 'gà ác', 'gà'],
    excludes: ['đậu gà', 'nấm đùi gà', 'trứng gà', 'hạt nêm gà', 'bột nêm gà', 'nước cốt gà', 'dau ga', 'nam dui ga']
  },
  {
    key: 'thịt vịt',
    variants: ['thịt vịt', 'vịt cỏ', 'vịt xiêm', 'vịt quay', 'vịt om', 'vịt'],
    excludes: ['trứng vịt', 'trứng vịt lộn', 'hột vịt', 'hột vịt muối']
  },
  {
    key: 'thịt dê',
    variants: ['thịt dê', 'dê núi', 'dê']
  },
  {
    key: 'thịt ếch',
    variants: ['thịt ếch', 'đùi ếch', 'ếch đồng', 'ếch']
  },
  {
    key: 'lươn',
    variants: ['thịt lươn', 'lươn đồng', 'lươn']
  },
  {
    key: 'ốc',
    variants: ['thịt ốc', 'ốc bươu', 'ốc nhồi', 'ốc móng tay', 'ốc hương', 'ốc gạo', 'chả ốc', 'ốc']
  },
  {
    key: 'hàu',
    variants: ['hàu sữa', 'hàu tươi', 'hàu sống', 'hàu', 'con hàu'],
    excludes: ['dầu hào', 'sốt dầu hào', 'dau hao']
  },
  {
    key: 'ngao',
    variants: ['ngao trắng', 'ngao hoa', 'sò lụa', 'sò huyết', 'ngao', 'nghêu']
  },
  {
    key: 'mực',
    variants: ['mực ống', 'mực lá', 'mực tươi', 'mực xào', 'mực']
  },
  {
    key: 'bạch tuộc',
    variants: ['bạch tuộc tươi', 'bạch tuộc baby', 'bạch tuộc', 'râu mực']
  },
  {
    key: 'tôm',
    variants: ['tôm sú', 'tôm thẻ', 'tôm đất', 'tôm nõn', 'tôm tươi', 'tôm sống', 'tôm'],
    excludes: ['mắm tôm', 'muối tôm', 'mắm ruốc', 'tôm chua', 'mắm tép', 'mì tôm', 'kho quẹt', 'mam tom', 'muoi tom', 'mam ruoc']
  },
  {
    key: 'cá',
    variants: ['cá lóc', 'cá basa', 'cá hồi', 'cá thu', 'cá diêu hồng', 'cá chép', 'cá rô', 'cá quả', 'cá trê', 'cá bớp', 'cá nục', 'cá trích', 'cá'],
    excludes: ['cà chua', 'cà tím', 'cà rốt', 'cà ri', 'cà pháo', 'ca chua', 'ca tim', 'ca rot', 'ca ri', 'ca phao', 'nước mắm', 'nuoc mam']
  },
  {
    key: 'trứng',
    variants: ['trứng gà', 'trứng vịt', 'trứng cút', 'trứng']
  },
  {
    key: 'đậu phụ',
    variants: ['đậu hũ', 'tàu hũ', 'đậu phụ', 'đậu khuôn', 'đậu non']
  },
  {
    key: 'cà chua',
    variants: ['cà chua bi', 'cà chua', 'trái cà chua']
  },
  {
    key: 'khổ qua',
    variants: ['khổ qua', 'mướp đắng', 'trái khổ qua']
  },
  {
    key: 'măng tây',
    variants: ['măng tây xanh', 'măng tây']
  },
  {
    key: 'hoa chuối',
    variants: ['hoa chuối', 'bắp chuối', 'bông chuối']
  },
  {
    key: 'dọc mùng',
    variants: ['dọc mùng', 'bạc hà']
  },
  {
    key: 'củ dền',
    variants: ['củ dền đỏ', 'củ dền', 'beetroot']
  },
  {
    key: 'bí ngòi',
    variants: ['bí ngòi xanh', 'bí ngòi vàng', 'bí ngòi'],
    excludes: ['bí đỏ', 'bí xanh', 'bí đao', 'bi do', 'bi xanh', 'bi dao']
  },
  {
    key: 'đậu bắp',
    variants: ['đậu bắp non', 'đậu bắp'],
    excludes: ['bắp cải', 'bắp ngô', 'bap cai', 'bap ngo', 'ngô']
  },
  {
    key: 'lá lốt',
    variants: ['lá lốt tươi', 'lá lốt', 'lá lốp'],
    excludes: ['lá mơ', 'la mo', 'lá chuối', 'la chuoi', 'lá giang', 'la giang', 'lá dong', 'la dong', 'tía tô', 'tia to']
  },
  {
    key: 'ngải cứu',
    variants: ['ngải cứu tươi', 'ngải cứu', 'rau ngải']
  },
  {
    key: 'tía tô',
    variants: ['lá tía tô', 'tía tô'],
    excludes: ['lá lốt', 'la lot', 'lá mơ', 'la mo', 'lá giang', 'la giang']
  },
  {
    key: 'lá giang',
    variants: ['lá giang tươi', 'lá giang chua', 'lá giang'],
    excludes: ['lá lốt', 'la lot', 'lá mơ', 'la mo']
  },
  {
    key: 'thì là',
    variants: ['rau thì là', 'thì là']
  },
  {
    key: 'nấm',
    variants: ['nấm hương', 'nấm rơm', 'nấm kim châm', 'nấm đùi gà', 'nấm bào ngư', 'nấm đông cô', 'nấm mèo', 'mộc nhĩ', 'nấm']
  },
  {
    key: 'măng',
    variants: ['măng tươi', 'măng khô', 'măng chua', 'măng le', 'măng lá', 'măng củ', 'măng'],
    excludes: ['măng tây']
  },
  {
    key: 'sấu',
    variants: ['quả sấu', 'trái sấu', 'sấu xanh', 'sấu']
  },
  {
    key: 'me',
    variants: ['me chua', 'nước cốt me', 'trái me', 'me']
  },
  {
    key: 'chao',
    variants: ['chao trắng', 'chao đỏ', 'chao môn', 'chao']
  },
  {
    key: 'cơm mẻ',
    variants: ['cơm mẻ', 'nước mẻ', 'mẻ']
  },
  {
    key: 'mắm tôm',
    variants: ['mắm tôm bắc', 'mắm tôm ngon', 'mắm tôm']
  },
  {
    key: 'mắm nêm',
    variants: ['mắm nêm ngon', 'mắm nêm pha sẵn', 'mắm nêm']
  },
  {
    key: 'chuối xanh',
    variants: ['chuối xanh', 'chuối tiêu xanh', 'chuối chát']
  },
  {
    key: 'khoai sọ',
    variants: ['khoai sọ', 'khoai môn', 'khoai môn cao']
  }
];

/**
 * So khớp thông minh 1 nguyên liệu người dùng nhập với 1 nguyên liệu trong công thức
 */
export function isIngredientMatch(userIng: string, recipeIng: string): boolean {
  const uClean = userIng.trim();
  const rClean = recipeIng.trim();

  const uNorm = removeVietnameseAccents(uClean);
  const rNorm = removeVietnameseAccents(rClean);

  if (!uNorm || !rNorm) return false;

  // 1. Kiểm tra loại trừ nếu là "cá" nhưng công thức là "cà chua/cà tím/cà rốt"
  if (uNorm === 'ca' && (rNorm.includes('ca chua') || rNorm.includes('ca tim') || rNorm.includes('ca rot') || rNorm.includes('ca ri') || rNorm.includes('ca phao'))) {
    return false;
  }

  // Loại trừ nếu tìm "bò" nhưng nguyên liệu là "bơ / bơ tỏi / bơ lạt / quả bơ"
  if ((uNorm === 'bo' || uNorm === 'thit bo') && (rNorm.includes('bo toi') || rNorm.includes('bo lat') || rNorm.includes('qua bo') || rNorm.includes('trai bo') || (rNorm === 'bo' && (rClean.includes('bơ') || rClean.includes('Bơ'))))) {
    return false;
  }

  // Loại trừ nếu tìm "tôm" nhưng nguyên liệu là "mắm tôm / muối tôm / mắm ruốc / tôm chua / mắm tép / mì tôm"
  if ((uNorm === 'tom' || uNorm === 'thit tom') && (rNorm.includes('mam tom') || rNorm.includes('muoi tom') || rNorm.includes('mam ruoc') || rNorm.includes('tom chua') || rNorm.includes('mam tep') || rNorm.includes('mi tom') || rNorm.includes('kho quet'))) {
    return false;
  }

  // 2. Tra cứu nhóm từ điển đồng nghĩa (Ingredient Groups)
  for (const group of INGREDIENT_GROUPS) {
    // Kiểm tra loại trừ của nhóm
    if (group.excludes && group.excludes.some(ex => containsWord(rClean, ex))) {
      continue;
    }

    const userMatchesGroup = group.variants.some(v => containsWord(uClean, v));
    const recipeMatchesGroup = group.variants.some(v => containsWord(rClean, v));

    if (userMatchesGroup && recipeMatchesGroup) {
      return true;
    }
  }

  // 3. Khớp từ ngữ trực tiếp với ranh giới từ
  if (containsWord(rClean, uClean) || containsWord(uClean, rClean)) {
    return true;
  }

  return false;
}

/**
 * Gợi ý món ăn thông minh từ Database Cookpad theo nguyên liệu
 * Kiểm tra nghiêm ngặt không tự ý gán món thịt/hải sản lạ khi người dùng không có
 */
export async function suggestRecipesFromDatabase(
  userIngredients: string[],
  limit: number = 8
): Promise<MatchedRecipe[]> {
  const pool = getPool();

  // 1. Lấy toàn bộ món ăn từ MySQL (Kho 220 món Cookpad)
  const [recipeRows] = await pool.query<any[]>(`
    SELECT id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name
    FROM recipes
  `);

  if (!recipeRows || recipeRows.length === 0) {
    return [];
  }

  // Lấy toàn bộ ingredients nếu có
  const [ingRows] = await pool.query<any[]>(`
    SELECT recipe_id, raw_text, ingredient_name, quantity, is_main FROM recipe_ingredients
  `);

  // Nhóm theo recipe_id
  const ingsByRecipe: Record<string, any[]> = {};
  for (const row of ingRows) {
    if (!ingsByRecipe[row.recipe_id]) ingsByRecipe[row.recipe_id] = [];
    ingsByRecipe[row.recipe_id].push(row);
  }

  // Phân tích protein người dùng có
  const userFullText = userIngredients.join(' ');
  const userPrimaries = extractPrimaryIngredients(userFullText);
  const meatKeys = ['ga', 'bo', 'heo', 'tom', 'ca', 'muc', 'ech', 'luon', 'ngao_oc', 'cua'];
  const userMeats = [...userPrimaries].filter(p => meatKeys.includes(p));

  const scoredRecipes: MatchedRecipe[] = [];

  // 2. Tính toán điểm khớp cho từng món dựa trên Tên món ăn và Nguyên liệu
  for (const r of recipeRows) {
    const rTitle = r.name;
    const recipePrimaries = extractPrimaryIngredients(rTitle);
    const recipeMeats = [...recipePrimaries].filter(p => meatKeys.includes(p));

    // BẮT BUỘC: Mọi loại thịt/hải sản chính trong công thức người dùng PHẢI CÓ
    // Nếu món yêu cầu thịt heo/bò/gà mà người dùng KHÔNG CÓ -> Loại bỏ hoàn toàn!
    const hasUnsuppliedMeat = recipeMeats.some(rm => !userMeats.includes(rm));
    if (hasUnsuppliedMeat) {
      continue;
    }

    // Nếu người dùng không có bất kỳ loại thịt nào (chỉ có trứng/đậu/rau) mà món lại có thịt -> Loại bỏ
    if (userMeats.length === 0 && recipeMeats.length > 0) {
      continue;
    }

    // Kiểm tra thêm từ khóa thịt phụ trong tiêu đề nếu người dùng không có thịt
    const normTitle = removeVietnameseAccents(rTitle);
    if (!userMeats.includes('heo') && (normTitle.includes('ba chi') || normTitle.includes('suon') || normTitle.includes('thit heo') || normTitle.includes('thit lon') || normTitle.includes('thit bam') || normTitle.includes('thit xay') || normTitle.includes('thit nac') || normTitle.includes('lap xuong') || normTitle.includes('cha lua'))) {
      continue;
    }
    if (!userMeats.includes('bo') && (normTitle.includes('thit bo') || normTitle.includes('bap bo') || normTitle.includes('nam bo') || normTitle.includes('gan bo'))) {
      continue;
    }
    if (!userMeats.includes('ga') && (normTitle.includes('thit ga') || normTitle.includes('uc ga') || normTitle.includes('canh ga') || normTitle.includes('dui ga'))) {
      continue;
    }

    const matchedUserIngs = new Set<string>();
    const matchedNames = new Set<string>();

    const rIngredients = ingsByRecipe[r.id] || [];
    
    // So khớp theo tên món ăn
    for (const uIng of userIngredients) {
      if (isIngredientMatch(uIng, r.name) || containsWord(r.name, uIng)) {
        matchedUserIngs.add(uIng.toLowerCase().trim());
        matchedNames.add(uIng);
      }
    }

    // So khớp thêm theo danh sách nguyên liệu trong DB nếu có
    for (const ing of rIngredients) {
      const ingName = ing.ingredient_name || ing.raw_text;
      for (const uIng of userIngredients) {
        if (isIngredientMatch(uIng, ingName)) {
          matchedUserIngs.add(uIng.toLowerCase().trim());
          matchedNames.add(ingName);
        }
      }
    }

    const userIngMatchedCount = matchedUserIngs.size;
    if (userIngMatchedCount === 0) {
      continue;
    }

    const matchPercentage = Math.min(100, Math.round((userIngMatchedCount / Math.min(userIngredients.length, 3)) * 100));

    // Danh sách nguyên liệu hiển thị
    const matchedList = Array.from(matchedNames);
    const missingList = userIngredients.filter(u => !matchedUserIngs.has(u.toLowerCase().trim()));

    const ingredientsDetail: IngredientDetail[] = [
      ...matchedList.map(m => ({ name: m, raw_text: m, quantity: 'Khẩu phần vừa ăn', matched: true })),
      ...missingList.slice(0, 2).map(m => ({ name: m, raw_text: m, quantity: 'Tùy chọn thêm', matched: false })),
      { name: 'Gia vị thông dụng (mắm, muối, tiêu, tỏi)', raw_text: 'Gia vị', quantity: 'Vừa đủ', matched: true }
    ];

    const stepsDetail = [
      { step_number: 1, instruction: `Sơ chế sạch các nguyên liệu (${matchedList.join(', ')}), cắt thái vừa ăn.` },
      { step_number: 2, instruction: `Tẩm ướp gia vị vừa miệng và phi thơm tỏi/hành tím với dầu ăn.` },
      { step_number: 3, instruction: `Chế biến món ${r.name} ở nhiệt độ vừa phải cho đến khi chín thơm đậm đà.` },
      { step_number: 4, instruction: `Trình bày món ${r.name} ra đĩa, thưởng thức nóng cùng cơm gia đình.` }
    ];

    scoredRecipes.push({
      id: r.id,
      user_id: '',
      name: r.name,
      description: r.description || `Món ${r.name} thơm ngon, chuẩn vị truyền thống Việt Nam.`,
      ai_reasoning: `Món ăn tận dụng tối đa nguyên liệu có sẵn: ${matchedList.join(', ')}. Bí quyết: Nấu vừa lửa để giữ trọn vị ngọt tự nhiên.`,
      image_url: r.image_url || '',
      image_query: r.name,
      cooking_time: r.cooking_time || 25,
      difficulty: r.difficulty || 'Dễ',
      servings: r.servings || '2-4 người',
      category: r.category || 'Món chính',
      source_url: r.source_url || 'https://cookpad.com/vn',
      author_name: r.author_name || 'Cookpad VN',
      created_at: new Date().toISOString(),
      match_percentage: matchPercentage,
      matched_count: userIngMatchedCount,
      total_ingredients: ingredientsDetail.length,
      matched_ingredients: matchedList,
      missing_ingredients: missingList,
      ingredients_detail: ingredientsDetail,
      steps_detail: stepsDetail,
      ingredients: ingredientsDetail.map(d => d.name),
      instructions: stepsDetail.map(s => s.instruction),
      nutrition: {
        calories: 320,
        protein: 26,
        carbohydrates: 20,
        fat: 14,
        fiber: 3.5,
        vitamin_c: 15,
        calcium: 50,
        iron: 2.5
      },
      tags: ['Chuẩn vị Việt', 'Món ngon mỗi ngày'],
      source: 'database',
    });
  }

  // Sắp xếp: Ưu tiên món khớp nhiều nguyên liệu nhất & tỷ lệ khớp cao nhất
  scoredRecipes.sort((a, b) => {
    if (b.matched_count !== a.matched_count) {
      return b.matched_count - a.matched_count;
    }
    return b.match_percentage - a.match_percentage;
  });

  return scoredRecipes.slice(0, limit);
}

/**
 * Gợi ý món ăn thông minh (Ưu tiên Trí Tuệ Nhân Tạo Google Gemini AI, hỗ trợ tra cứu Database Cookpad)
 */
export async function suggestRecipes(
  ingredients: string[],
  userId?: string,
  limit: number = 6,
  mode: 'ai' | 'database' = 'ai'
): Promise<{ recipes: MatchedRecipe[]; source: 'database' | 'ai' | 'fallback'; ai_enabled: boolean }> {
  const effectiveUserId = userId || 'system';

  // 1. Chế độ Database nếu người dùng chủ động chọn
  if (mode === 'database') {
    const dbRecipes = await suggestRecipesFromDatabase(ingredients, limit);
    if (userId) {
      try {
        const pool = getPool();
        await pool.query(
          `INSERT INTO search_history (id, user_id, ingredients) VALUES (?, ?, ?)`,
          [uuidv4(), userId, JSON.stringify(ingredients)]
        );
      } catch (err) {
        console.error('Lỗi khi lưu lịch sử tìm kiếm:', err);
      }
    }
    return {
      recipes: dbRecipes,
      source: 'database',
      ai_enabled: isAiEnabled(),
    };
  }

  // 2. Chế độ AI (MẶC ĐỊNH CHO ĐỒ ÁN TRÍ TUỆ NHÂN TẠO)
  if (isAiEnabled()) {
    try {
      console.log(`🤖 Đang gọi Google Gemini AI để gợi ý món ăn cho: ${ingredients.join(', ')}...`);
      const aiResults = await suggestWithGemini(ingredients, effectiveUserId, limit);

      if (aiResults && aiResults.length > 0) {
        const formattedAiRecipes: MatchedRecipe[] = aiResults.map(r => ({
          ...r,
          match_percentage: r.match_percentage || 90,
          matched_count: r.matched_ingredients?.length || ingredients.length,
          total_ingredients: r.ingredients.length,
          matched_ingredients: r.matched_ingredients || ingredients,
          missing_ingredients: r.missing_ingredients || [],
          ingredients_detail: r.ingredients_detail || r.ingredients.map(ingStr => ({
            name: ingStr,
            raw_text: ingStr,
            quantity: '',
            matched: true,
          })),
          steps_detail: r.steps_detail || (r.instructions || []).map((inst, idx) => ({
            step_number: idx + 1,
            instruction: inst,
          })),
          source: 'ai' as const,
        }));

        // Lưu lịch sử tìm kiếm vào MySQL
        if (userId) {
          try {
            const pool = getPool();
            await pool.query(
              `INSERT INTO search_history (id, user_id, ingredients) VALUES (?, ?, ?)`,
              [uuidv4(), userId, JSON.stringify(ingredients)]
            );
          } catch (err) {
            console.error('Lỗi khi lưu lịch sử tìm kiếm:', err);
          }
        }

        return {
          recipes: formattedAiRecipes,
          source: 'ai',
          ai_enabled: true,
        };
      }
    } catch (err) {
      console.error('❌ Lỗi khi gọi Gemini AI, tự động chuyển sang Database Cookpad (Fallback):', err);
    }
  }

  // 3. Fallback: Nếu AI gặp sự cố (mất mạng/hết quota/chưa có key), tự động tra cứu từ MySQL Database Cookpad
  console.log('📚 Đang sử dụng cơ sở dữ liệu Cookpad làm phương án dự phòng (Fallback)...');
  const dbRecipes = await suggestRecipesFromDatabase(ingredients, limit);

  if (userId) {
    try {
      const pool = getPool();
      await pool.query(
        `INSERT INTO search_history (id, user_id, ingredients) VALUES (?, ?, ?)`,
        [uuidv4(), userId, JSON.stringify(ingredients)]
      );
    } catch (err) {
      console.error('Lỗi khi lưu lịch sử tìm kiếm:', err);
    }
  }

  return {
    recipes: dbRecipes,
    source: dbRecipes.length > 0 ? 'database' : 'fallback',
    ai_enabled: isAiEnabled(),
  };
}
