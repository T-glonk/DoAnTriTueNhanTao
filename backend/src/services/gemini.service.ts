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
  id?: string;
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
  count: number = 8,
  candidateRecipes?: RecipeCandidate[]
): Promise<Recipe[]> {
  if (!isValidGeminiKey(GEMINI_API_KEY)) {
    throw new Error('Chưa cấu hình GEMINI_API_KEY hợp lệ');
  }

  const genAI = new GoogleGenerativeAI(GEMINI_API_KEY);
  const ingredientsList = ingredients.join(', ');

  const hasCandidates = candidateRecipes && candidateRecipes.length > 0;
  const selectedDishes = hasCandidates ? candidateRecipes.slice(0, count) : [];

  const candidateText = hasCandidates
    ? `\nDANH SÁCH MÓN ĂN THỰC TẾ TRUY VẤN VÀ CHỌN LỌC TỪ KHO CƠ SỞ DỮ LIỆU MYSQL:
${selectedDishes.map((c, idx) => `${idx + 1}. ID: "${c.id}" | Tên món: "${c.name}" | Danh mục: "${c.category || 'Món chính'}" | Ảnh: "${c.image_url}"`).join('\n')}

QUY TẮC CỐT LÕI (BẮT BUỘC TUÂN THỦ 100%):
- BẮT BUỘC chỉ phân tích và tính toán cho ĐÚNG các món ăn trong danh sách CSDL ở trên.
- TUYỆT ĐỐI KHÔNG TỰ SINH RA HAY BỊA THÊM BẤT KỲ TÊN MÓN ĂN NÀO MỚI NẰM NGOÀI DANH SÁCH TRÊN!
- BẮT BUỘC giữ nguyên chính xác 100% "name" và "image_url" tương ứng của từng món từ CSDL.
- Nhiệm vụ của bạn là:
  + Dựa vào tên món ăn, tính toán chính xác độ dinh dưỡng: calories, protein, carbohydrates, fat, fiber, calcium, iron, vitamin_c.
  + Tính toán thời gian nấu chuẩn (cooking_time tính bằng số phút).
  + Định lượng khối lượng thức ăn / khẩu phần (servings, ví dụ: '2-3 người', '2-4 người') và định lượng nguyên liệu cụ thể (gram, muỗng...).
  + Hướng dẫn cách nấu 4 bước và phân tích bí quyết của Đầu bếp AI (ai_reasoning).\n`
    : `\nQUY TẮC TÊN MÓN ĂN:
- Tên món ăn BẮT BUỘC PHẢI LÀ TÊN CHUẨN MỰC TỪ 2 ĐẾN 4 TỪ phổ biến trong ẩm thực Việt Nam (Ví dụ: 'Trứng sốt cà chua', 'Canh cà chua trứng', 'Tôm rang thịt ba chỉ').\n`;

  const prompt = `Bạn là Bếp trưởng chuyên nghiệp (AI Chef) và Chuyên gia dinh dưỡng ẩm thực Việt Nam trong hệ thống FoodAI.
Người dùng có các nguyên liệu có sẵn sau: [${ingredientsList}].
${candidateText}
Nhiệm vụ của bạn:
Phân tích kỹ lưỡng từng món ăn được chọn từ cơ sở dữ liệu và hoàn thiện công thức nấu ăn chuyên nghiệp, định lượng nguyên liệu, các bước nấu và phân tích dinh dưỡng chi tiết.

QUY TẮC CỐT LÕI (BẮT BUỘC TUÂN THỦ 100%):
1. NGUYÊN TẮC NGUYÊN LIỆU VÀ CÔNG THỨC:
   - CHỈ ĐƯỢC DÙNG các nguyên liệu chính/phụ mà người dùng đã cung cấp: [${ingredientsList}].
   - Gia vị nhà bếp cơ bản được phép dùng: nước mắm, muối, đường, tiêu, hạt nêm, dầu ăn, tỏi, hành khô, hành lá, ớt, nước lọc, cơm trắng.
   - TUYỆT ĐỐI KHÔNG TỰ BỊA RA các loại thịt/hải sản khác mà người dùng KHÔNG NHẬP (Ví dụ: nếu người dùng KHÔNG nhập thịt bò/heo/gà/cá thì TUYỆT ĐỐI KHÔNG gợi ý món có thịt bò/heo/gà/cá!).
   - Định lượng rõ ràng cho từng nguyên liệu (gram, thìa, quả...).
   - Hướng dẫn cách nấu chi tiết tối thiểu 4 bước: Sơ chế -> Tẩm ướp -> Nấu/Chế biến -> Hoàn thiện & trình bày.

2. PHÂN TÍCH DINH DƯỠNG & LỜI KHUYÊN ĐẦU BẾP (AI REASONING):
   - Tính toán đầy đủ thành phần dinh dưỡng: calories, protein, carbohydrates, fat, fiber, calcium, iron, vitamin_c.
   - Đưa ra lời khuyên từ Bếp trưởng (ai_reasoning): bí quyết chế biến, mẹo xử lý nguyên liệu để giữ độ tươi ngon và dưỡng chất.

3. FORMAT JSON ĐẦU RA (CHỈ TRẢ VỀ JSON THUẦN, MẢNG recipes BẮT BUỘC CÓ ĐỦ ${count} PHẦN TỬ):
{
  "recipes": [
    // BẮT BUỘC liệt kê đủ ${count} món ăn khác nhau (từ món 1 đến món ${count})
    {
      "name": "Tên món ăn ngắn gọn (2-4 từ, ví dụ: 'Trứng sốt cà chua', 'Canh cà chua trứng', 'Tôm rang thịt')",
      "description": "Mô tả ngắn gọn 1-2 câu về hương vị món ăn",
      "ai_reasoning": "Lời khuyên & phân tích từ AI Chef: Giải thích tại sao món này tối ưu với nguyên liệu có sẵn, bí quyết đầu bếp để nấu chuẩn vị",
      "matched_ingredients": ["nguyên liệu 1 có sẵn", "nguyên liệu 2 có sẵn"],
      "missing_ingredients": ["nguyên liệu phụ cần thêm nếu có (ví dụ: dầu ăn, tỏi)"],
      "match_percentage": 95,
      "ingredients": ["150g tôm tươi", "1 quả bí ngòi", "2 tép tỏi băm", "Gia vị: mắm, muối, tiêu, dầu ăn"],
      "instructions": [
        "Bước 1: Sơ chế...",
        "Bước 2: Tẩm ướp...",
        "Bước 3: Chế biến...",
        "Bước 4: Hoàn thiện..."
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
      "tags": ["dinh dưỡng", "món ngon", "chuẩn vị Việt"],
      "image_url": "URL ảnh từ CSDL",
      "image_query": "Tên tiếng Anh của món"
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

  console.log(`[Gemini] Đã parse & khử trùng lặp thành công ${uniqueRecipes.length} món ăn. Đang đối chiếu chính xác với CSDL và hình ảnh...`);
  const usedImages = new Set<string>();

  // 2. Gán thông tin chính xác từ CSDL (BẢO ĐẢM 100% LÀ MÓN TỪ KHO CƠ SỞ DỮ LIỆU)
  const recipesWithImages: Recipe[] = [];

  if (candidateRecipes && candidateRecipes.length > 0) {
    // Duyệt qua từng món ứng viên thực tế từ CSDL
    for (const cand of candidateRecipes) {
      // Tìm phân tích của AI tương ứng với món này
      const aiMatch = uniqueRecipes.find(r => 
        removeVietnameseAccents(r.name) === removeVietnameseAccents(cand.name) ||
        areDishesSimilar(r.name, cand.name)
      );

      const matchedList = aiMatch?.matched_ingredients || ingredients;
      const missingList = aiMatch?.missing_ingredients || [];

      const rawIngs: string[] = Array.isArray(aiMatch?.ingredients) && aiMatch.ingredients.length > 0
        ? aiMatch.ingredients 
        : [
            `Nguyên liệu chính cho món ${cand.name}`,
            'Gia vị nhà bếp cơ bản (mắm, muối, tiêu, dầu ăn)'
          ];
      const ingredientsDetail = rawIngs.map((ingStr: string) => {
        const isMatched = (matchedList as string[]).some((m: string) => ingStr.toLowerCase().includes(m.toLowerCase()));
        return {
          name: ingStr,
          raw_text: ingStr,
          quantity: '',
          matched: isMatched,
        };
      });

      const rawInsts: string[] = Array.isArray(aiMatch?.instructions) && aiMatch.instructions.length > 0
        ? aiMatch.instructions 
        : [
            `Bước 1: Sơ chế sạch các nguyên liệu chế biến món ${cand.name}.`,
            `Bước 2: Tẩm ướp gia vị vừa khẩu vị gia đình.`,
            `Bước 3: Chế biến món ${cand.name} ở nhiệt độ thích hợp cho chín thơm ngon.`,
            `Bước 4: Trình bày món ${cand.name} ra đĩa và thưởng thức nóng cùng cơm.`
          ];
      const stepsDetail = rawInsts.map((inst: string, idx: number) => ({
        step_number: idx + 1,
        instruction: inst,
      }));

      recipesWithImages.push({
        id: cand.id || uuidv4(),
        user_id: userId,
        name: cand.name, // 100% TÊN MÓN TỪ CSDL
        description: aiMatch?.description || cand.description || `Món ${cand.name} chuẩn vị ẩm thực Việt Nam.`,
        ai_reasoning: aiMatch?.ai_reasoning || 'Món ăn từ kho CSDL được AI Chef tối ưu dinh dưỡng dựa trên nguyên liệu có sẵn của bạn.',
        ingredients: rawIngs,
        instructions: rawInsts,
        nutrition: {
          calories: Number(aiMatch?.nutrition?.calories) || 300,
          protein: Number(aiMatch?.nutrition?.protein) || 20,
          carbohydrates: Number(aiMatch?.nutrition?.carbohydrates) || 20,
          fat: Number(aiMatch?.nutrition?.fat) || 10,
          fiber: Number(aiMatch?.nutrition?.fiber) || 3,
          vitamin_c: Number(aiMatch?.nutrition?.vitamin_c) || 10,
          calcium: Number(aiMatch?.nutrition?.calcium) || 50,
          iron: Number(aiMatch?.nutrition?.iron) || 2,
        },
        image_url: cand.image_url, // 100% ẢNH TỪ CSDL
        image_query: cand.name,
        cooking_time: Number(aiMatch?.cooking_time) || 25,
        difficulty: (['Dễ', 'Trung bình', 'Khó'].includes(aiMatch?.difficulty) ? aiMatch.difficulty : 'Trung bình') as 'Dễ' | 'Trung bình' | 'Khó',
        servings: aiMatch?.servings || '2-4 người',
        category: cand.category || aiMatch?.category || 'Món chính',
        tags: aiMatch?.tags || ['Chuẩn vị Việt', 'Món ngon CSDL'],
        created_at: new Date().toISOString(),
        match_percentage: Number(aiMatch?.match_percentage) || 90,
        matched_count: matchedList.length,
        total_ingredients: rawIngs.length,
        matched_ingredients: matchedList,
        missing_ingredients: missingList,
        ingredients_detail: ingredientsDetail,
        steps_detail: stepsDetail,
        source: 'ai' as const,
      });
    }
    return recipesWithImages;
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
