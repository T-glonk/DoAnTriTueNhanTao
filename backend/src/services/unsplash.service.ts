const UNSPLASH_ACCESS_KEY = process.env.UNSPLASH_ACCESS_KEY || '';
const PEXELS_API_KEY = process.env.PEXELS_API_KEY || '';

// =====================================================================
// Ánh xạ tên món ăn → ảnh Unsplash cụ thể, đúng với món
// Ảnh được chọn thủ công để đảm bảo khớp với từng loại món
// =====================================================================
const DISH_IMAGE_DATABASE: Array<{
  keywords: string[];
  images: string[];
}> = [
  // PHỞ BÒ
  {
    keywords: ['phở bò', 'pho bo', 'pho beef'],
    images: [
      'https://images.unsplash.com/photo-1503764654157-72d979d9af2f?w=600&q=80',
      'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=600&q=80',
    ],
  },
  // PHỞ GÀ
  {
    keywords: ['phở gà', 'pho ga', 'pho chicken'],
    images: [
      'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=600&q=80',
    ],
  },
  // BÚN BÒ HUẾ
  {
    keywords: ['bún bò huế', 'bun bo hue'],
    images: [
      'https://images.unsplash.com/photo-1576577445504-6af96477db52?w=600&q=80',
    ],
  },
  // BÚN / MÌ NÓI CHUNG
  {
    keywords: ['bún', 'bun noodle'],
    images: [
      'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=600&q=80',
      'https://images.unsplash.com/photo-1557872943-16a5ac26437e?w=600&q=80',
    ],
  },
  // MÌ XÀO / STIR FRIED NOODLE
  {
    keywords: ['mì xào', 'mi xao', 'stir fried noodle', 'stir-fried noodle', 'noodle stir'],
    images: [
      'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=600&q=80',
      'https://images.unsplash.com/photo-1548943487-a2e4e43b4853?w=600&q=80',
    ],
  },
  // CƠM CHIÊN / FRIED RICE
  {
    keywords: ['cơm chiên', 'com chien', 'fried rice'],
    images: [
      'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=600&q=80',
      'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=600&q=80',
    ],
  },
  // BÒ KHO
  {
    keywords: ['bò kho', 'bo kho', 'beef stew', 'thịt bò hầm', 'bò hầm'],
    images: [
      'https://images.unsplash.com/photo-1547592180-85f173990554?w=600&q=80',
      'https://images.unsplash.com/photo-1544025162-d76694265947?w=600&q=80',
    ],
  },
  // BÒ XÀO / BEEF STIR FRY
  {
    keywords: ['bò xào', 'bo xao', 'beef stir', 'thịt bò xào', 'xào thịt bò'],
    images: [
      'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=600&q=80',
      'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80',
    ],
  },
  // THỊT BÒ SỐT VANG
  {
    keywords: ['bò sốt vang', 'beef red wine', 'sốt vang'],
    images: [
      'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=600&q=80',
    ],
  },
  // GÀ KHO GỪNG / BRAISED CHICKEN
  {
    keywords: ['gà kho', 'ga kho', 'braised chicken ginger', 'chicken ginger'],
    images: [
      'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=600&q=80',
      'https://images.unsplash.com/photo-1598103442097-8b74394b95c8?w=600&q=80',
    ],
  },
  // GÀ RANG MUỐI
  {
    keywords: ['gà rang', 'ga rang', 'salt roasted chicken', 'crispy chicken'],
    images: [
      'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=600&q=80',
      'https://images.unsplash.com/photo-1587593810167-a84920ea0781?w=600&q=80',
    ],
  },
  // CANH GÀ / CHICKEN SOUP
  {
    keywords: ['canh gà', 'chicken soup', 'gà nấu', 'soup gà'],
    images: [
      'https://images.unsplash.com/photo-1547592180-85f173990554?w=600&q=80',
      'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=600&q=80',
    ],
  },
  // THỊT KHO TRỨNG
  {
    keywords: ['thịt kho trứng', 'thit kho trung', 'pork egg braised', 'caramel pork egg'],
    images: [
      'https://images.unsplash.com/photo-1604908813411-bf0f0c65e38c?w=600&q=80',
      'https://images.unsplash.com/photo-1432139555190-58524dae6a55?w=600&q=80',
    ],
  },
  // SƯỜN XÀO CHUA NGỌT
  {
    keywords: ['sườn xào', 'suon xao', 'sweet sour pork', 'sweet and sour pork'],
    images: [
      'https://images.unsplash.com/photo-1585325701165-8a91d4b33db1?w=600&q=80',
    ],
  },
  // CÁ KHO TỘ
  {
    keywords: ['cá kho', 'ca kho', 'braised fish', 'clay pot fish'],
    images: [
      'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=600&q=80',
      'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=600&q=80',
    ],
  },
  // TÔM XÀO BƠ TỎI
  {
    keywords: ['tôm xào', 'tom xao', 'garlic butter shrimp', 'shrimp garlic', 'tôm bơ tỏi'],
    images: [
      'https://images.unsplash.com/photo-1559737558-2f5a35f4523b?w=600&q=80',
      'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=600&q=80',
    ],
  },
  // CANH CHUA TÔM
  {
    keywords: ['canh chua tôm', 'sour soup shrimp', 'canh chua'],
    images: [
      'https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?w=600&q=80',
      'https://images.unsplash.com/photo-1603105037880-880cd4edfb0d?w=600&q=80',
    ],
  },
  // TRỨNG CHIÊN CÀ CHUA
  {
    keywords: ['trứng chiên cà chua', 'tomato egg', 'egg tomato stir'],
    images: [
      'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=600&q=80',
      'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=600&q=80',
    ],
  },
  // TRỨNG HẤP
  {
    keywords: ['trứng hấp', 'steamed egg', 'trung hap'],
    images: [
      'https://images.unsplash.com/photo-1559703248-dcaaec9fab78?w=600&q=80',
    ],
  },
  // ĐẬU PHỤ SỐT CÀ CHUA
  {
    keywords: ['đậu phụ', 'dau phu', 'tofu tomato', 'tofu sauce'],
    images: [
      'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&q=80',
      'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=600&q=80',
    ],
  },
  // RAU MUỐNG XÀO TỎI
  {
    keywords: ['rau muống', 'morning glory', 'water spinach', 'rau xào'],
    images: [
      'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600&q=80',
      'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=600&q=80',
    ],
  },
  // CANH RAU / VEGETABLE SOUP
  {
    keywords: ['canh rau', 'vegetable soup', 'rau cải', 'canh cải'],
    images: [
      'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=600&q=80',
      'https://images.unsplash.com/photo-1547592180-85f173990554?w=600&q=80',
    ],
  },
  // CANH CÀ CHUA TRỨNG
  {
    keywords: ['canh cà chua', 'tomato egg soup', 'tomato soup'],
    images: [
      'https://images.unsplash.com/photo-1603105037880-880cd4edfb0d?w=600&q=80',
      'https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?w=600&q=80',
    ],
  },
  // KHOAI TÂY
  {
    keywords: ['khoai tây', 'khoai', 'potato', 'potatoes'],
    images: [
      'https://images.unsplash.com/photo-1518977676601-b53f82aba655?w=600&q=80',
      'https://images.unsplash.com/photo-1590165482129-1b8b27698780?w=600&q=80',
    ],
  },
  // SÚP BÍ ĐỎ
  {
    keywords: ['bí đỏ', 'pumpkin', 'butternut', 'squash soup'],
    images: [
      'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=600&q=80',
      'https://images.unsplash.com/photo-1574085733277-851d9d856a3a?w=600&q=80',
    ],
  },
  // SALAD
  {
    keywords: ['salad', 'gỏi'],
    images: [
      'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600&q=80',
      'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=600&q=80',
      'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=600&q=80',
    ],
  },
  // NẤM
  {
    keywords: ['nấm', 'mushroom'],
    images: [
      'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?w=600&q=80',
      'https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?w=600&q=80',
    ],
  },
  // CÀ RI / CURRY
  {
    keywords: ['cà ri', 'curry', 'ca ri'],
    images: [
      'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=600&q=80',
      'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=600&q=80',
    ],
  },
  // LẨU
  {
    keywords: ['lẩu', 'hotpot', 'hot pot'],
    images: [
      'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=600&q=80',
    ],
  },
  // ĐỒ NƯỚNG / BBQ
  {
    keywords: ['nướng', 'grilled', 'bbq', 'barbecue'],
    images: [
      'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=600&q=80',
      'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80',
    ],
  },
];

