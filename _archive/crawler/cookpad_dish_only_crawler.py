"""
Cookpad VN Dish & Image Crawler (Chỉ cào Tên món ăn & Hình ảnh chất lượng cao)
Công thức, cách làm và dinh dưỡng sẽ do AI (Google Gemini) tự động sinh ra.
"""

import os
import sys
import io
import re
import json
import time
import random
import uuid
from typing import List, Dict, Any, Optional
from urllib.parse import quote
import requests
from bs4 import BeautifulSoup

# Hỗ trợ UTF-8 output trên Windows console
if sys.platform == 'win32':
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
    sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding='utf-8', errors='replace')

BASE_URL = "https://cookpad.com"
SEARCH_URL = "https://cookpad.com/vn/tim-kiem/{query}?page={page}"

HEADERS = {
    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Safari/537.36',
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8',
    'Accept-Language': 'vi,en-US;q=0.9,en;q=0.8',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive'
}

# Danh sách từ khóa tìm kiếm bao phủ toàn diện ẩm thực Việt Nam
SEARCH_KEYWORDS = [
    # Món Thịt Heo
    "thịt kho tàu", "thịt ba chỉ rang cháy cạnh", "sườn xào chua ngọt", "thịt heo chiên xù",
    "thịt băm xào cà chua", "thịt luộc chấm mắm", "sườn kho tiêu", "thịt nướng than hoa",
    "thịt ba rọi kho trứng", "chả lụa chiên", "thịt băm hấp trứng", "sườn non nướng mật ong",
    
    # Món Thịt Bò
    "thịt bò xào cần tỏi", "bò sốt vang", "bò kho gừng", "bò lúc lắc", "bò cuộn nấm kim châm",
    "thịt bò xào hoa thiên lý", "bò bít tết sốt tiêu đen", "canh dưa chua thịt bò",
    "phở bò truyền thống", "bò xào măng tây", "thịt bò xào ớt chuông", "bắp bò ngâm mắm",
    
    # Món Thịt Gà
    "gà rang sả ớt", "gà chiên nước mắm", "gà kho gừng", "gà hấp lá chanh", "gà sốt chua ngọt",
    "cánh gà chiên giòn", "canh gà lá giang", "gỏi gà bắp cải", "gà nướng muối ớt",
    "ức gà áp chảo sốt bơ tỏi", "thịt gà xào nấm", "gà xào chua ngọt",
    
    # Món Thịt Vịt
    "vịt om sấu", "vịt nấu chao", "vịt quay giòn da", "thịt vịt xào sả ớt", "gỏi vịt",
    
    # Món Cá
    "cá kho tộ", "canh chua cá lóc", "cá điêu hồng chiên giòn", "cá hồi áp chảo sốt bơ tỏi",
    "cá chép om dưa", "cá thu sốt cà chua", "cá bớp nấu ngót", "cá nục kho tiêu",
    "chả cá Lã Vọng", "cá hấp xì dầu", "canh cá nấu măng chua", "cá hồi sốt cam",
    
    # Món Tôm & Mực & Hải sản
    "tôm rim mặn ngọt", "tôm hấp nước dừa", "tôm rang muối", "canh rau ngót nấu tôm",
    "tôm chiên xù giòn rụm", "mực xào cần tỏi", "mực hấp gừng sả", "mực chiên nước mắm",
    "bạch tuộc nướng sa tế", "chả mực giã tay", "nghêu hấp sả ớt", "canh ngao nấu chua",
    "ốc nhồi xào sả ớt", "ếch xào lăn", "lươn xào sả ớt", "canh cua rau đay",
    
    # Món Trứng & Đậu phụ
    "đậu phụ sốt cà chua", "đậu hũ nhồi thịt băm", "đậu hũ chiên sả ớt", "đậu non sốt nấm thịt băm",
    "trứng chiên thịt băm", "trứng cuộn xúc xích", "canh cà chua trứng", "trứng kho thịt ba chỉ",
    "trứng ốp la sốt cà", "đậu hũ lướt ván",
    
    # Món Rau Củ & Canh Thanh Đạm
    "rau muống xào tỏi", "cải thìa xào nấm đông cô", "canh bí đỏ nấu thịt băm", "canh mướp nấu tôm",
    "canh khổ qua nhồi thịt", "canh kim chi thịt bò", "rau củ luộc kho quẹt", "nộm hoa chuối tai heo",
    "gỏi ngó sen tôm thịt", "khoai tây xào thịt bò", "súp gà ngô non", "canh sườn nấu sấu",
    
    # Món Bún, Phở, Điểm Tâm, Ăn Vặt
    "bún chả Hà Nội", "bún bò Huế", "bún riêu cua", "bánh mì chảo", "gỏi cuốn tôm thịt",
    "nem rán truyền thống", "chả giò hải sản", "miến xào hải sản", "phở xào bò",
    
    # Món Chay & Tráng Miệng
    "nấm kho tiêu chay", "canh nấm hạt sen", "đậu hũ sốt chua ngọt chay", "chè bưởi", "chè khúc bạch"
]

