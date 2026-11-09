import https from 'https';
import { getPool } from '../database/db';
import { CATEGORY_IMAGE_REGISTRY, classifyRecipeImageCategory } from './category_images';

const memoryImageCache = new Map<string, string[]>();
const pexelsCache = new Map<string, string[]>();
const PEXELS_API_KEY = process.env.PEXELS_API_KEY || '';

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
 * Chuyển đổi tên món ăn tiếng Việt sang từ khóa ẩm thực tiếng Anh để tìm kiếm trên Pexels
 */
export function translateVietnameseDishToEnglish(name: string): string {
  const norm = removeVietnameseAccents(name);

  // Món ăn đặc trưng Việt Nam
  if (norm.includes('dau phu nhoi thit') || norm.includes('dau hu nhoi thit')) return 'stuffed tofu';
  if (norm.includes('pho bo')) return 'vietnamese beef pho';
  if (norm.includes('pho ga')) return 'vietnamese chicken pho';
  if (norm.includes('bun bo')) return 'vietnamese beef noodle soup';
  if (norm.includes('bun cha')) return 'vietnamese bun cha';
  if (norm.includes('com tam')) return 'vietnamese broken rice';
  if (norm.includes('ca kho to')) return 'caramelized braised fish';
  if (norm.includes('thit kho tau') || norm.includes('thit kho trung')) return 'braised pork belly eggs';
  if (norm.includes('canh chua')) return 'vietnamese sweet sour soup';
  if (norm.includes('goi cuon') || norm.includes('nem cuon')) return 'fresh spring rolls';
  if (norm.includes('nem ran') || norm.includes('cha gio')) return 'crispy spring rolls';
  if (norm.includes('bo luc lac')) return 'shaking beef';

  let method = '';
  if (norm.includes('ap chao')) method = 'pan seared';
  else if (norm.includes('xao')) method = 'stir fry';
  else if (norm.includes('canh') || norm.includes('sup')) method = 'soup';
  else if (norm.includes('chien') || norm.includes('ran')) method = 'crispy fried';
  else if (norm.includes('kho') || norm.includes('rim') || norm.includes('sot')) method = 'braised';
  else if (norm.includes('hap')) method = 'steamed';
  else if (norm.includes('nuong') || norm.includes('quay')) method = 'grilled';
  else if (norm.includes('goi') || norm.includes('nom') || norm.includes('tron')) method = 'salad';
  else if (norm.includes('chao')) method = 'porridge';
  else if (norm.includes('lau')) method = 'hot pot';
  else if (norm.includes('com chien') || norm.includes('com rang')) method = 'fried rice';

  const proteins: string[] = [];
  if (norm.includes('ca hoi')) proteins.push('salmon');
  else if (norm.includes('ca thu')) proteins.push('mackerel');
  else if (norm.includes('ca ngu')) proteins.push('tuna');
  else if (/\bca\b/.test(norm) && !norm.includes('ca chua') && !norm.includes('ca phao') && !norm.includes('ca rot') && !norm.includes('ca tim')) {
    proteins.push('fish');
  }

  if (norm.includes('thit bo') || norm.includes('bo')) proteins.push('beef');
  if (norm.includes('thit ga') || norm.includes('ga')) proteins.push('chicken');
  if (norm.includes('thit heo') || norm.includes('thit lon') || norm.includes('heo') || norm.includes('suon') || norm.includes('ba chi')) proteins.push('pork');
  if (norm.includes('tom') && !norm.includes('mi tom')) proteins.push('shrimp');
  if (norm.includes('muc') || norm.includes('bach tuoc')) proteins.push('squid');
  if (norm.includes('trung')) proteins.push('egg');
  if (norm.includes('dau phu') || norm.includes('dau hu') || norm.includes('tau hu')) proteins.push('tofu');
  if (norm.includes('ech')) proteins.push('frog');

  const veggies: string[] = [];
  if (norm.includes('nam')) veggies.push('mushrooms');
  if (norm.includes('hanh tay')) veggies.push('onions');
  if (norm.includes('ca chua')) veggies.push('tomatoes');
  if (norm.includes('gung')) veggies.push('ginger');
  if (norm.includes('sa')) veggies.push('lemongrass');
  if (norm.includes('bi ngoi')) veggies.push('zucchini');

  const terms: string[] = [];
  if (method && !['soup', 'salad', 'porridge', 'hot pot', 'fried rice'].includes(method)) {
    terms.push(method);
  }
  if (proteins.length > 0) {
    terms.push(proteins.slice(0, 2).join(' and '));
  }
  if (veggies.length > 0) {
    terms.push('with ' + veggies.slice(0, 2).join(' '));
  }
  if (method && ['soup', 'salad', 'porridge', 'hot pot', 'fried rice'].includes(method)) {
    terms.push(method);
  }

  return terms.length > 0 ? terms.join(' ') : `${norm} food`;
}

/**
 * Tìm kiếm hình ảnh ẩm thực chuyên nghiệp, chuẩn xác từ Pexels API
 */
export async function searchPexelsImage(query: string, usedImages?: Set<string>): Promise<string | null> {
  const apiKey = process.env.PEXELS_API_KEY || PEXELS_API_KEY;
  if (!apiKey || apiKey === 'your-pexels-api-key-here') {
    return null;
  }

  const cleanQuery = query.trim().toLowerCase();
  if (!cleanQuery) return null;

  // Kiểm tra cache
  if (pexelsCache.has(cleanQuery)) {
    const list = pexelsCache.get(cleanQuery)!;
    const available = list.find(url => !usedImages?.has(url));
    if (available) return available;
  }

  return new Promise((resolve) => {
    try {
      const url = `https://api.pexels.com/v1/search?query=${encodeURIComponent(cleanQuery)}&per_page=6&orientation=landscape`;
      const req = https.get(url, {
        headers: {
          'Authorization': apiKey,
          'User-Agent': 'FoodAI-Recipe-System/1.0'
        },
        timeout: 4000
      }, (res) => {
        if (res.statusCode !== 200) {
          resolve(null);
          return;
        }

        let data = '';
        res.on('data', chunk => data += chunk);
        res.on('end', () => {
          try {
            const json = JSON.parse(data);
            const photos: string[] = (json.photos || [])
              .map((p: any) => p.src?.large || p.src?.medium)
              .filter(Boolean);

            if (photos.length > 0) {
              pexelsCache.set(cleanQuery, photos);
              const found = photos.find(u => !usedImages?.has(u)) || photos[0];
              console.log(`📸 [Pexels API] Đã chọn ảnh chuẩn HD cho "${query}" -> ${found.substring(0, 60)}...`);
              resolve(found);
            } else {
              resolve(null);
            }
          } catch (e) {
            resolve(null);
          }
        });
      });

      req.on('timeout', () => {
        req.destroy();
        resolve(null);
      });
      req.on('error', () => resolve(null));
    } catch (e) {
      resolve(null);
    }
  });
}