// Fallback theo category tổng quát
const CATEGORY_FALLBACK: Record<string, string[]> = {
  beef: [
    'https://images.unsplash.com/photo-1544025162-d76694265947?w=600&q=80',
    'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=600&q=80',
    'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=600&q=80',
    'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=600&q=80',
  ],
  chicken: [
    'https://images.unsplash.com/photo-1598103442097-8b74394b95c8?w=600&q=80',
    'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=600&q=80',
    'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=600&q=80',
    'https://images.unsplash.com/photo-1587593810167-a84920ea0781?w=600&q=80',
  ],
  pork: [
    'https://images.unsplash.com/photo-1432139555190-58524dae6a55?w=600&q=80',
    'https://images.unsplash.com/photo-1585325701165-8a91d4b33db1?w=600&q=80',
    'https://images.unsplash.com/photo-1604908813411-bf0f0c65e38c?w=600&q=80',
  ],
  shrimp: [
    'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=600&q=80',
    'https://images.unsplash.com/photo-1559737558-2f5a35f4523b?w=600&q=80',
    'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=600&q=80',
  ],
  fish: [
    'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=600&q=80',
    'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=600&q=80',
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&q=80',
  ],
  egg: [
    'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=600&q=80',
    'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=600&q=80',
    'https://images.unsplash.com/photo-1559703248-dcaaec9fab78?w=600&q=80',
  ],
  soup: [
    'https://images.unsplash.com/photo-1547592180-85f173990554?w=600&q=80',
    'https://images.unsplash.com/photo-1603105037880-880cd4edfb0d?w=600&q=80',
    'https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?w=600&q=80',
    'https://images.unsplash.com/photo-1476718406336-bb5a9690ee2a?w=600&q=80',
  ],
  noodle: [
    'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=600&q=80',
    'https://images.unsplash.com/photo-1585032226651-759b368d7246?w=600&q=80',
    'https://images.unsplash.com/photo-1557872943-16a5ac26437e?w=600&q=80',
    'https://images.unsplash.com/photo-1555126634-323283e090fa?w=600&q=80',
  ],
  rice: [
    'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=600&q=80',
    'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=600&q=80',
  ],
  vegetable: [
    'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600&q=80',
    'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=600&q=80',
    'https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=600&q=80',
  ],
  tofu: [
    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&q=80',
    'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=600&q=80',
  ],
};

