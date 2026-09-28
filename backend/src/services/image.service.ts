import https from 'https';
import { getPool } from '../database/db';
import { CATEGORY_IMAGE_REGISTRY, classifyRecipeImageCategory } from './category_images';

const memoryImageCache = new Map<string, string[]>();

/**
 * Loại bỏ dấu tiếng Việt để so khớp từ khóa
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
 * Trích xuất chính xác các nguyên liệu chính (Protein / Thành phần cốt lõi)
 * Xử lý triệt để các trường hợp dính chuỗi tiếng Việt: "cà chua" != "cá", "đậu gà" != "thịt gà", "nấm đùi gà" != "thịt gà", "bơ" != "bò"
 */
export function extractPrimaryIngredients(text: string): Set<string> {
  const norm = removeVietnameseAccents(text);
  // Thay thế các cụm từ ghép đặc biệt trước khi nhận diện để tránh nhầm lẫn
  const sanitized = norm
    .replace(/\bca\s+(chua|phao|tim|rot|bien)\b/g, 'vegetable_$1') // cà chua, cà pháo, cà tím, cà rốt
    .replace(/\bdau\s+ga\b/g, 'chickpea') // đậu gà
    .replace(/\bnam\s+dui\s+ga\b/g, 'mushroom_stem') // nấm đùi gà
    .replace(/\bqua\s+bo\b/g, 'avocado') // quả bơ
    .replace(/\bbo\s+thuc\s+vat\b/g, 'butter') // bơ thực vật
    .replace(/\bbo\s+(lat|toi)\b/g, 'butter_$1')
    .replace(/\bthit\s+ga\b/g, 'poultry_meat') // thịt gà
    .replace(/\bthit\s+bo\b/g, 'beef_meat') // thịt bò
    .replace(/\bthit\s+(vit|ngan|de|cuu|ech|luon)\b/g, 'other_meat_$1');

  const detected = new Set<string>();

  if (/\b(ga|uc\s+ga|canh\s+ga|dui\s+ga|poultry_meat)\b/.test(sanitized)) {
    detected.add('ga');
  }
  if (/\b(bo|beef_meat|gan\s+bo|bap\s+bo|nam\s+bo)\b/.test(sanitized)) {
    detected.add('bo');
  }
  if (/\b(heo|lon|ba\s+chi|thit\s+bam|thit\s+xay|suon|gio\s+heo|thit\s+nac|thit)\b/.test(sanitized)) {
    detected.add('heo');
  }
  if (/\b(tom|tep|tom\s+su|tom\s+dong)\b/.test(sanitized)) {
    detected.add('tom');
  }
  if (/\b(ca|ca\s+loc|ca\s+hoi|ca\s+thu|ca\s+ro|ca\s+dieu\s+hong|ca\s+bop|ca\s+tre)\b/.test(sanitized)) {
    detected.add('ca');
  }
  if (/\b(muc|bach\s+tuoc)\b/.test(sanitized)) {
    detected.add('muc');
  }
  if (/\b(trung|trung\s+ga|trung\s+vit|trung\s+cut)\b/.test(sanitized)) {
    detected.add('trung');
  }
  if (/\b(dau\s+phu|dau\s+hu|dau\s+khuon|tau\s+hu|dau\s+non)\b/.test(sanitized)) {
    detected.add('dau');
  }
  if (/\b(ech)\b/.test(sanitized)) {
    detected.add('ech');
  }
  if (/\b(luon)\b/.test(sanitized)) {
    detected.add('luon');
  }
  if (/\b(cua|ghe|rieu)\b/.test(sanitized)) {
    detected.add('cua');
  }
  if (/\b(ngao|so|hen|ngheu|oc)\b/.test(sanitized)) {
    detected.add('ngao_oc');
  }

  return detected;
}

/**
 * Thuật toán thông minh: Lọc và chấm điểm mức độ khớp của món ăn Cookpad
 * - Loại bỏ hoàn toàn hình ảnh cơm bento tạo hình, cơm ăn dặm, combo mâm cơm nhiều món
 * - Kiểm tra xung đột nguyên liệu chính (không lấy ảnh cá/bò/tôm gán cho món gà)
 * - Tính điểm độ bao phủ (Coverage) & độ tinh khiết (Purity) từ khóa
 */