export type CookingMethod =
  | 'canh_sup'
  | 'chao'
  | 'lau'
  | 'goi_nom'
  | 'kho_rim'
  | 'xao'
  | 'chien_ran'
  | 'nuong_quay'
  | 'luoc_hap'
  | 'mon_nuoc'
  | 'other';

/**
 * Trích xuất phương pháp chế biến của món ăn
 */
export function extractCookingMethods(rawText: string): Set<CookingMethod> {
  let norm = removeVietnameseAccents(rawText);
  const rawLower = rawText.toLowerCase();

  // Khử các cụm từ dễ gây nhầm lẫn trước khi xét phương pháp:
  // "còn gọi là", "được gọi là", "hay gọi là" KHÔNG PHẢI là món gỏi/nộm
  norm = norm.replace(/\b(con|duoc|hay|thuong)\s+goi\s+la\b/g, 'called_as');
  norm = norm.replace(/\bgoi\s+la\b/g, 'called_as');

  // "nồi chiên không dầu", "nồi chiên ko dầu", "nckd" KHÔNG PHẢI là phương pháp chiên rán truyền thống
  norm = norm.replace(/\b(noi\s+chien\s+khong\s+dau|noi\s+chien\s+ko\s+dau|noi\s+chien|nckd)\b/g, 'air_fryer');

  const methods = new Set<CookingMethod>();

  // 1. CHÁO (Congee / Porridge)
  const isPanSear = /\b(ap\s+chao|pan\s+sear)\b/.test(norm);
  const isFermentedChao = /\b(chao\s+do|chao\s+trang|chao\s+mon|cham\s+chao|vit\s+nau\s+chao)\b/.test(norm);
  if (/\b(chao)\b/.test(norm) && !isPanSear && !isFermentedChao) {
    methods.add('chao');
  }

  // 2. LẨU (Hotpot)
  if (/\b(lau)\b/.test(norm)) {
    methods.add('lau');
  }

  // 3. GỎI / NỘM / SALAD / MÓN TRỘN
  if (/\b(goi|nom|salad|tron)\b/.test(norm)) {
    const isPackagedGoi = /\b(mi\s+goi|banh\s+goi|goi\s+xoi|goi\s+sot|goi\s+gia\s+vi|dong\s+goi|boc\s+goi|goi\s+nem|called_as)\b/.test(norm);
    if (!isPackagedGoi) {
      methods.add('goi_nom');
    }
  }

  // 4. MÓN NƯỚC & MÌ (Bún, Phở, Miến, Hủ tiếu, Mì gói)
  if (/\b(pho|bun|mien|hu tieu|mi quang|banh canh|mi goi|mi tom|nui)\b/.test(norm)) {
    methods.add('mon_nuoc');
  }

  // 5. CANH / SÚP (Soup)
  // Xử lý quan trọng: "cánh gà" (chicken wing) != "canh gà" (chicken soup)
  const isWingExplicit = /\bcánh\s+(gà|vit|chim)\b/i.test(rawLower);
  const isWingNorm = /\bcanh\s+(ga|vit)\s+(chien|ran|nuong|quay|sot|rim|rang|bo toi|me|cay|lac|mam|gion|chua ngot)\b/.test(norm);
  const isChickenWing = isWingExplicit || isWingNorm;

  if (!isChickenWing) {
    if (/\b(canh|sup|tiem|ham|nau canh|canh chua|nuoc dung)\b/.test(norm)) {
      methods.add('canh_sup');
    }
  }

  // 6. CHIÊN / RÁN / ÁP CHẢO
  if (/\b(chien|ran|ap chao|pan sear|gion|xu|tempura|chien mam)\b/.test(norm) || (isChickenWing && /\b(chien|ran|gion)\b/.test(norm))) {
    methods.add('chien_ran');
  }

  // 7. NƯỚNG / QUAY
  if (/\b(nuong|quay|bbq|sa te|air_fryer)\b/.test(norm)) {
    methods.add('nuong_quay');
  }

  // 8. XÀO
  if (/\b(xao|xao toi|xao sa ot|xao chua ngot|xao rau)\b/.test(norm)) {
    methods.add('xao');
  }

  // 9. KHO / RIM / OM / SỐT / RANG
  if (/\b(kho|rim|om|rang|ram|kho to|sot vang)\b/.test(norm) && !methods.has('canh_sup') && !methods.has('xao')) {
    methods.add('kho_rim');
  } else if (/\bsot\b/.test(norm) && !methods.has('goi_nom') && !methods.has('canh_sup') && !methods.has('xao') && !norm.includes('ap chao')) {
    methods.add('kho_rim');
  }

  // 10. LUỘC / HẤP / CHẦN
  if (/\b(luoc|hap|chan)\b/.test(norm)) {
    methods.add('luoc_hap');
  }

  if (methods.size === 0) {
    methods.add('other');
  }

  return methods;
}

/**
 * Trích xuất chính xác các nguyên liệu chính (Protein / Thành phần cốt lõi)
 */