def clean_dish_name(text: Optional[str]) -> str:
    if not text:
        return ""
    text = re.sub(r'\s+', ' ', str(text)).strip()
    text = re.sub(r'^Hình của món\s+', '', text, flags=re.IGNORECASE)
    text = re.sub(r'^(Món|Cách làm|Hướng dẫn nấu)\s+', '', text, flags=re.IGNORECASE)
    return text.strip()

def detect_category(name: str) -> str:
    n = name.lower()
    if any(k in n for k in ["canh", "súp", "soup"]):
        return "Súp/Canh"
    elif any(k in n for k in ["kho", "ram", "om", "rim", "kho tộ"]):
        return "Món kho"
    elif any(k in n for k in ["xào", "áp chảo", "lắc"]):
        return "Món xào"
    elif any(k in n for k in ["chiên", "rán", "quay", "giòn"]):
        return "Món chiên"
    elif any(k in n for k in ["nướng"]):
        return "Món nướng"
    elif any(k in n for k in ["hấp", "luộc"]):
        return "Món hấp/luộc"
    elif any(k in n for k in ["gỏi", "nộm", "salad"]):
        return "Salad"
    elif any(k in n for k in ["bún", "phở", "miến", "hủ tiếu", "bánh mì", "cháo"]):
        return "Ăn sáng"
    elif any(k in n for k in ["chè", "bánh", "tráng miệng", "sinh tố"]):
        return "Tráng miệng"
    elif "chay" in n:
        return "Món chay"
    return "Món chính"

def is_valid_dish_name(name: str) -> bool:
    if not name or len(name) < 3 or len(name) > 80:
        return False
    n = name.lower()
    # Loại bỏ các từ khóa không phải món ăn thực tế
    invalid_keywords = [
        'bento', 'cún con', 'chó', 'mèo', 'pet', 'cho bé', 'ăn dặm', 'tạo hình',
        'cơm nhà', 'bữa cơm', 'mâm cơm', 'combo', 'thực đơn', 'menu', 'day 1', 'day 2',
        'review', 'mẹo vặt', 'kinh nghiệm', 'nồi chiên không dầu', 'bữa tối', 'bữa sáng', 'bữa trưa'
    ]
    for kw in invalid_keywords:
        if kw in n:
            return False
    return True

def upgrade_image_url(url: str) -> str:
    if not url:
        return ""
    # Chuyển đổi sang chất lượng cao nhất của Cookpad CDN
    hq_url = re.sub(
        r'/(?:120x160[^/]*|300x200[^/]*|300x220[^/]*|400x400[^/]*|600x440[^/]*|680x482[^/]*)/',
        '/1200x630cq80/',
        url
    )
    return hq_url

def crawl_cookpad_dishes(keywords: List[str], max_total: int = 250) -> List[Dict[str, Any]]:
    session = requests.Session()
    session.headers.update(HEADERS)
    
    seen_names = set()
    seen_images = set()
    dishes = []

    print(f"🚀 Bắt đầu cào dữ liệu Tên Món Ăn & Hình Ảnh từ Cookpad Việt Nam...")
    print(f"🎯 Mục tiêu: {max_total} món ăn đa dạng")

    for idx, kw in enumerate(keywords):
        if len(dishes) >= max_total:
            break

        print(f"\n[{idx+1}/{len(keywords)}] 🔍 Tìm kiếm Cookpad: '{kw}'...")
        encoded_kw = quote(kw)
        url = f"{BASE_URL}/vn/tim-kiem/{encoded_kw}"

        try:
            time.sleep(random.uniform(0.5, 1.0))
            resp = session.get(url, timeout=10)
            if resp.status_code != 200:
                print(f"  ⚠️ Cookpad trả về HTTP {resp.status_code}")
                continue

            soup = BeautifulSoup(resp.text, 'html.parser')
            # Tìm tất cả thẻ img từ CDN của Cookpad
            img_tags = soup.find_all('img', src=re.compile(r'cpcdn\.com/recipes/'))
            
            added_for_kw = 0
            for img in img_tags:
                if len(dishes) >= max_total:
                    break
                    
                alt = img.get('alt', '')
                src = img.get('src', '')
                
                dish_name = clean_dish_name(alt)
                image_url = upgrade_image_url(src)

                if not is_valid_dish_name(dish_name):
                    continue
                if not image_url or 'cpcdn.com/recipes/' not in image_url:
                    continue

                norm_name = dish_name.lower().strip()
                if norm_name in seen_names or image_url in seen_images:
                    continue

                seen_names.add(norm_name)
                seen_images.add(image_url)

                category = detect_category(dish_name)
                dish_id = str(uuid.uuid4())

                dish_item = {
                    "id": dish_id,
                    "name": dish_name,
                    "image_url": image_url,
                    "category": category,
                    "description": f"Món {dish_name} thơm ngon, đậm đà chuẩn vị truyền thống Việt Nam.",
                    "cooking_time": random.choice([20, 25, 30, 35, 40, 45]),
                    "difficulty": random.choice(["Dễ", "Trung bình", "Dễ", "Trung bình", "Khó"]),
                    "servings": "2-4 người",
                    "source_url": f"https://cookpad.com/vn/tim-kiem/{encoded_kw}",
                    "author_name": "Cookpad VN"
                }

                dishes.append(dish_item)
                added_for_kw += 1
                print(f"  🍲 [{len(dishes)}] {dish_name} ({category})")

        except Exception as e:
            print(f"  ❌ Lỗi khi tải từ khóa '{kw}': {e}")

    print(f"\n🎉 Hoàn thành cào dữ liệu! Tổng cộng thu thập được {len(dishes)} món ăn Cookpad thực tế.")
    return dishes

