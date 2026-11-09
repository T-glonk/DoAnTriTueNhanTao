import { GoogleGenerativeAI } from '@google/generative-ai';
import { Recipe } from '../types';
import { v4 as uuidv4 } from 'uuid';
import { 
  getFoodImage, 
  isImageUrlConflicting, 
  removeVietnameseAccents,
  searchPexelsImage,
  translateVietnameseDishToEnglish 
} from './image.service';

const GEMINI_API_KEY = process.env.GEMINI_API_KEY || '';

// Gemini key hợp lệ bắt đầu bằng 'AIza'
function isValidGeminiKey(key: string): boolean {
  return typeof key === 'string' && key.startsWith('AIza') && key.length > 20;
}

export function isAiEnabled(): boolean {
  return isValidGeminiKey(GEMINI_API_KEY);
}

// Danh sách Model theo thứ tự ưu tiên (Model nhanh, ổn định nhất đứng đầu)
const MODELS_TO_TRY = [
  'gemini-3.6-flash',
  'gemini-3.1-flash-lite-preview',
  'gemini-3.8-flash',
  'gemini-3.1-flash-lite',
];

/**
 * Tính toán độ tương đồng giữa 2 tên món ăn để loại bỏ món trùng lặp
 */
function areDishesSimilar(name1: string, name2: string): boolean {
  const n1 = removeVietnameseAccents(name1).replace(/[^a-z0-9\s]/g, ' ').trim();
  const n2 = removeVietnameseAccents(name2).replace(/[^a-z0-9\s]/g, ' ').trim();

  if (n1 === n2) return true;

  const words1 = new Set(n1.split(/\s+/).filter(w => w.length > 1));
  const words2 = new Set(n2.split(/\s+/).filter(w => w.length > 1));

  if (words1.size === 0 || words2.size === 0) return false;

  let intersection = 0;
  for (const w of words1) {
    if (words2.has(w)) intersection++;
  }

  const overlap1 = intersection / words1.size;
  const overlap2 = intersection / words2.size;

  return overlap1 >= 0.75 && overlap2 >= 0.75;
}

export interface RecipeCandidate {
  name: string;
  image_url: string;
  category?: string;
  description?: string;
}

/**
 * Gợi ý món ăn thông minh bằng Google Gemini AI (AI Chef & Nutritionist)
 * AI đảm nhận toàn bộ việc sáng tạo công thức, định lượng nguyên liệu, các bước nấu và tính toán dinh dưỡng.
 * Tích hợp Grounded RAG: Ưu tiên lựa chọn từ kho món ăn thực tế đã có ảnh Cookpad CDN chuẩn xác 100%.
 */