export function extractPrimaryIngredients(text: string): Set<string> {
  const norm = removeVietnameseAccents(text);
  const sanitized = norm
    .replace(/\bca\s+(chua|phao|tim|rot|bien)\b/g, 'vegetable_$1')
    .replace(/\bmi\s+(tom|goi)\b/g, 'instant_noodles') // Mì tôm / Mì gói không phải là tôm thịt
    .replace(/\b(mam|muoi)\s+(tom|tep)\b/g, 'shrimp_paste') // Mắm tôm / muối tôm KHÔNG PHẢI TÔM TƯƠI
    .replace(/\b(nuoc|mam)\s+(mam|ca|nem|ruoc)\b/g, 'fish_sauce') // Nước mắm / mắm cá KHÔNG PHẢI CÁ TƯƠI
    .replace(/\bdau\s+hao\b/g, 'oyster_sauce') // Dầu hào KHÔNG PHẢI HÀU
    .replace(/\bdau\s+ga\b/g, 'chickpea')
    .replace(/\bnam\s+dui\s+ga\b/g, 'mushroom_stem')
    .replace(/\bqua\s+bo\b/g, 'avocado')
    .replace(/\bbo\s+thuc\s+vat\b/g, 'butter')
    .replace(/\bbo\s+(lat|toi)\b/g, 'butter_$1')
    .replace(/\bthit\s+ga\b/g, 'poultry_meat')
    .replace(/\bthit\s+bo\b/g, 'beef_meat')
    .replace(/\bthit\s+(vit|ngan|de|cuu|ech|luon)\b/g, 'other_meat_$1');

  const detected = new Set<string>();

  // Phân biệt chi tiết từng loài cá cốt lõi để ngăn ngừa xung đột (Cá hồi != Cá thu != Cá ngừ != Cá nục != Cá linh...)
  let foundAnyFish = false;
  if (/\bca\s+ngu\b/.test(sanitized) || /\btuna\b/.test(sanitized)) {
    detected.add('ca_ngu');
    foundAnyFish = true;
  }
  if (/\bca\s+hoi\b/.test(sanitized) || /\b(salmon|truite)\b/.test(sanitized)) {
    detected.add('ca_hoi');
    foundAnyFish = true;
  }
  if (/\bca\s+thu\b/.test(sanitized) || /\bmackerel\b/.test(sanitized)) {
    detected.add('ca_thu');
    foundAnyFish = true;
  }
  if (/\bca\s+com\b/.test(sanitized) || /\banchovy\b/.test(sanitized)) {
    detected.add('ca_com');
    foundAnyFish = true;
  }
  if (/\bca\s+nuc\b/.test(sanitized) || /\bscad\b/.test(sanitized)) {
    detected.add('ca_nuc');
    foundAnyFish = true;
  }
  if (/\b(ca\s+loc|ca\s+qua|ca\s+chuoi|snakehead)\b/.test(sanitized)) {
    detected.add('ca_loc');
    foundAnyFish = true;
  }
  if (/\b(ca\s+dieu\s+hong|ca\s+dieu\s*hong|dieu\s+hong|red\s+tilapia)\b/.test(sanitized)) {
    detected.add('ca_dieu_hong');
    foundAnyFish = true;
  }
  if (/\bca\s+linh\b/.test(sanitized)) {
    detected.add('ca_linh');
    foundAnyFish = true;
  }
  if (/\bca\s+bop\b/.test(sanitized)) {
    detected.add('ca_bop');
    foundAnyFish = true;
  }
  if (/\b(ca\s+basa|ca\s+ba\s+sa|basa)\b/.test(sanitized)) {
    detected.add('ca_basa');
    foundAnyFish = true;
  }
  if (/\bca\s+chep\b/.test(sanitized)) {
    detected.add('ca_chep');
    foundAnyFish = true;
  }
  if (/\bca\s+tre\b/.test(sanitized)) {
    detected.add('ca_tre');
    foundAnyFish = true;
  }
  if (/\b(ca\s+ro|ca\s+ro\s+phi|ro\s+phi)\b/.test(sanitized)) {
    detected.add('ca_ro');
    foundAnyFish = true;
  }
  if (/\bca\s+trich\b/.test(sanitized)) {
    detected.add('ca_trich');
    foundAnyFish = true;
  }
  if (foundAnyFish || /\bca\b/.test(sanitized)) {
    detected.add('ca');
  }

  if (/\b(ga|uc\s+ga|canh\s+ga|dui\s+ga|poultry_meat)\b/.test(sanitized)) {
    detected.add('ga');
  }
  if (/\b(bo|beef_meat|gan\s+bo|bap\s+bo|nam\s+bo)\b/.test(sanitized)) {
    detected.add('bo');
  }
  if (/\b(heo|lon|ba\s+chi|thit\s+bam|thit\s+xay|suon|gio\s+heo|thit\s+nac|thit|cha\s+lua|gio\s+lua|gio\s+song|nem\s+chua|lap\s+xuong|xuc\s+xich|top\s+mo)\b/.test(sanitized)) {
    detected.add('heo');
  }
  if (/\b(tom|tep|tom\s+su|tom\s+dong|shrimp|prawn)\b/.test(sanitized) && !sanitized.includes('instant_noodles') && !sanitized.includes('shrimp_paste')) {
    detected.add('tom');
  }
  if (/\b(muc|bach\s+tuoc|squid|octopus)\b/.test(sanitized)) {
    detected.add('muc');
  }
  if (/\b(trung|trung\s+ga|trung\s+vit|trung\s+cut)\b/.test(sanitized)) {
    detected.add('trung');
  }
  if (/\b(dau\s+phu|dau\s+hu|dau\s+khuon|tau\s+hu|dau\s+non|tofu)\b/.test(sanitized)) {
    detected.add('dau');
  }
  if (/\b(ech|other_meat_ech)\b/.test(sanitized)) {
    detected.add('ech');
  }
  if (/\b(luon|other_meat_luon)\b/.test(sanitized)) {
    detected.add('luon');
  }
  if (/\b(vit|ngan|other_meat_vit|other_meat_ngan)\b/.test(sanitized)) {
    detected.add('vit');
  }
  if (/\b(de|cuu|other_meat_de|other_meat_cuu)\b/.test(sanitized)) {
    detected.add('de');
  }
  if (/\b(cua|ghe|rieu)\b/.test(sanitized)) {
    detected.add('cua');
  }
  if (/\b(ngao|so|hen|ngheu|oc)\b/.test(sanitized)) {
    detected.add('ngao_oc');
  }

  // Tinh bột cốt lõi: CƠM (để phân biệt cơm chiên / cơm trộn với đĩa thịt nướng / gỏi)
  if (/\b(com|rice)\b/.test(sanitized)) {
    detected.add('com');
  }

  return detected;
}

/**
 * Kiểm tra xem URL hình ảnh (dựa vào slug tên món trên URL) có xung đột nghiêm trọng với món ăn mục tiêu hay không
 */