export function scoreRecipeCard(cardTitle: string, targetDish: string): number {
  const normTitle = removeVietnameseAccents(cardTitle);
  const normTarget = removeVietnameseAccents(targetDish);

  // 1. Loại bỏ các từ khóa tiêu cực (bento, ăn dặm cho bé, cún con gặm xương, mâm cơm combo...)
  const hardNegatives = [
    'bento', 'cun con', 'cho', 'meo', 'tao hinh', 'be', 'an dam',
    'com nha', 'bua com', 'mam com', 'combo', 'thuc don', 'eat clean', 'giam can',
    'bua toi', 'bua sang', 'bua trua', 'menu', 'day 1', 'day 2', 'day 3', 'day 4', 'day 5'
  ];

  for (const neg of hardNegatives) {
    if (normTitle.includes(neg)) {
      return -100;
    }
  }

  // 2. Kiểm tra xung đột nguyên liệu chính (Primary Ingredient Conflicts)
  const targetPrimaries = extractPrimaryIngredients(targetDish);
  const titlePrimaries = extractPrimaryIngredients(cardTitle);

  const meatTypes = ['ga', 'bo', 'heo', 'tom', 'ca', 'muc', 'ech', 'luon'];
  const targetMeats = [...targetPrimaries].filter(p => meatTypes.includes(p));
  const titleMeats = [...titlePrimaries].filter(p => meatTypes.includes(p));

  // Đặc cách: Đậu phụ / Đậu hũ nhồi thịt
  const isTargetTofuStuffed = targetPrimaries.has('dau') && (targetPrimaries.has('heo') || targetPrimaries.has('ga') || normTarget.includes('nhoi'));
  const isTitleTofuStuffed = titlePrimaries.has('dau') && (titlePrimaries.has('heo') || titlePrimaries.has('ga') || normTitle.includes('nhoi'));

  if (!(isTargetTofuStuffed && isTitleTofuStuffed)) {
    // Nếu target có loại thịt cụ thể mà title có loại thịt khác hoàn toàn -> Loại bỏ!
    if (targetMeats.length > 0) {
      const hasMatchingMeat = targetMeats.some(tm => titleMeats.includes(tm));
      if (!hasMatchingMeat && titleMeats.length > 0) {
        return -100;
      }
    }
  }

  // Nếu target là món đậu phụ chay mà title lại là cá/bò/tôm -> Loại bỏ
  if (targetPrimaries.has('dau') && targetMeats.length === 0 && titleMeats.length > 0) {
    return -100;
  }

  // Nếu target có trứng mà title không có trứng (hoặc ngược lại)
  if (targetPrimaries.has('trung') && !titlePrimaries.has('trung') && targetMeats.length === 0 && !normTitle.includes('trung')) {
    return -100;
  }
  if (!targetPrimaries.has('trung') && titlePrimaries.has('trung') && !normTarget.includes('trung')) {
    return -100;
  }

  // Nếu target là món mặn mà kết quả là chay
  if (targetMeats.length > 0 && normTitle.includes('chay')) {
    return -100;
  }

  // 3. Tách từ khóa
  const stopWords = ['mon', 'cach', 'lam', 'kieu', 'chuan', 'vi', 'dam', 'da', 'ngon', 'sieu', 'nau', 'hinh', 'cua', 'va', 'voi', 'cho'];
  const targetWords = normTarget
    .replace(/[^a-z0-9\s]/g, ' ')
    .split(/\s+/)
    .filter(w => w.length > 1 && !stopWords.includes(w));

  const titleWords = normTitle
    .replace(/[^a-z0-9\s]/g, ' ')
    .split(/\s+/)
    .filter(w => w.length > 1 && !stopWords.includes(w));

  if (titleWords.length === 0 || targetWords.length === 0) return 0;

  let matchCount = 0;
  for (const tw of targetWords) {
    if (titleWords.includes(tw)) {
      matchCount++;
    }
  }

  if (matchCount === 0) return 0;

  const coverage = matchCount / targetWords.length;
  const purity = matchCount / titleWords.length;

  let score = (coverage * 60) + (purity * 40);

  // Thưởng điểm tối đa nếu chứa chính xác cụm từ tìm kiếm
  if (normTitle.includes(normTarget) || normTarget.includes(normTitle)) {
    score += 80;
  }

  // Thưởng điểm cho các cụm từ phổ biến
  const corePhrases = [
    'trung xao ca chua', 'canh trung ca chua', 'trung chien ca chua', 'trung chien', 'trung cuon',
    'tom xao', 'tom rim', 'canh tom', 'tom cuon', 'tom hap',
    'ga xao ca chua', 'uc ga xao ca chua', 'ga sot ca chua',
    'dau phu sot ca chua', 'dau hu sot ca chua', 'dau phu nhoi thit', 'dau hu nhoi thit',
    'canh ga', 'ga kho', 'ga rang sa ot', 'ga xao sa ot',
    'bo xao', 'thit heo xao', 'suon xao chua ngot', 'canh chua', 'rau xao'
  ];
  for (const phrase of corePhrases) {
    if (normTarget.includes(phrase) && normTitle.includes(phrase)) {
      score += 40;
    }
  }

  return Math.round(score);
}