export async function suggestWithGemini(
  ingredients: string[],
  userId: string = 'system',
  count: number = 6,
  candidateRecipes?: RecipeCandidate[]
): Promise<Recipe[]> {
  if (!isValidGeminiKey(GEMINI_API_KEY)) {
    throw new Error('Chưa cấu hình GEMINI_API_KEY hợp lệ');
  }

  const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);
  const ingredientsList = ingredients.join(', ');

  const hasCandidates = candidateRecipes && candidateRecipes.length > 0;
  const candidateText = hasCandidates
    ? `\nDANH SÁCH MÓN ĂN THỰC TẾ TRÍCH XUẤT TỪ KHO ẨM THỰC VIỆT NAM (ĐÃ CÓ HÌNH ẢNH CHUẨN XÁC 100%):
${candidateRecipes.slice(0, 12).map((c, idx) => `${idx + 1}. Tên món: "${c.name}" | Ảnh: "${c.image_url}"`).join('\n')}

QUY TẮC CỐT LÕI VỀ TÊN MÓN VÀ HÌNH ẢNH (BẮT BUỘC ĐỂ TRÙNG KHỚP 100%):
- Hãy ưu tiên tối đa việc lựa chọn các món ăn từ danh sách thực tế trên. Khi chọn món từ danh sách, BẮT BUỘC giữ nguyên chính xác 100% "name" và "image_url" tương ứng (TUYỆT ĐỐI KHÔNG tự ý đổi tên món hay thêm từ ngữ hoa mỹ).
- Nếu danh sách trên chưa đủ ${count} món, bạn có thể sáng tạo thêm các món ăn Việt Nam truyền thống quen thuộc, nhưng TÊN MÓN ĂN BẮT BUỘC PHẢI LÀ TÊN CHUẨN MỰC TỪ 2 ĐẾN 4 TỪ (Ví dụ: 'Ếch xào sả ớt', 'Sườn xào chua ngọt', 'Cháo ếch Singapore', 'Canh cải thịt băm'). TUYỆT ĐỐI KHÔNG đặt tên hoa mỹ kéo dài lê thê.\n`
    : `\nQUY TẮC TÊN MÓN ĂN:
- Tên món ăn BẮT BUỘC PHẢI LÀ TÊN CHUẨN MỰC TỪ 2 ĐẾN 4 TỪ phổ biến trong ẩm thực Việt Nam (Ví dụ: 'Ếch xào sả ớt', 'Sườn xào chua ngọt', 'Cháo sườn', 'Canh gà lá giang'). TUYỆT ĐỐI KHÔNG đặt tên hoa mỹ dài dòng.\n`;

  const prompt = `Bạn là Bếp trưởng chuyên nghiệp (AI Chef) và Chuyên gia dinh dưỡng ẩm thực Việt Nam trong hệ thống FoodAI.
Người dùng có các nguyên liệu có sẵn sau: [${ingredientsList}].
${candidateText}
Nhiệm vụ của bạn:
Phân tích kỹ danh sách nguyên liệu và sáng tạo ra đúng ${count} món ăn Việt Nam hấp dẫn, ngon miệng, chuẩn vị và ĐA DẠNG TUYỆT ĐỐI.

QUY TẮC CỐT LÕI (BẮT BUỘC TUÂN THỦ 100%):
1. NGUYÊN TẮC NGUYÊN LIỆU CHÍNH XÁC:
   - CHỈ ĐƯỢC DÙNG các nguyên liệu chính/phụ mà người dùng đã cung cấp: [${ingredientsList}].
   - Gia vị nhà bếp cơ bản được phép dùng: nước mắm, muối, đường, tiêu, hạt nêm, dầu ăn, tỏi, hành khô, hành lá, ớt, nước lọc, cơm trắng.
   - TUYỆT ĐỐI KHÔNG TỰ BỊA RA các loại thịt/hải sản khác mà người dùng KHÔNG NHẬP (Ví dụ: nếu người dùng KHÔNG nhập thịt bò/heo/gà/cá thì TUYỆT ĐỐI KHÔNG gợi ý món có thịt bò/heo/gà/cá!).
   - Nếu toàn bộ nguyên liệu là đồ chay/rau củ/đậu/nấm/trứng -> 100% món gợi ý phải là món chay/thanh đạm/trứng, không được thêm bất kỳ loại thịt cá nào.

2. NGUYÊN TẮC ĐA DẠNG HÓA 100% (KHÔNG TRÙNG LẶP):
   Mỗi món trong ${count} món gợi ý BẮT BUỘC phải sử dụng một phương pháp chế biến và phong cách ẩm thực HOÀN TOÀN KHÁC BIỆT:
   - Món 1: Món Xào / Áp chảo (Stir-fry)
   - Món 2: Món Canh / Súp thanh mát (Soup / Broth)
   - Món 3: Món Chiên / Rán giòn / Hấp / Nướng (Fried / Steamed / Grilled)
   - Món 4: Món Kho / Rim / Sốt đậm đà (Braised / Simmered)
   - Món 5: Món Gỏi / Nộm / Salad / Cuộn tươi (Salad / Fresh roll)
   - Món 6: Món Điểm tâm / Cháo / Bún / Mì / Món sáng tạo đặc sắc (Breakfast / Porridge / Creative specialty)
   TUYỆT ĐỐI KHÔNG gợi ý 2 món có cùng công thức biến tấu nhỏ.

3. FORMAT JSON ĐẦU RA (CHỈ TRẢ VỀ JSON THUẦN, KHÔNG KÈM TEXT HAY MARKDOWN):
{
  "recipes": [
    {
      "name": "Tên món ăn tiếng Việt ngắn gọn, chuẩn vị (2-4 từ)",
      "description": "Mô tả ngắn gọn 1-2 câu về hương vị món ăn",
      "ai_reasoning": "Lời khuyên & phân tích từ AI Chef: Giải thích tại sao gợi ý món này, cách kết hợp tối đa các nguyên liệu đã có, và mẹo nấu ngon bí quyết đầu bếp",
      "matched_ingredients": ["nguyên liệu 1 có sẵn", "nguyên liệu 2 có sẵn"],
      "missing_ingredients": ["nguyên liệu phụ cần thêm nếu có (ví dụ: dầu ăn, tỏi)"],
      "match_percentage": 95,
      "ingredients": ["150g tôm tươi", "1 quả bí ngòi", "2 tép tỏi băm", "Gia vị: mắm, muối, tiêu, dầu ăn"],
      "instructions": [
        "Bước 1: Sơ chế tôm bóc vỏ bỏ chỉ đen, ướp chút tiêu và hạt nêm trong 10 phút.",
        "Bước 2: Rửa sạch bí ngòi, cắt lát mỏng vừa ăn.",
        "Bước 3: Phi thơm tỏi băm với 1 thìa dầu ăn trên chảo nóng.",
        "Bước 4: Cho tôm vào đảo săn trong 2 phút rồi trút bí ngòi vào xào nhanh lửa lớn 3 phút, nêm nước mắm vừa ăn rồi tắt bếp."
      ],
      "nutrition": {
        "calories": 240,
        "protein": 22,
        "carbohydrates": 12,
        "fat": 8,
        "fiber": 3,
        "vitamin_c": 18,
        "calcium": 70,
        "iron": 2.4
      },
      "cooking_time": 20,
      "difficulty": "Dễ",
      "servings": "2-3 người",
      "category": "Món xào",
      "tags": ["dinh dưỡng", "món xào", "chuẩn vị Việt"],
      "image_url": "URL ảnh nếu chọn từ danh sách thực tế (hoặc để trống)",
      "image_query": "Stir fried shrimp with zucchini"
    }
  ]
}

Quy định giá trị trường:
- difficulty CHỈ được chọn 1 trong: "Dễ", "Trung bình", "Khó"
- category CHỈ được chọn 1 trong: "Món xào", "Súp/Canh", "Món chiên", "Món kho", "Salad", "Món chính", "Ăn sáng", "Món hấp/luộc"
- cooking_time tính bằng số phút (số nguyên)
- match_percentage tính bằng số nguyên từ 70 đến 100
- image_query: Tên tiếng Anh ngắn gọn của món ăn`;

  let text = '';
  let lastErr: any = null;

  for (const modelName of MODELS_TO_TRY) {
    for (let attempt = 1; attempt <= 2; attempt++) {
      try {
        console.log(`[Gemini] Đang gửi prompt tới model: ${modelName} (lần thử ${attempt})...`);
        const startTime = Date.now();
        const model = genAI.getGenerativeModel({
          model: modelName,
          generationConfig: {
            responseMimeType: 'application/json',
            temperature: 0.6,
          },
        });
        const result = await model.generateContent(prompt);
        text = result.response.text();
        const duration = Date.now() - startTime;
        if (text) {
          console.log(`✅ Google Gemini AI (${modelName}) đã phản hồi thành công trong ${duration}ms!`);
          break;
        }
      } catch (err: any) {
        console.warn(`⚠️ Model ${modelName} (lần thử ${attempt}) gặp lỗi: ${err.message || err}.`);
        lastErr = err;
        if (attempt < 2) {
          await new Promise(res => setTimeout(res, 800));
        }
      }
    }
    if (text) break;
  }

  if (!text) {
    throw lastErr || new Error('Không thể kết nối tới Google Gemini AI');
  }

  console.log('[Gemini] Đang parse JSON response...');
  let parsed: any;
  try {
    let t = text.trim();
    if (t.startsWith('```json')) {
      t = t.replace(/^```json\s*/, '').replace(/\s*```$/, '');
    } else if (t.startsWith('```')) {
      t = t.replace(/^```\s*/, '').replace(/\s*```$/, '');
    }

    const firstBrace = t.indexOf('{');
    const firstBracket = t.indexOf('[');
    let startIdx = -1;
    let endIdx = -1;

    if (firstBrace !== -1 && (firstBracket === -1 || firstBrace < firstBracket)) {
      startIdx = firstBrace;
      endIdx = t.lastIndexOf('}');
    } else if (firstBracket !== -1) {
      startIdx = firstBracket;
      endIdx = t.lastIndexOf(']');
    }

    if (startIdx !== -1 && endIdx !== -1 && endIdx > startIdx) {
      t = t.substring(startIdx, endIdx + 1);
    }

    try {
      parsed = JSON.parse(t);
    } catch (innerErr) {
      const sanitized = t
        .replace(/[\x00-\x1F\x7F-\x9F]/g, (c) => (c === '\n' || c === '\r' || c === '\t' ? c : ' '))
        .replace(/,\s*([}\]])/g, '$1');
      parsed = JSON.parse(sanitized);
    }
  } catch (parseErr) {
    console.error('Lỗi parse JSON cấp cao:', parseErr);
    throw new Error('AI không trả về dữ liệu JSON hợp lệ');
  }

  const rawRecipes = Array.isArray(parsed) ? parsed : (parsed?.recipes || []);
  if (!Array.isArray(rawRecipes) || rawRecipes.length === 0) {
    throw new Error('AI không trả về danh sách món ăn hợp lệ');
  }

  // 1. Khử trùng lặp món ăn (Deduplication)
  const uniqueRecipes: any[] = [];
  for (const r of rawRecipes) {
    if (!r.name) continue;
    const isDup = uniqueRecipes.some(existing => areDishesSimilar(existing.name, r.name));
    if (!isDup) {
      uniqueRecipes.push(r);
    }
  }

  console.log(`[Gemini] Đã parse & khử trùng lặp thành công ${uniqueRecipes.length} món ăn. Đang tra cứu hình ảnh chất lượng cao...`);
  const usedImages = new Set<string>();

  const candidateMap = new Map<string, string>();
  if (candidateRecipes) {
    for (const c of candidateRecipes) {
      if (c.image_url) {
        candidateMap.set(removeVietnameseAccents(c.name), c.image_url);
      }
    }
  }

  // 2. Gán ảnh minh họa thực tế độc nhất từ kho Cookpad MySQL / Live Scraper / HD Category
  const recipesWithImages: Recipe[] = [];
  for (const recipe of uniqueRecipes) {
    let imageUrl = '';
    const normName = removeVietnameseAccents(recipe.name);

    // Ưu tiên 1: Chỉ lấy từ ứng viên khi tên món trùng khớp 100% VÀ không có bất kỳ xung đột nào
    if (!imageUrl && candidateMap.has(normName) && !usedImages.has(candidateMap.get(normName)!)) {
      const candImg = candidateMap.get(normName)!;
      if (!isImageUrlConflicting(candImg, recipe.name)) {
        imageUrl = candImg;
      }
    }

    // Ưu tiên 2: Tra cứu thông minh qua getFoodImage (CSDL Cookpad -> Live Scraper đúng tên món -> Category Registry -> Pexels fallback)
    // TUYỆT ĐỐI KHÔNG mượn ảnh của món khác trong candidateMap để bảo đảm độ chính xác 100%
    if (!imageUrl) {
      imageUrl = await getFoodImage(recipe.name, recipe.image_query, usedImages);
    }
    if (imageUrl) usedImages.add(imageUrl);

    const matchedList = recipe.matched_ingredients || ingredients;
    const missingList = recipe.missing_ingredients || [];

    const rawIngs: string[] = Array.isArray(recipe.ingredients) ? recipe.ingredients : [];
    const ingredientsDetail = rawIngs.map((ingStr: string) => {
      const isMatched = (matchedList as string[]).some((m: string) => ingStr.toLowerCase().includes(m.toLowerCase()));
      return {
        name: ingStr,
        raw_text: ingStr,
        quantity: '',
        matched: isMatched,
      };
    });

    const rawInsts: string[] = Array.isArray(recipe.instructions) ? recipe.instructions : [];
    const stepsDetail = rawInsts.map((inst: string, idx: number) => ({
      step_number: idx + 1,
      instruction: inst,
    }));

    recipesWithImages.push({
      id: uuidv4(),
      user_id: userId,
      name: recipe.name,
      description: recipe.description,
      ai_reasoning: recipe.ai_reasoning || 'Món ăn được AI Chef tối ưu dựa trên nguyên liệu có sẵn của bạn.',
      ingredients: recipe.ingredients,
      instructions: recipe.instructions,
      nutrition: {
        calories: Number(recipe.nutrition?.calories) || 300,
        protein: Number(recipe.nutrition?.protein) || 20,
        carbohydrates: Number(recipe.nutrition?.carbohydrates) || 20,
        fat: Number(recipe.nutrition?.fat) || 10,
        fiber: Number(recipe.nutrition?.fiber) || 3,
        vitamin_c: Number(recipe.nutrition?.vitamin_c) || 10,
        calcium: Number(recipe.nutrition?.calcium) || 50,
        iron: Number(recipe.nutrition?.iron) || 2,
      },
      image_url: imageUrl,
      image_query: recipe.image_query,
      cooking_time: Number(recipe.cooking_time) || 25,
      difficulty: (['Dễ', 'Trung bình', 'Khó'].includes(recipe.difficulty) ? recipe.difficulty : 'Trung bình') as 'Dễ' | 'Trung bình' | 'Khó',
      servings: recipe.servings || '2-4 người',
      category: recipe.category || 'Món chính',
      tags: recipe.tags || ['AI Chef', 'Chuẩn vị Việt'],
      created_at: new Date().toISOString(),
      match_percentage: Number(recipe.match_percentage) || 90,
      matched_count: matchedList.length,
      total_ingredients: recipe.ingredients.length,
      matched_ingredients: matchedList,
      missing_ingredients: missingList,
      ingredients_detail: ingredientsDetail,
      steps_detail: stepsDetail,
      source: 'ai' as const,
    });
  }

  return recipesWithImages;
}