export function isImageUrlConflicting(imageUrl: string, targetDish: string): boolean {
  try {
    const decoded = decodeURIComponent(imageUrl).toLowerCase();
    const filename = (decoded.split('/').pop() || '')
      .replace(/\.(jpg|jpeg|png|webp).*$/i, '')
      .replace(/-recipe-main-photo.*$/i, '')
      .replace(/[-_]/g, ' ');
    const slug = filename.trim();

    const targetMethods = extractCookingMethods(targetDish);
    const slugMethods = extractCookingMethods(slug);
    const targetPrimaries = extractPrimaryIngredients(targetDish);
    const slugPrimaries = extractPrimaryIngredients(slug);
    const normSlug = removeVietnameseAccents(slug);
    const normTarget = removeVietnameseAccents(targetDish);

    const isGenericPhotoSlug = /^(photo|recipe\s*main\s*photo|default|image|\s*)$/i.test(slug);

    // 0. LOẠI TRỪ NGAY CÁC SLUG LÀ MÂM CƠM / COMBO / NHIỀU MÓN HỖN HỢP
    if (slug.includes('+') || normSlug.includes('mam com') || normSlug.includes('bua com') || normSlug.includes('combo') || normSlug.includes('thuc don')) {
      return true;
    }
    // Mâm cơm gia đình kết hợp nhiều món (ví dụ: "thịt bò xào giá + đậu nhồi thịt sốt cà chua + bắp cải luộc")
    const comboMarkers = ['xao gia', 'dau nhoi thit', 'bap cai luoc', 'canh bi ngoi', 'canh kho qua'];
    let comboCount = 0;
    for (const marker of comboMarkers) {
      if (normSlug.includes(marker)) comboCount++;
    }
    if (comboCount >= 2) {
      return true;
    }

    // 1. XUNG ĐỘT PROTEIN CỐT LÕI (PROTEIN CLASH PREVENTION)
    const meatKeys = ['ga', 'bo', 'heo', 'tom', 'ca', 'muc', 'ech', 'luon', 'cua'];
    const targetMeats = [...targetPrimaries].filter(p => meatKeys.includes(p));
    const slugMeats = [...slugPrimaries].filter(p => meatKeys.includes(p));

    const isExternalOrGenericUrl = 
      decoded.includes('encrypted-tbn0') || 
      decoded.includes('unsplash.com') || 
      decoded.includes('pexels.com') || 
      decoded.includes('gstatic.com') ||
      decoded.includes('googleusercontent') ||
      isGenericPhotoSlug ||
      /^[a-f0-9\-_]{16,}$/i.test(slug.replace(/\s/g, ''));

    // A. Nếu slug có loại thịt/hải sản mà món mục tiêu KHÔNG HỀ CÓ -> XUNG ĐỘT TUYỆT ĐỐI!
    for (const sm of slugMeats) {
      if (!targetMeats.includes(sm)) {
        return true; // Ví dụ: Món tôm nhưng slug có thịt heo/bò/mực -> XUNG ĐỘT!
      }
    }

    // B. Nếu slug là một tên món tiếng Việt cụ thể (không phải ID hash/ảnh ngoài):
    // Nếu món mục tiêu có loại thịt/hải sản mà slug cụ thể của Cookpad KHÔNG CÓ -> XUNG ĐỘT!
    if (!isExternalOrGenericUrl && targetMeats.length > 0 && slugMeats.length > 0) {
      for (const tm of targetMeats) {
        if (!slugMeats.includes(tm)) {
          return true; // Món tôm mà slug cụ thể là gà/bò -> XUNG ĐỘT!
        }
      }
    }

    // C. Món đậu phụ (tofu): slug cụ thể phải chứa đậu phụ, không được là mực hấp hay thịt chiên không có đậu
    if (targetPrimaries.has('dau') && !isExternalOrGenericUrl) {
      if (!slugPrimaries.has('dau') && (slugMeats.length > 0 || normSlug.includes('muc') || normSlug.includes('ca'))) {
        return true;
      }
    }

    // D. Món trứng không thịt: slug không được chứa thịt/hải sản
    if (targetPrimaries.has('trung') && targetMeats.length === 0 && slugMeats.length > 0) {
      return true;
    }

    // 2. XUNG ĐỘT TỪNG LOÀI CÁ CỤ THỂ (Cá hồi != Cá thu != Cá cơm != Cá ngừ != Cá nục != Cá linh != Cá điêu hồng...)
    const specificFishList = [
      'ca_hoi', 'ca_thu', 'ca_ngu', 'ca_com', 'ca_nuc', 'ca_loc',
      'ca_dieu_hong', 'ca_linh', 'ca_bop', 'ca_basa', 'ca_chep', 'ca_tre', 'ca_ro', 'ca_trich'
    ];
    for (const f of specificFishList) {
      if (targetPrimaries.has(f)) {
        // Nếu món mục tiêu là loài cá cụ thể (ví dụ cá hồi), slug KHÔNG ĐƯỢC là loài cá khác
        const otherFishes = specificFishList.filter(o => o !== f);
        for (const ofish of otherFishes) {
          if (slugPrimaries.has(ofish)) {
            return true; // Món cá hồi nhưng ảnh cá thu hoặc cá cơm!
          }
        }
      }
    }

    // Nếu món có thịt/hải sản nhưng slug ảnh lại là món chay/rau hoàn toàn hoặc mì gói
    if (targetMeats.length > 0 && slugMeats.length === 0 && !isExternalOrGenericUrl) {
      if (slug.includes('tien vua') || slug.includes('canh dua') || slug.includes('chay') || slug.includes('salad') || slug.includes('rau muong') || slug.includes('mi goi')) {
        return true;
      }
    }

    // 3. XUNG ĐỘT CƠM (Rice dishes):
    // Nếu món là Cơm (cơm chiên, cơm rang, cơm trộn), slug nếu cụ thể BẮT BUỘC phải có cơm
    if (targetPrimaries.has('com') && !isGenericPhotoSlug) {
      if (!slugPrimaries.has('com') && (normSlug.includes('cuon') || normSlug.includes('nuong') || normSlug.includes('canh') || normSlug.includes('kho'))) {
        return true; // Món cơm chiên nhưng ảnh lại là thịt cuộn hoặc canh
      }
    }

    // 4. Cháo conflict: Nếu món cần tìm là Cháo mà URL slug không phải cháo hoặc là áp chảo / xào / chiên
    if (targetMethods.has('chao')) {
      if (!slugMethods.has('chao') || normSlug.includes('ap chao') || normSlug.includes('xao') || normSlug.includes('chien')) {
        return true;
      }
    } else if (slugMethods.has('chao') && !targetMethods.has('chao') && !normSlug.includes('ap chao')) {
      return true; // Món không phải cháo nhưng ảnh là cháo
    }

    // 5. Canh conflict: Nếu món cần tìm là Canh mà URL slug là chiên / áp chảo / nướng / sốt / kho
    if (targetMethods.has('canh_sup')) {
      if (slugMethods.has('chien_ran') || slugMethods.has('nuong_quay') || slugMethods.has('kho_rim') ||
          normSlug.includes('ap chao') || normSlug.includes('pan sear') ||
          slug.includes('canh ga chien') || slug.includes('canh ga sot') || slug.includes('canh ga nuong')) {
        return true;
      }
    }

    // 6. Gỏi / Trộn conflict: Nếu món là Gỏi/Nộm/Trộn, slug KHÔNG ĐƯỢC là món kho, canh, súp, cháo, chiên
    if (targetMethods.has('goi_nom')) {
      if (slugMethods.has('goi_nom')) {
        // Cùng là món gỏi/nộm -> Hoàn toàn phù hợp
      } else if (slugMethods.has('kho_rim') || slugMethods.has('canh_sup') || slugMethods.has('chao') || normSlug.includes('bo kho') || normSlug.includes('sot vang') || normSlug.includes('kho to')) {
        return true; // Món "Bò trộn" nhưng ảnh là "Bò kho / Bò sốt vang"
      }
      if (normSlug.includes('mi goi') || normSlug.includes('banh goi')) {
        return true;
      }
    }

    // 7. Kho / Rim conflict: Món kho không được là canh / cháo / gỏi / áp chảo
    if (targetMethods.has('kho_rim') && !targetMethods.has('goi_nom') && !targetMethods.has('chien_ran') && !normTarget.includes('ap chao')) {
      if (slugMethods.has('canh_sup') || slugMethods.has('chao') || slugMethods.has('goi_nom') || (!normTarget.includes('ap chao') && normSlug.includes('ap chao'))) {
        return true;
      }
    }

    return false;
  } catch (e) {
    return false;
  }
}