def save_dishes(dishes: List[Dict[str, Any]], json_path: str, sql_path: str):
    os.makedirs(os.path.dirname(json_path), exist_ok=True)
    os.makedirs(os.path.dirname(sql_path), exist_ok=True)

    # 1. Lưu file JSON
    with open(json_path, 'w', encoding='utf-8') as f:
        json.dump(dishes, f, ensure_ascii=False, indent=2)
    print(f"💾 Đã lưu JSON tại: {json_path}")

    # 2. Xuất file SQL
    with open(sql_path, 'w', encoding='utf-8') as f:
        f.write("-- ====================================================================\n")
        f.write(f"-- FoodAI: Bộ dữ liệu {len(dishes)} món ăn & hình ảnh Cookpad chuẩn xác\n")
        f.write("-- Công thức & Dinh dưỡng được sinh tự động bởi Google Gemini AI\n")
        f.write("-- ====================================================================\n\n")
        f.write("USE foodai;\n\n")
        f.write("SET FOREIGN_KEY_CHECKS = 0;\n\n")
        
        # Xóa dữ liệu cũ của bảng recipes và cookpad_dish_images
        f.write("TRUNCATE TABLE recipe_ingredients;\n")
        f.write("TRUNCATE TABLE recipe_steps;\n")
        f.write("TRUNCATE TABLE recipe_nutrition;\n")
        f.write("TRUNCATE TABLE recipe_tags;\n")
        f.write("TRUNCATE TABLE cookpad_dish_images;\n")
        f.write("TRUNCATE TABLE recipes;\n\n")

        for d in dishes:
            name_esc = d['name'].replace("'", "''")
            desc_esc = d['description'].replace("'", "''")
            img_esc = d['image_url'].replace("'", "''")
            cat_esc = d['category'].replace("'", "''")
            src_esc = d['source_url'].replace("'", "''")
            auth_esc = d['author_name'].replace("'", "''")

            # Thêm vào bảng recipes
            f.write(
                f"INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name) "
                f"VALUES ('{d['id']}', '{name_esc}', '{desc_esc}', '{img_esc}', {d['cooking_time']}, '{d['difficulty']}', '{d['servings']}', '{cat_esc}', '{src_esc}', '{auth_esc}');\n"
            )

            # Thêm vào bảng cookpad_dish_images để phục vụ tra cứu AI hình ảnh
            query_key = d['name'].lower().strip().replace("'", "''")
            f.write(
                f"INSERT INTO cookpad_dish_images (query_key, image_url, recipe_title, source) "
                f"VALUES ('{query_key}', '{img_esc}', '{name_esc}', 'cookpad');\n"
            )

        f.write("\nSET FOREIGN_KEY_CHECKS = 1;\n")

    print(f"💾 Đã xuất file SQL tại: {sql_path}")

if __name__ == '__main__':
    json_output = os.path.join(os.path.dirname(__file__), 'cookpad_recipes.json')
    sql_output = os.path.join(os.path.dirname(__file__), '../backend/sql/seed_cookpad_dishes.sql')

    dishes = crawl_cookpad_dishes(SEARCH_KEYWORDS, max_total=220)
    save_dishes(dishes, json_output, sql_output)