/**
 * Tự động tạo Công thức & Phân tích Dinh dưỡng cho một món ăn bất kỳ bằng Gemini AI
 */
export async function generateRecipeDetailWithGemini(dishName: string): Promise<any> {
  if (!isValidGeminiKey(GEMINI_API_KEY)) {
    throw new Error('Chưa cấu hình GEMINI_API_KEY hợp lệ');
  }

  const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);
  const prompt = `Bạn là một đầu bếp chuyên nghiệp (AI Chef) và chuyên gia dinh dưỡng Việt Nam trong hệ thống FoodAI.
Hãy sáng tạo công thức nấu ăn chi tiết chuẩn vị Việt Nam và phân tích dinh dưỡng cho món ăn: "${dishName}".

Trả về JSON với format CHÍNH XÁC sau (chỉ JSON thuần):
{
  "name": "${dishName}",
  "description": "Mô tả hấp dẫn về hương vị của món ăn",
  "ai_reasoning": "Bí quyết đầu bếp: Mẹo chọn nguyên liệu tươi ngon và kỹ thuật nấu chuẩn vị nhất",
  "cooking_time": 30,
  "difficulty": "Dễ",
  "servings": "2-4 người",
  "category": "Món chính",
  "ingredients": [
    "300g nguyên liệu chính",
    "Gia vị: nước mắm, tiêu, đường, tỏi..."
  ],
  "instructions": [
    "Bước 1: Sơ chế...",
    "Bước 2: Nấu..."
  ],
  "nutrition": {
    "calories": 350,
    "protein": 26,
    "carbohydrates": 20,
    "fat": 12,
    "fiber": 3,
    "calcium": 50,
    "iron": 2.5,
    "vitamin_c": 15
  },
  "tags": ["chuẩn vị Việt", "dinh dưỡng"]
}`;

  for (const modelName of MODELS_TO_TRY) {
    try {
      const model = genAI.getGenerativeModel({
        model: modelName,
        generationConfig: {
          responseMimeType: 'application/json',
          temperature: 0.6,
        },
      });
      const result = await model.generateContent(prompt);
      const text = result.response.text();
      let cleanText = text.trim().replace(/^```json\s*/, '').replace(/\s*```$/, '');
      const parsed = JSON.parse(cleanText);
      return parsed;
    } catch (e) {
      // try next model
    }
  }

  throw new Error('Không thể sinh công thức AI cho món ăn');
}