/**
 * Thuật toán chấm điểm mức độ khớp của món ăn Cookpad
 */
export function scoreRecipeCard(cardTitle: string, targetDish: string): number {
  const normTitle = removeVietnameseAccents(cardTitle);
  const normTarget = removeVietnameseAccents(targetDish);

  // 1. Loại bỏ các từ khóa tiêu cực
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

  if (cardTitle.includes('+') || cardTitle.includes('&') || (cardTitle.includes('.') && normTitle.split('.').length > 2)) {
    return -100;
  }

  // Loại trừ các mâm cơm nhiều món (ví dụ: bắp cải luộc + đậu nhồi thịt...)
  const comboMarkers = ['xao gia', 'dau nhoi thit', 'bap cai luoc', 'canh bi ngoi', 'canh kho qua'];
  let comboCount = 0;
  for (const marker of comboMarkers) {
    if (normTitle.includes(marker)) comboCount++;
  }
  if (comboCount >= 2) {
    return -100;
  }

  // 2. KIỂM TRA PHƯƠNG PHÁP CHẾ BIẾN (COOKING METHOD COMPATIBILITY)
  const targetMethods = extractCookingMethods(targetDish);
  const titleMethods = extractCookingMethods(cardTitle);

  // CHÁO: Món cháo chỉ được khớp với ảnh Cháo!
  if (targetMethods.has('chao')) {
    if (!titleMethods.has('chao')) {
      return -100;
    }
  } else if (titleMethods.has('chao') && !targetMethods.has('chao')) {
    return -100;
  }

  // GỎI / NỘM / SALAD:
  if (targetMethods.has('goi_nom')) {
    if (!titleMethods.has('goi_nom') || titleMethods.has('canh_sup') || normTitle.includes('bo kho') || normTitle.includes('sot vang')) {
      return -100;
    }
  } else if (titleMethods.has('goi_nom') && !targetMethods.has('goi_nom')) {
    return -100;
  }

  // LẨU:
  if (targetMethods.has('lau')) {
    if (!titleMethods.has('lau')) {
      return -100;
    }
  } else if (titleMethods.has('lau') && !targetMethods.has('lau')) {
    return -100;
  }

  // CANH / SÚP: Món Canh không được khớp với Chiên, Nướng, Kho, Xào, Áp chảo
  if (targetMethods.has('canh_sup')) {
    if (titleMethods.has('chien_ran') || titleMethods.has('nuong_quay') || titleMethods.has('kho_rim') || titleMethods.has('xao') || normTitle.includes('ap chao')) {
      return -100;
    }
  }

  // CHIÊN / RÁN / ÁP CHẢO: Món Chiên không khớp với Canh / Cháo / Luộc
  if (targetMethods.has('chien_ran')) {
    if (titleMethods.has('canh_sup') || titleMethods.has('chao') || titleMethods.has('luoc_hap')) {
      return -100;
    }
  }

  // KHO / RIM: Món Kho không khớp với Canh / Cháo / Gỏi
  if (targetMethods.has('kho_rim') && !targetMethods.has('goi_nom') && !targetMethods.has('chien_ran') && !normTarget.includes('ap chao')) {
    if (titleMethods.has('canh_sup') || titleMethods.has('chao') || titleMethods.has('goi_nom') || (!normTarget.includes('ap chao') && normTitle.includes('ap chao'))) {
      return -100;
    }
  }

  // 3. KIỂM TRA NGUYÊN LIỆU CHÍNH (PRIMARY INGREDIENTS)
  const targetPrimaries = extractPrimaryIngredients(targetDish);
  const titlePrimaries = extractPrimaryIngredients(cardTitle);

  // MÓN CƠM (Cơm chiên, cơm tấm, cơm rang, cơm trộn): BẮT BUỘC title phải chứa Cơm!
  if (targetPrimaries.has('com')) {
    if (!titlePrimaries.has('com') && (normTitle.includes('cuon') || normTitle.includes('nuong') || normTitle.includes('canh'))) {
      return -100;
    }
  }

  // XUNG ĐỘT TỪNG LOÀI CÁ:
  const specificFishList = ['ca_hoi', 'ca_thu', 'ca_ngu', 'ca_com', 'ca_nuc', 'ca_loc'];
  for (const f of specificFishList) {
    if (targetPrimaries.has(f)) {
      const otherFishes = specificFishList.filter(o => o !== f);
      for (const ofish of otherFishes) {
        if (titlePrimaries.has(ofish)) {
          return -100; // Khác loài cá -> Loại bỏ!
        }
      }
    }
  }

  const meatTypes = ['ga', 'bo', 'heo', 'tom', 'ca', 'muc', 'ech', 'luon', 'cua', 'ngao_oc'];
  const targetMeats = [...targetPrimaries].filter(p => meatTypes.includes(p));
  const titleMeats = [...titlePrimaries].filter(p => meatTypes.includes(p));

  // BẮT BUỘC: Nếu món mục tiêu có thịt/hải sản cụ thể, card BẮT BUỘC phải khớp loại thịt/hải sản đó!
  if (targetMeats.length > 0) {
    const hasMatchingMeat = targetMeats.some(tm => {
      if (titleMeats.includes(tm)) return true;
      if (tm === 'ech') return normTitle.includes('ech');
      if (tm === 'heo') return normTitle.includes('suon') || normTitle.includes('heo') || normTitle.includes('thit') || normTitle.includes('ba chi') || normTitle.includes('cha lua');
      if (tm === 'ga') return normTitle.includes('ga') && !normTitle.includes('ca chua') && !normTitle.includes('dau ga');
      if (tm === 'bo') return normTitle.includes('bo') && !normTitle.includes('bo toi') && !normTitle.includes('qua bo');
      if (tm === 'tom') return (normTitle.includes('tom') || normTitle.includes('tep')) && !normTitle.includes('mi tom');
      if (tm === 'ca') return normTitle.includes('ca') && !normTitle.includes('ca chua') && !normTitle.includes('ca phao') && !normTitle.includes('ca rot') && !normTitle.includes('ca tim') && !normTitle.includes('ca ri');
      if (tm === 'muc') return normTitle.includes('muc') || normTitle.includes('bach tuoc');
      if (tm === 'luon') return normTitle.includes('luon');
      if (tm === 'cua') return normTitle.includes('cua') || normTitle.includes('ghe');
      if (tm === 'ngao_oc') return normTitle.includes('ngao') || normTitle.includes('so') || normTitle.includes('hen') || normTitle.includes('ngheu') || normTitle.includes('oc');
      return false;
    });

    if (!hasMatchingMeat) {
      return -100; // Khác loại thịt hoặc thiếu thịt cốt lõi -> Loại bỏ ngay lập tức!
    }

    // NGHIÊM CẤM THỊT LẠ ĐỐI KHÁNG: Nếu món mục tiêu không phải thập cẩm
    if (!normTarget.includes('thap cam')) {
      const isTargetStuffed = normTarget.includes('nhoi') || normTarget.includes('cuon thit');
      for (const tm of titleMeats) {
        if (!targetMeats.includes(tm)) {
          // Cho phép thịt heo nếu món mục tiêu là nhồi thịt (đậu nhồi thịt, khổ qua nhồi thịt...)
          if (tm === 'heo' && isTargetStuffed) continue;
          return -100; // Dính thịt lạ đối kháng -> Loại bỏ ngay!
        }
      }
    }
  } else {
    // Món mục tiêu KHÔNG có thịt (rau củ, đậu hũ thuần, nấm, trứng...)
    // Ngoại lệ: target có từ nhồi thịt
    const isTargetStuffed = normTarget.includes('nhoi') || normTarget.includes('cuon thit');
    if (!isTargetStuffed && titleMeats.length > 0) {
      return -100; // Món rau củ chay tuyệt đối không nhận card có thịt/cá/hải sản!
    }
  }

  // Đặc cách: Đậu phụ / Đậu hũ nhồi thịt
  const isTargetTofuStuffed = targetPrimaries.has('dau') && (targetPrimaries.has('heo') || targetPrimaries.has('ga') || normTarget.includes('nhoi'));
  const isTitleTofuStuffed = titlePrimaries.has('dau') && (titlePrimaries.has('heo') || titlePrimaries.has('ga') || normTitle.includes('nhoi'));

  if (!(isTargetTofuStuffed && isTitleTofuStuffed)) {
    if (targetMeats.length > 0 && titleMeats.length > 0) {
      const hasMatchingMeat = targetMeats.some(tm => titleMeats.includes(tm));
      if (!hasMatchingMeat) {
        return -100;
      }
    }
  }

  if (targetPrimaries.has('dau') && targetMeats.length === 0 && titleMeats.length > 0) {
    return -100;
  }

  if (targetPrimaries.has('trung') && !titlePrimaries.has('trung') && targetMeats.length === 0 && !normTitle.includes('trung')) {
    return -100;
  }
  if (!targetPrimaries.has('trung') && titlePrimaries.has('trung') && !normTarget.includes('trung')) {
    return -100;
  }

  if ((targetMeats.length > 0 || normTarget.includes('chay')) && normTitle.includes('chay') && !normTarget.includes('chay')) {
    return -100;
  }
  if (normTarget.includes('chay') && titleMeats.length > 0) {
    return -100;
  }

  // 4. TÁCH VÀ TÍNH ĐIỂM TỪ KHÓA
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

  if (normTitle.includes(normTarget) || normTarget.includes(normTitle)) {
    score += 80;
  }

  if (targetPrimaries.has('ca_ngu') && normTitle.includes('ca ngu')) {
    score += 50;
  }
  if (targetMethods.has('chao') && normTitle.includes('chao')) {
    score += 50;
  }
  if (targetMethods.has('goi_nom') && (normTitle.includes('goi') || normTitle.includes('nom')) && !normTitle.includes('mi goi') && !normTitle.includes('goi sot')) {
    score += 50;
  }
  if (targetMethods.has('canh_sup') && normTitle.includes('canh')) {
    score += 40;
  }

  return Math.round(score);
}