// Các category fallback keyword
const CATEGORY_KEYWORDS: Array<[string, string]> = [
  ['beef', 'beef'], ['bò', 'beef'], ['bo ', 'beef'],
  ['chicken', 'chicken'], ['gà', 'chicken'], ['ga ', 'chicken'],
  ['pork', 'pork'], ['heo', 'pork'], ['sườn', 'pork'], ['thịt', 'pork'],
  ['shrimp', 'shrimp'], ['tôm', 'shrimp'], ['tom ', 'shrimp'],
  ['fish', 'fish'], ['cá', 'fish'], ['seafood', 'fish'],
  ['egg', 'egg'], ['trứng', 'egg'],
  ['tofu', 'tofu'], ['đậu phụ', 'tofu'],
  ['soup', 'soup'], ['canh', 'soup'], ['súp', 'soup'],
  ['noodle', 'noodle'], ['pho', 'noodle'], ['bún', 'noodle'], ['mì', 'noodle'],
  ['rice', 'rice'], ['cơm', 'rice'],
  ['vegetable', 'vegetable'], ['rau', 'vegetable'], ['salad', 'vegetable'],
];

/**
 * Lấy ảnh đúng với món ăn — ưu tiên:
 * 1. Unsplash API (nếu có key)
 * 2. Pexels API (nếu có key)
 * 3. Database ảnh cụ thể theo tên món
 * 4. Fallback theo category
 */