/**
 * Cào danh sách thẻ công thức từ Cookpad theo 1 từ khóa cụ thể
 */
async function fetchCookpadCardsByQuery(query: string): Promise<Array<{ title: string; imageUrl: string }>> {
  return new Promise((resolve) => {
    try {
      const cleanKeyword = query
        .replace(/^(món|cách làm|hướng dẫn)\s+/i, '')
        .replace(/\s+(chuẩn vị|kiểu việt|đơn giản|nhanh gọn|thanh mát|đậm đà|thơm ngon|siêu ngon).*$/i, '')
        .trim();

      const encoded = encodeURIComponent(cleanKeyword);
      const url = `https://cookpad.com/vn/tim-kiem/${encoded}`;

      const req = https.get(url, {
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
          'Accept-Language': 'vi-VN,vi;q=0.9,en-US;q=0.8,en;q=0.7',
          'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
        },
        timeout: 3500
      }, (res) => {
        if (res.statusCode !== 200) {
          resolve([]);
          return;
        }

        let html = '';
        res.on('data', chunk => html += chunk);
        res.on('end', () => {
          try {
            const cards: Array<{ title: string; imageUrl: string }> = [];
            const imgTagRegex = /<img[^>]+src=["'](https:\/\/img-global\.cpcdn\.com\/recipes\/[a-zA-Z0-9_-]+\/[^"']+)["'][^>]*>/gi;
            let match;
            while ((match = imgTagRegex.exec(html)) !== null) {
              const fullTag = match[0];
              const src = match[1];

              const altMatch = fullTag.match(/alt=["']([^"']*)["']/i);
              let alt = altMatch ? altMatch[1] : '';
              alt = alt.replace(/^Hình của món\s+/i, '').replace(/^Hình ảnh của\s+/i, '').trim();

              const hqSrc = src.replace(
                /\/(?:120x160[^\s"'/]*|179x133[^\s"'/]*|300x200[^\s"'/]*|300x220[^\s"'/]*|400x400[^\s"'/]*|600x440[^\s"'/]*|680x482[^\s"'/]*)\//,
                '/1200x630cq80/'
              );

              if (alt && !cards.some(c => c.imageUrl === hqSrc)) {
                cards.push({
                  title: alt,
                  imageUrl: hqSrc
                });
              }
            }

            resolve(cards);
          } catch (e) {
            resolve([]);
          }
        });
      });

      req.on('timeout', () => {
        req.destroy();
        resolve([]);
      });

      req.on('error', () => resolve([]));
    } catch (e) {
      resolve([]);
    }
  });
}

/**
 * Cào trực tiếp danh sách hình ảnh chuẩn xác từ Cookpad với hệ thống từ khóa thông minh
 */
export async function crawlCookpadImagesLive(dishName: string, usedImages?: Set<string>): Promise<string[]> {
  const normDish = removeVietnameseAccents(dishName);

  // Xây dựng chuỗi tìm kiếm ưu tiên
  const queries: string[] = [dishName];

  // Tách từ khóa trọng tâm để tìm kiếm mở rộng nếu tên dài
  if (normDish.includes('trung') && normDish.includes('ca chua')) {
    queries.push('trứng xào cà chua', 'canh trứng cà chua', 'trứng chiên sốt cà chua');
  } else if (normDish.includes('tom') && (normDish.includes('dau bap') || normDish.includes('bi ngoi') || normDish.includes('la lot') || normDish.includes('tia to'))) {
    queries.push('tôm xào đậu bắp', 'canh tôm bí ngòi', 'tôm cuốn lá lốt', 'tôm xào rau củ');
  } else if (normDish.includes('ga') && normDish.includes('ca chua')) {
    queries.push('gà sốt cà chua', 'thịt gà xào cà chua', 'ức gà xào cà chua');
  } else if (normDish.includes('dau') && normDish.includes('ca chua')) {
    queries.push('đậu phụ sốt cà chua', 'đậu hũ nhồi thịt sốt cà');
  }

  const allScoredCards: Array<{ title: string; imageUrl: string; score: number }> = [];

  for (const q of queries) {
    const cards = await fetchCookpadCardsByQuery(q);
    for (const card of cards) {
      if (usedImages?.has(card.imageUrl)) continue;
      const score = scoreRecipeCard(card.title, dishName);
      if (score > 15) {
        allScoredCards.push({ ...card, score });
      }
    }
    // Nếu đã tìm thấy thẻ có điểm cao >= 50 thì dừng tìm kiếm
    if (allScoredCards.some(c => c.score >= 50)) {
      break;
    }
  }

  // Sắp xếp theo điểm giảm dần
  allScoredCards.sort((a, b) => b.score - a.score);

  const bestImages = allScoredCards.map(c => c.imageUrl);

  if (allScoredCards.length > 0) {
    const top = allScoredCards[0];
    console.log(`📸 [Cookpad AI Scraper] Đã chọn ảnh chuẩn cho "${dishName}" -> Khớp thẻ: "${top.title}" (Điểm: ${top.score})`);

    // Lưu vào MySQL CSDL để tái sử dụng ngay lập tức
    try {
      const pool = getPool();
      const normKey = removeVietnameseAccents(dishName);
      for (const item of allScoredCards.slice(0, 4)) {
        await pool.query(
          'INSERT IGNORE INTO cookpad_dish_images (query_key, image_url, recipe_title, source) VALUES (?, ?, ?, "cookpad")',
          [normKey, item.imageUrl, item.title]
        );
      }
    } catch (dbErr) {
      // ignore
    }
  }

  return bestImages;
}

/**
 * Tìm ảnh từ CSDL Cookpad (MySQL) theo tên món với thuật toán chấm điểm và ngăn ngừa xung đột nguyên liệu
 */
async function searchCookpadDatabase(recipeName: string, usedImages?: Set<string>): Promise<string | null> {
  try {
    const pool = getPool();
    const cleanName = recipeName.trim();
    const norm = removeVietnameseAccents(cleanName);

    // 1. Tìm chính xác tuyệt đối query_key trong cookpad_dish_images (cả có dấu và không dấu)
    const [exactRows] = await pool.query<any[]>(
      'SELECT image_url, recipe_title FROM cookpad_dish_images WHERE query_key = ? OR query_key = ? LIMIT 15',
      [norm, cleanName.toLowerCase()]
    );

    if (exactRows.length > 0) {
      for (const r of exactRows) {
        if (r.image_url && !usedImages?.has(r.image_url)) {
          const score = scoreRecipeCard(r.recipe_title || norm, recipeName);
          if (score >= 25) {
            return r.image_url;
          }
        }
      }
    }

    // 2. Tìm kiếm ứng viên tương đồng trong cookpad_dish_images
    const [fuzzyRows] = await pool.query<any[]>(
      'SELECT image_url, recipe_title, query_key FROM cookpad_dish_images ORDER BY id DESC LIMIT 300'
    );

    const candidates: Array<{ image_url: string; score: number }> = [];
    for (const r of fuzzyRows) {
      if (r.image_url && !usedImages?.has(r.image_url)) {
        const score = scoreRecipeCard(r.recipe_title || r.query_key, recipeName);
        if (score >= 40) {
          candidates.push({ image_url: r.image_url, score });
        }
      }
    }

    if (candidates.length > 0) {
      candidates.sort((a, b) => b.score - a.score);
      return candidates[0].image_url;
    }

    // 3. Kiểm tra bảng recipes đã lưu trong CSDL
    const [recipeRows] = await pool.query<any[]>(
      'SELECT image_url, name FROM recipes WHERE image_url IS NOT NULL AND image_url != "" LIMIT 220'
    );
    for (const r of recipeRows) {
      if (r.image_url && !usedImages?.has(r.image_url)) {
        const score = scoreRecipeCard(r.name, recipeName);
        if (score >= 45) {
          return r.image_url;
        }
      }
    }
  } catch (err) {
    // ignore
  }
  return null;
}

/**
 * Lấy ảnh món ăn thông minh theo đúng quy trình chuẩn:
 * 1. Tra cứu CSDL Cookpad đã lưu trong MySQL với bộ lọc thông minh
 * 2. Cào trực tiếp hình ảnh chuẩn xác từ trang Cookpad Việt Nam (lọc bento, tạp chất, chấm điểm)
 * 3. Fallback về kho ảnh danh mục ẩm thực Việt Nam chất lượng cao (đảm bảo không trùng lặp)
 */
export async function getFoodImage(
  recipeName: string,
  _imageQuery?: string,
  usedImages?: Set<string>
): Promise<string> {
  const normKey = removeVietnameseAccents(recipeName.trim());

  // 1. Kiểm tra cache bộ nhớ
  if (memoryImageCache.has(normKey)) {
    const list = memoryImageCache.get(normKey)!;
    const available = list.find(img => !usedImages?.has(img));
    if (available) return available;
  }

  // 2. Tra cứu trong Cơ sở dữ liệu Cookpad MySQL
  const dbUrl = await searchCookpadDatabase(recipeName, usedImages);
  if (dbUrl) {
    return dbUrl;
  }

  // 3. Cào trực tiếp từ trang Cookpad Việt Nam theo tên món ăn AI gợi ý
  try {
    const crawledList = await crawlCookpadImagesLive(recipeName, usedImages);
    if (crawledList.length > 0) {
      memoryImageCache.set(normKey, crawledList);
      const available = crawledList.find(img => !usedImages?.has(img));
      if (available) return available;
    }
  } catch (err) {
    // crawl error fallback
  }

  // 4. Dự phòng chuyên biệt theo phân loại món ăn (Category Image Registry)
  const cat = classifyRecipeImageCategory(recipeName);
  const pool = CATEGORY_IMAGE_REGISTRY[cat] || CATEGORY_IMAGE_REGISTRY['general_dish'] || [];
  const fallback = pool.find(img => !usedImages?.has(img));
  if (fallback) {
    return fallback;
  }

  // 5. Nếu pool của danh mục đã dùng hết, lấy từ general_dish
  const generalPool = CATEGORY_IMAGE_REGISTRY['general_dish'] || [];
  const genFallback = generalPool.find(img => !usedImages?.has(img));
  if (genFallback) {
    return genFallback;
  }

  // 6. Trường hợp ngoại lệ cuối cùng: ảnh Unsplash thực phẩm ngẫu nhiên kèm seed duy nhất
  const randomSeed = Math.abs(recipeName.split('').reduce((acc, char) => acc + char.charCodeAt(0), 0) % 1000);
  return `https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&auto=format&fit=crop&q=80&sig=${randomSeed}`;
}