/**
 * Xây dựng danh sách từ khóa tìm kiếm Cookpad chuyên biệt theo dạng món ăn
 */
function buildTargetedCookpadQueries(dishName: string): string[] {
  const norm = removeVietnameseAccents(dishName);
  const queries: string[] = [dishName];

  // 0. Món Ếch (Đặc biệt quan trọng)
  if (norm.includes('ech')) {
    if (norm.includes('xao')) {
      queries.push('ếch xào sả ớt', 'ếch xào lăn', 'đùi ếch xào sả ớt');
    } else if (norm.includes('chien')) {
      queries.push('ếch chiên nước mắm', 'ếch chiên giòn', 'đùi ếch chiên');
    } else if (norm.includes('chao')) {
      queries.push('cháo ếch singapore', 'cháo ếch');
    } else if (norm.includes('lau')) {
      queries.push('lẩu ếch măng cay', 'lẩu ếch');
    } else if (norm.includes('nuong')) {
      queries.push('ếch nướng sa tế', 'ếch nướng lá lốt');
    } else if (norm.includes('kho') || norm.includes('om')) {
      queries.push('ếch kho sả ớt', 'ếch om chuối đậu', 'ếch kho tiêu');
    } else {
      queries.push('ếch xào sả ớt', 'ếch chiên nước mắm', 'cháo ếch');
    }
    return queries;
  }

  // 1. Sườn Heo
  if (norm.includes('suon')) {
    if (norm.includes('chua ngot') || norm.includes('xao')) {
      queries.push('sườn xào chua ngọt', 'sườn sốt chua ngọt', 'sườn xào ớt chuông');
    } else if (norm.includes('nuong')) {
      queries.push('sườn nướng mật ong', 'sườn nướng');
    } else if (norm.includes('kho') || norm.includes('rim')) {
      queries.push('sườn kho tiêu', 'sườn rim mặn ngọt', 'sườn ram');
    } else if (norm.includes('canh')) {
      queries.push('canh sườn chua', 'canh sườn nấu sấu', 'canh sườn');
    } else if (norm.includes('chao')) {
      queries.push('cháo sườn');
    } else {
      queries.push('sườn xào chua ngọt', 'sườn kho tiêu');
    }
    return queries;
  }

  // 2. Món Cháo
  if (norm.includes('chao')) {
    if (norm.includes('ga')) {
      queries.push('cháo gà', 'cháo gà hành phi', 'cháo gà nấm');
    } else if (norm.includes('ca')) {
      queries.push('cháo cá', 'cháo cá hồi', 'cháo cá lóc');
    } else if (norm.includes('bo')) {
      queries.push('cháo bò', 'cháo thịt bò');
    } else if (norm.includes('suon') || norm.includes('heo') || norm.includes('thit')) {
      queries.push('cháo sườn', 'cháo thịt băm');
    }
    return queries;
  }

  // 3. Món Canh
  if (norm.includes('canh')) {
    if (norm.includes('ga')) {
      if (norm.includes('ca chua')) queries.push('canh gà cà chua', 'canh gà nấu chua', 'canh chua gà');
      queries.push('canh gà lá giang', 'canh gà', 'canh chua gà');
    } else if (norm.includes('ca ngu') || norm.includes('ca')) {
      queries.push('canh chua cá', 'canh cá ngừ', 'canh cá nấu ngót');
    } else if (norm.includes('trung') && norm.includes('ca chua')) {
      queries.push('canh trứng cà chua');
    } else if (norm.includes('tom')) {
      queries.push('canh tôm', 'canh tôm nấu chua', 'canh tôm bí');
    } else if (norm.includes('suon') || norm.includes('thit')) {
      queries.push('canh sườn chua', 'canh thịt băm');
    }
    return queries;
  }

  // 4. Món Gỏi / Nộm
  if (norm.includes('goi') || norm.includes('nom')) {
    if (norm.includes('ga')) {
      queries.push('gỏi gà', 'gỏi gà xé phay', 'nộm gà', 'gỏi gà bắp cải');
    } else if (norm.includes('tom')) {
      queries.push('gỏi tôm', 'nộm tôm thịt');
    } else if (norm.includes('bo')) {
      queries.push('gỏi bò', 'nộm bò bóp thấu');
    }
    return queries;
  }

  // 5. Món Cá Ngừ & Cá
  if (norm.includes('ca ngu')) {
    if (norm.includes('ap chao') || norm.includes('sot')) {
      queries.push('cá ngừ áp chảo sốt cà chua', 'cá ngừ áp chảo', 'cá ngừ sốt cà chua', 'cá sốt cà chua');
    } else if (norm.includes('kho')) {
      queries.push('cá ngừ kho cà chua', 'cá ngừ kho', 'cá kho cà chua');
    }
    return queries;
  }

  // 6. Món Gà Chiên / Kho
  if (norm.includes('ga')) {
    if (norm.includes('chien') || norm.includes('nuoc mam')) {
      queries.push('gà chiên nước mắm', 'cánh gà chiên mắm', 'đùi gà chiên nước mắm', 'gà chiên giòn');
    } else if (norm.includes('kho') || norm.includes('rang')) {
      queries.push('gà kho sả ớt', 'gà rang sả ớt', 'gà kho gừng');
    }
    return queries;
  }

  // 7. Món Bò (Đặc biệt quan trọng)
  if (norm.includes('bo')) {
    if (norm.includes('hanh tay')) {
      queries.push('thịt bò xào hành tây', 'bò xào hành tây');
    }
    if (norm.includes('ap chao') || norm.includes('bit tet')) {
      queries.push('thịt bò áp chảo', 'bò áp chảo', 'bò bít tết', 'bò lúc lắc');
    } else if (norm.includes('canh') || norm.includes('sup')) {
      if (norm.includes('ca chua')) {
        queries.push('canh thịt bò cà chua', 'canh bò cà chua', 'canh thịt bò');
      } else {
        queries.push('canh thịt bò cà chua', 'canh dưa chua bắp bò', 'canh bò');
      }
    } else if (norm.includes('xao')) {
      queries.push('thịt bò xào hành tây', 'bò lúc lắc', 'bò xào cần tỏi', 'bò xào măng tây');
    } else if (norm.includes('kho') || norm.includes('sot vang')) {
      queries.push('bò sốt vang', 'bò kho');
    } else {
      queries.push('thịt bò xào hành tây', 'bò áp chảo', 'bò lúc lắc');
    }
    return queries;
  }

  // 8. Món Tôm
  if (norm.includes('tom')) {
    if (norm.includes('rim') || norm.includes('rang')) {
      queries.push('tôm rim mặn ngọt', 'tôm rang thịt ba chỉ', 'tôm rim thịt');
    } else if (norm.includes('hap')) {
      queries.push('tôm hấp sả', 'tôm hấp bia');
    } else if (norm.includes('chien')) {
      queries.push('tôm chiên xù', 'tôm chiên giòn');
    } else {
      queries.push('tôm rim mặn ngọt', 'tôm hấp sả');
    }
    return queries;
  }

  // 9. Món Trứng
  if (norm.includes('trung')) {
    if (norm.includes('ca chua')) {
      queries.push('trứng xào cà chua', 'trứng sốt cà chua', 'canh trứng cà chua');
    } else {
      queries.push('trứng chiên', 'trứng cuộn');
    }
    return queries;
  }

  return queries;
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
  const queries = buildTargetedCookpadQueries(dishName);
  const allScoredCards: Array<{ title: string; imageUrl: string; score: number }> = [];

  for (const q of queries) {
    const cards = await fetchCookpadCardsByQuery(q);
    for (const card of cards) {
      if (usedImages?.has(card.imageUrl)) continue;
      if (isImageUrlConflicting(card.imageUrl, dishName)) continue;

      const score = scoreRecipeCard(card.title, dishName);
      if (score >= 40) {
        allScoredCards.push({ ...card, score });
      }
    }
    if (allScoredCards.some(c => c.score >= 70)) {
      break;
    }
  }

  allScoredCards.sort((a, b) => b.score - a.score);
  const bestImages = allScoredCards.map(c => c.imageUrl);

  if (allScoredCards.length > 0) {
    const top = allScoredCards[0];
    console.log(`📸 [Cookpad AI Scraper] Đã chọn ảnh chuẩn cho "${dishName}" -> Khớp thẻ: "${top.title}" (Điểm: ${top.score})`);

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

    // 0. ƯU TIÊN SỐ 1 TUYỆT ĐỐI: Tra cứu trực tiếp từ kho món ăn Admin (bảng recipes)
    // Giúp mọi món do Admin cập nhật ảnh (kể cả ảnh Base64 hoặc CDN) được đồng bộ 100% khi AI gợi ý
    const [adminRows] = await pool.query<any[]>(
      `SELECT image_url, name FROM recipes 
       WHERE (LOWER(TRIM(name)) = LOWER(?) OR LOWER(TRIM(name)) = LOWER(?) OR name LIKE ?)
         AND image_url IS NOT NULL AND image_url != ''
       ORDER BY (CASE WHEN LOWER(TRIM(name)) = LOWER(?) THEN 1 ELSE 2 END), updated_at DESC, id DESC LIMIT 5`,
      [cleanName, norm, `%${cleanName}%`, cleanName]
    );

    if (adminRows.length > 0) {
      for (const r of adminRows) {
        if (r.image_url && !usedImages?.has(r.image_url)) {
          if (!isImageUrlConflicting(r.image_url, recipeName)) {
            console.log(`🎯 [Admin Sync] Đồng bộ ảnh trực tiếp từ kho Admin cho món "${recipeName}" -> "${r.name}"`);
            return r.image_url;
          }
        }
      }
    }

    // 1. Tìm chính xác tuyệt đối query_key trong cookpad_dish_images
    const [exactRows] = await pool.query<any[]>(
      'SELECT image_url, recipe_title FROM cookpad_dish_images WHERE query_key = ? OR query_key = ? LIMIT 15',
      [norm, cleanName.toLowerCase()]
    );

    if (exactRows.length > 0) {
      for (const r of exactRows) {
        if (r.image_url && !usedImages?.has(r.image_url)) {
          if (isImageUrlConflicting(r.image_url, recipeName)) continue;
          const score = scoreRecipeCard(r.recipe_title || norm, recipeName);
          if (score >= 40) {
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
        if (isImageUrlConflicting(r.image_url, recipeName)) continue;
        const score = scoreRecipeCard(r.recipe_title || r.query_key, recipeName);
        if (score >= 50) {
          candidates.push({ image_url: r.image_url, score });
        }
      }
    }

    if (candidates.length > 0) {
      candidates.sort((a, b) => b.score - a.score);
      return candidates[0].image_url;
    }

    // 3. Kiểm tra toàn bộ bảng recipes chuẩn trong CSDL
    const [recipeRows] = await pool.query<any[]>(
      'SELECT image_url, name FROM recipes WHERE image_url LIKE "%cpcdn%" AND (author_name IS NULL OR author_name != "AI Chef & Nutritionist") AND (source_url IS NULL OR source_url NOT LIKE "%foodai%")'
    );
    for (const r of recipeRows) {
      if (r.image_url && !usedImages?.has(r.image_url)) {
        if (isImageUrlConflicting(r.image_url, recipeName)) continue;
        const score = scoreRecipeCard(r.name, recipeName);
        if (score >= 50) {
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
  imageQuery?: string,
  usedImages?: Set<string>
): Promise<string> {
  const normKey = removeVietnameseAccents(recipeName.trim());

  // 1. Kiểm tra cache bộ nhớ
  if (memoryImageCache.has(normKey)) {
    const list = memoryImageCache.get(normKey)!;
    const available = list.find(img => !usedImages?.has(img) && !isImageUrlConflicting(img, recipeName));
    if (available) return available;
  }

  // 2. Tra cứu trong Cơ sở dữ liệu Cookpad MySQL (100% Ẩm thực Việt Nam chính xác)
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

  // 4. Dự phòng chuyên biệt theo phân loại món ăn (Category Image Registry 100% Cookpad chuẩn xác)
  const cat = classifyRecipeImageCategory(recipeName);
  const pool = CATEGORY_IMAGE_REGISTRY[cat] || CATEGORY_IMAGE_REGISTRY['general_dish'] || [];
  const fallback = pool.find(img => !usedImages?.has(img) && !isImageUrlConflicting(img, recipeName));
  if (fallback) {
    return fallback;
  }

  // 5. Nếu pool của danh mục đã dùng hết, lấy từ general_dish
  const generalPool = CATEGORY_IMAGE_REGISTRY['general_dish'] || [];
  const genFallback = generalPool.find(img => !usedImages?.has(img) && !isImageUrlConflicting(img, recipeName));
  if (genFallback) {
    return genFallback;
  }

  // 6. Dự phòng Pexels API (Chỉ khi kho ảnh Cookpad chưa có)
  if (imageQuery) {
    const pexelsUrl = await searchPexelsImage(imageQuery, usedImages);
    if (pexelsUrl) {
      memoryImageCache.set(normKey, [pexelsUrl]);
      return pexelsUrl;
    }
  }

  const englishQuery = translateVietnameseDishToEnglish(recipeName);
  const pexelsFromDish = await searchPexelsImage(englishQuery, usedImages);
  if (pexelsFromDish) {
    memoryImageCache.set(normKey, [pexelsFromDish]);
    return pexelsFromDish;
  }

  // 7. Trường hợp ngoại lệ cuối cùng: Dùng ảnh món ăn chất lượng cao từ Pexels
  return 'https://images.pexels.com/photos/27039847/pexels-photo-27039847.jpeg?auto=compress&cs=tinysrgb&h=650&w=940';
}