export async function getFoodImage(
  imageQuery: string,
  recipeName: string = '',
  usedImages?: Set<string>
): Promise<string> {
  // 1. Thử Unsplash API
  if (UNSPLASH_ACCESS_KEY && UNSPLASH_ACCESS_KEY !== 'your-unsplash-access-key-here') {
    try {
      const q = encodeURIComponent(`${imageQuery} food`);
      const url = `https://api.unsplash.com/search/photos?query=${q}&per_page=8&orientation=landscape&content_filter=high`;
      const res = await fetch(url, {
        headers: { Authorization: `Client-ID ${UNSPLASH_ACCESS_KEY}` },
      });
      if (res.ok) {
        const data = await res.json() as { results: Array<{ urls: { regular: string } }> };
        for (const r of data.results) {
          if (!usedImages?.has(r.urls.regular)) return r.urls.regular;
        }
        if (data.results.length > 0) return data.results[0].urls.regular;
      }
    } catch { /* fallthrough */ }
  }

  // 2. Thử Pexels API
  if (PEXELS_API_KEY && PEXELS_API_KEY !== 'your-pexels-api-key-here') {
    try {
      const q = encodeURIComponent(`${imageQuery} food dish`);
      const url = `https://api.pexels.com/v1/search?query=${q}&per_page=8&orientation=landscape`;
      const res = await fetch(url, {
        headers: { Authorization: PEXELS_API_KEY },
      });
      if (res.ok) {
        const data = await res.json() as { photos: Array<{ src: { large: string } }> };
        for (const p of data.photos) {
          if (!usedImages?.has(p.src.large)) return p.src.large;
        }
        if (data.photos.length > 0) return data.photos[0].src.large;
      }
    } catch { /* fallthrough */ }
  }

  // 3. Tìm trong database ảnh cụ thể theo tên món
  return getMatchedImage(imageQuery, recipeName, usedImages);
}

function getMatchedImage(query: string, recipeName: string, usedImages?: Set<string>): string {
  const combined = `${query} ${recipeName}`.toLowerCase();
  const allCandidates: string[] = [];

  // Tìm ảnh khớp chính xác với tên/query món
  for (const dish of DISH_IMAGE_DATABASE) {
    for (const kw of dish.keywords) {
      if (combined.includes(kw.toLowerCase())) {
        allCandidates.push(...dish.images);
        break;
      }
    }
  }

  // Tìm ảnh theo category nếu chưa đủ
  if (allCandidates.length < 3) {
    for (const [kw, cat] of CATEGORY_KEYWORDS) {
      if (combined.includes(kw)) {
        const imgs = CATEGORY_FALLBACK[cat];
        if (imgs) allCandidates.push(...imgs);
        break;
      }
    }
  }

  // Loại trùng
  const unique = [...new Set(allCandidates)];

  // Ưu tiên ảnh chưa dùng
  const unused = usedImages ? unique.filter(img => !usedImages.has(img)) : unique;
  const pool = unused.length > 0 ? unused : unique;

  if (pool.length > 0) {
    return pool[stringHash(recipeName || query) % pool.length];
  }

  // Ultimate fallback — ảnh đẹp mặc định theo hash
  const defaults = [
    'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=600&q=80',
    'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=600&q=80',
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&q=80',
    'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=600&q=80',
    'https://images.unsplash.com/photo-1499028344343-cd173ffc68a9?w=600&q=80',
    'https://images.unsplash.com/photo-1484723091739-30a097e8f929?w=600&q=80',
    'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=600&q=80',
  ];
  const h = stringHash(recipeName || query);
  return defaults[h % defaults.length];
}

function stringHash(str: string): number {
  let hash = 5381;
  for (let i = 0; i < str.length; i++) {
    hash = (hash * 33) ^ str.charCodeAt(i);
  }
  return Math.abs(hash);
}
