"""
Cookpad VN Recipe Crawler & Data Ingestion Tool
Hệ thống thu thập dữ liệu món ăn và hình ảnh từ Cookpad Việt Nam (cookpad.com/vn)
Lưu trữ vào MySQL Database hoặc xuất file SQL cho MySQL Workbench
"""

import os
import sys
import io
import re
import json
import time
import random
import uuid
import argparse
from typing import List, Dict, Any, Optional
from urllib.parse import quote, urljoin
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
    'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8',
    'Accept-Language': 'vi,en-US;q=0.9,en;q=0.8',
    'Cache-Control': 'no-cache',
    'Connection': 'keep-alive'
}

DEFAULT_SEARCH_KEYWORDS = [
    "thịt heo", "thịt ba chỉ", "sườn heo", "thịt kho tàu", "thịt băm",
    "thịt bò", "bò xào", "bò kho", "phở bò", "bò sốt vang",
    "thịt gà", "gà chiên", "gà kho", "gà luộc", "canh gà",
    "trứng", "trứng chiên", "trứng cuộn", "canh cà chua trứng",
    "đậu phụ", "đậu hũ sốt cà chua", "đậu hũ nhồi thịt",
    "tôm", "tôm rim", "tôm hấp", "canh tôm",
    "cá", "cá kho tộ", "canh chua cá", "cá chiên giòn",
    "mực", "mực xào", "bạch tuộc",
    "rau muống", "rau cải", "canh rau", "rau củ xào",
    "khoai tây", "cà rốt", "nấm", "cà chua", "bí đỏ",
    "lẩu", "gỏi cuốn", "nem rán", "chả giò"
]

def clean_text(text: Optional[str]) -> str:
    if not text:
        return ""
    text = re.sub(r'\s+', ' ', str(text)).strip()
    return text

def parse_iso_duration(duration_str: Optional[str]) -> int:
    """Chuyển đổi ISO 8601 duration (vd: PT30M, PT1H, PT45M) thành phút"""
    if not duration_str:
        return 30
    hours = 0
    minutes = 0
    h_match = re.search(r'(\d+)H', duration_str)
    m_match = re.search(r'(\d+)M', duration_str)
    if h_match:
        hours = int(h_match.group(1))
    if m_match:
        minutes = int(m_match.group(1))
    total = hours * 60 + minutes
    return total if total > 0 else 30

def normalize_ingredient_name(raw_text: str) -> Dict[str, Any]:
    """Phân tách chuỗi nguyên liệu thô thành định lượng và tên nguyên liệu chuẩn hóa"""
    raw = clean_text(raw_text)
    
    # Danh sách đơn vị định lượng phổ biến
    units = r'(?:kg|g|gam|gram|l|ml|lít|muỗng canh|muỗng cà phê|thìa canh|thìa cà phê|thìa|muỗng|tsp|tbsp|củ|quả|trái|cái|cây|nhánh|tép|bát|chén|lát|khoanh|miếng|gói|hộp|con|bó|nắm|ít|chút)'
    
    # Thử bóc tách số lượng + đơn vị ở đầu chuỗi (vd: "200g thịt bò", "2 củ cà rốt", "1/2 muỗng muối")
    qty_pattern = rf'^([\d\/\.\,\-\s]+(?:\s*{units})?)\s*(?:của|của loại)?\s*(.*)$'
    match = re.match(qty_pattern, raw, re.IGNORECASE)
    
    quantity = ""
    name = raw
    
    if match and match.group(2):
        quantity = match.group(1).strip()
        name = match.group(2).strip()
    else:
        # Thử tìm định lượng ở cuối (vd: "Thịt bò: 200g")
        colon_match = re.match(r'^(.*?)\s*[:：\-]\s*(.*)$', raw)
        if colon_match:
            name = colon_match.group(1).strip()
            quantity = colon_match.group(2).strip()
            
    # Bỏ các ghi chú trong ngoặc đơn nếu có (vd: "thịt bò (thăn bò)")
    norm_name = re.sub(r'\(.*?\)', '', name).strip()
    norm_name = re.sub(r'^\W+|\W+$', '', norm_name)  # Bỏ dấu gạch đầu/cuối
    if not norm_name:
        norm_name = raw

    return {
        "raw_text": raw,
        "quantity": quantity if quantity else "Tùy lượng",
        "ingredient_name": norm_name.lower()
    }

def estimate_nutrition(name: str, ingredients: List[str]) -> Dict[str, Any]:
    """Ước lượng hàm lượng dinh dưỡng dựa trên tên món và nguyên liệu chính"""
    text = (name + " " + " ".join(ingredients)).lower()
    
    calories = 300
    protein = 15.0
    carbs = 25.0
    fat = 10.0
    fiber = 3.0
    
    if any(k in text for k in ["bò", "heo", "thịt ba chỉ", "sườn", "kho tàu"]):
        calories += 180
        protein += 15
        fat += 14
    elif any(k in text for k in ["gà", "vịt"]):
        calories += 120
        protein += 18
        fat += 8
    elif any(k in text for k in ["cá", "tôm", "mực", "hải sản"]):
        calories += 80
        protein += 16
        fat += 4
    elif any(k in text for k in ["trứng"]):
        calories += 70
        protein += 7
        fat += 6
    elif any(k in text for k in ["đậu phụ", "đậu hũ"]):
        calories += 50
        protein += 8
        fat += 4
        
    if any(k in text for k in ["chiên", "rán", "nướng", "sốt bơ"]):
        fat += 8
        calories += 100
    elif any(k in text for k in ["canh", "hấp", "luộc", "gỏi"]):
        fat = max(2.0, fat - 4)
        calories = max(150, calories - 60)
        
    if any(k in text for k in ["rau", "cải", "muống", "cà rốt", "bí", "mướp", "nấm"]):
        fiber += 3.5
        carbs += 6
        
    if any(k in text for k in ["cơm", "bún", "phở", "mì", "khoai"]):
        carbs += 30
        calories += 120

    return {
        "calories": int(calories),
        "protein": round(protein, 1),
        "carbohydrates": round(carbs, 1),
        "fat": round(fat, 1),
        "fiber": round(fiber, 1),
        "calcium": round(random.uniform(20, 80), 1),
        "iron": round(random.uniform(1.0, 4.5), 1)
    }

def detect_category_and_difficulty(name: str, cook_time: int) -> tuple[str, str, List[str]]:
    """Xác định danh mục, độ khó và tags phù hợp"""
    name_lower = name.lower()
    
    # Category
    category = "Món chính"
    if any(k in name_lower for k in ["canh", "súp", "soup"]):
        category = "Súp/Canh"
    elif any(k in name_lower for k in ["gỏi", "nộm", "salad"]):
        category = "Salad"
    elif any(k in name_lower for k in ["bún", "phở", "miến", "hủ tiếu", "cháo", "bánh mì", "sandwich"]):
        category = "Ăn sáng"
    elif any(k in name_lower for k in ["chè", "bánh", "tráng miệng", "sinh tố", "nước ép", "kem"]):
        category = "Tráng miệng"
    elif any(k in name_lower for k in ["xào", "luộc", "rau", "dưa chua", "kho quẹt", "nước chấm"]):
        category = "Món phụ"
    elif "chay" in name_lower:
        category = "Món chay"
        
    # Difficulty
    if cook_time <= 20:
        difficulty = "Dễ"
    elif cook_time <= 45:
        difficulty = "Trung bình"
    else:
        difficulty = "Khó"
        
    # Tags
    tags = []
    if "chay" in name_lower:
        tags.append("chay")
    if cook_time <= 20:
        tags.append("nhanh")
        tags.append("dễ làm")
    if any(k in name_lower for k in ["kho", "ram", "om"]):
        tags.append("món kho")
    if any(k in name_lower for k in ["xào", "áp chảo"]):
        tags.append("món xào")
    if any(k in name_lower for k in ["canh", "lẩu"]):
        tags.append("món nước")
    if any(k in name_lower for k in ["chiên", "rán", "giòn"]):
        tags.append("chiên giòn")
    if not tags:
        tags = ["món ngon mỗi ngày", "dễ làm"]
        
    return category, difficulty, tags

class CookpadCrawler:
    def __init__(self, session: Optional[requests.Session] = None):
        self.session = session or requests.Session()
        self.session.headers.update(HEADERS)
        self.crawled_urls = set()
        self.recipes = []

    def fetch_page(self, url: str) -> Optional[str]:
        try:
            time.sleep(random.uniform(0.6, 1.2))  # Rate limiting lịch sự
            resp = self.session.get(url, timeout=12)
            if resp.status_code == 200:
                return resp.text
            else:
                print(f"⚠️ HTTP {resp.status_code} khi tải {url}")
                return None
        except Exception as e:
            print(f"❌ Lỗi kết nối khi tải {url}: {e}")
            return None

    def search_recipes(self, keyword: str, max_pages: int = 2) -> List[str]:
        """Tìm kiếm danh sách URL công thức theo từ khóa"""
        recipe_links = []
        for page in range(1, max_pages + 1):
            url = f"{BASE_URL}/vn/tim-kiem/{quote(keyword)}?page={page}"
            html = self.fetch_page(url)
            if not html:
                continue
            soup = BeautifulSoup(html, 'html.parser')
            for a in soup.find_all('a', href=True):
                href = a['href']
                if '/vn/cong-thuc/' in href:
                    clean_link = urljoin(BASE_URL, href.split('?')[0])
                    if clean_link not in recipe_links and clean_link not in self.crawled_urls:
                        recipe_links.append(clean_link)
        return recipe_links

    def parse_recipe(self, url: str) -> Optional[Dict[str, Any]]:
        """Phân tích và trích xuất chi tiết công thức từ một URL Cookpad"""
        if url in self.crawled_urls:
            return None
        self.crawled_urls.add(url)
        
        html = self.fetch_page(url)
        if not html:
            return None
            
        soup = BeautifulSoup(html, 'html.parser')
        
        # 1. Trích xuất qua JSON-LD Schema (Chuẩn hóa cao nhất)
        recipe_data = None
        for script in soup.find_all('script', type='application/ld+json'):
            try:
                data = json.loads(script.string)
                if isinstance(data, dict) and data.get('@type') == 'Recipe':
                    recipe_data = data
                    break
                elif isinstance(data, list):
                    for item in data:
                        if isinstance(item, dict) and item.get('@type') == 'Recipe':
                            recipe_data = item
                            break
            except Exception:
                continue

        if not recipe_data:
            return None

        name = clean_text(recipe_data.get('name'))
        if not name:
            return None

        # Image URL
        image_url = ""
        raw_img = recipe_data.get('image')
        if isinstance(raw_img, list) and len(raw_img) > 0:
            image_url = raw_img[0]
        elif isinstance(raw_img, str):
            image_url = raw_img
        elif isinstance(raw_img, dict):
            image_url = raw_img.get('url', '')

        # Description
        description = clean_text(recipe_data.get('description') or f"Công thức nấu món {name} ngon chuẩn vị từ Cookpad.")

        # Cook Time & Servings
        cook_time = parse_iso_duration(recipe_data.get('cookTime') or recipe_data.get('totalTime'))
        servings = clean_text(recipe_data.get('recipeYield') or '2-4 người')

        # Author
        author_name = "Cookpad Chef"
        author_data = recipe_data.get('author')
        if isinstance(author_data, dict):
            author_name = author_data.get('name', 'Cookpad Chef')
        elif isinstance(author_data, str):
            author_name = author_data

        # Ingredients
        raw_ingredients = recipe_data.get('recipeIngredient') or []
        ingredients = []
        for raw_ing in raw_ingredients:
            parsed_ing = normalize_ingredient_name(raw_ing)
            if parsed_ing['ingredient_name']:
                ingredients.append(parsed_ing)

        if not ingredients:
            return None

        # Instructions / Steps
        raw_steps = recipe_data.get('recipeInstructions') or []
        steps = []
        step_num = 1
        for s in raw_steps:
            instruction = ""
            step_img = ""
            if isinstance(s, dict):
                instruction = clean_text(s.get('text') or s.get('name'))
                img = s.get('image')
                if isinstance(img, list) and len(img) > 0:
                    step_img = img[0]
                elif isinstance(img, str):
                    step_img = img
            elif isinstance(s, str):
                instruction = clean_text(s)

            if instruction:
                steps.append({
                    "step_number": step_num,
                    "instruction": instruction,
                    "step_image_url": step_img
                })
                step_num += 1

        if not steps:
            steps.append({
                "step_number": 1,
                "instruction": f"Chuẩn bị nguyên liệu và chế biến món {name} theo công thức gia đình.",
                "step_image_url": ""
            })

        # Category, Difficulty & Tags
        category, difficulty, tags = detect_category_and_difficulty(name, cook_time)

        # Nutrition
        raw_nutrition = recipe_data.get('nutrition')
        if isinstance(raw_nutrition, dict) and 'calories' in raw_nutrition:
            nutrition = {
                "calories": int(raw_nutrition.get('calories', 300)),
                "protein": float(raw_nutrition.get('proteinContent', 15)),
                "carbohydrates": float(raw_nutrition.get('carbohydrateContent', 25)),
                "fat": float(raw_nutrition.get('fatContent', 10)),
                "fiber": float(raw_nutrition.get('fiberContent', 3)),
                "calcium": 40.0,
                "iron": 2.0
            }
        else:
            ing_names = [i['ingredient_name'] for i in ingredients]
            nutrition = estimate_nutrition(name, ing_names)

        recipe_id = str(uuid.uuid4())

        return {
            "id": recipe_id,
            "name": name,
            "description": description,
            "image_url": image_url,
            "cooking_time": cook_time,
            "difficulty": difficulty,
            "servings": servings,
            "category": category,
            "source_url": url,
            "author_name": author_name,
            "ingredients": ingredients,
            "steps": steps,
            "nutrition": nutrition,
            "tags": tags
        }

    def crawl(self, keywords: List[str], max_recipes: int = 50) -> List[Dict[str, Any]]:
        print(f"🚀 Bắt đầu thu thập tối đa {max_recipes} món ăn từ Cookpad...")
        recipes = []
        for kw in keywords:
            if len(recipes) >= max_recipes:
                break
            print(f"\n🔍 Đang tìm kiếm từ khóa: '{kw}'...")
            links = self.search_recipes(kw, max_pages=2)
            print(f"  👉 Tìm thấy {len(links)} công thức cho '{kw}'")
            for link in links:
                if len(recipes) >= max_recipes:
                    break
                recipe = self.parse_recipe(link)
                if recipe:
                    recipes.append(recipe)
                    print(f"  ✅ [{len(recipes)}/{max_recipes}] {recipe['name']} ({len(recipe['ingredients'])} nguyên liệu, {len(recipe['steps'])} bước)")
        
        self.recipes = recipes
        return recipes

def escape_sql(val: Any) -> str:
    """Escape giá trị chuỗi cho SQL an toàn"""
    if val is None:
        return "NULL"
    if isinstance(val, (int, float)):
        return str(val)
    val_str = str(val).replace("\\", "\\\\").replace("'", "''")
    return f"'{val_str}'"

def export_to_sql_file(recipes: List[Dict[str, Any]], output_path: str):
    """Xuất danh sách công thức thành file .SQL sẵn sàng import trong MySQL Workbench"""
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write("-- ====================================================================\n")
        f.write(f"-- FoodAI: Bộ dữ liệu {len(recipes)} món ăn thực tế thu thập từ Cookpad VN\n")
        f.write("-- Tương thích 100% với MySQL Workbench\n")
        f.write("-- ====================================================================\n\n")
        f.write("USE foodai;\n\n")
        f.write("SET FOREIGN_KEY_CHECKS = 0;\n\n")

        for r in recipes:
            r_id = r.get('id') or str(uuid.uuid4())
            # 1. Insert recipe
            f.write(f"-- Món ăn: {r['name']}\n")
            f.write("INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)\n")
            f.write(f"VALUES ({escape_sql(r_id)}, {escape_sql(r.get('name'))}, {escape_sql(r.get('description', ''))}, {escape_sql(r.get('image_url', ''))}, {r.get('cooking_time', 30)}, {escape_sql(r.get('difficulty', 'Trung bình'))}, {escape_sql(str(r.get('servings', '4 phần')))}, {escape_sql(r.get('category', 'Món chính'))}, {escape_sql(r.get('source_url', ''))}, {escape_sql(r.get('author_name', 'Cookpad'))})\n")
            f.write("ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description);\n\n")

            # 2. Insert ingredients
            if r.get('ingredients'):
                f.write("INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main) VALUES\n")
                ing_vals = []
                for ing in r['ingredients']:
                    ing_vals.append(f"({escape_sql(r_id)}, {escape_sql(ing.get('raw_text', ing.get('ingredient_name')))}, {escape_sql(ing.get('ingredient_name'))}, {escape_sql(ing.get('quantity', ''))}, 1)")
                f.write(",\n".join(ing_vals) + ";\n\n")

            # 3. Insert steps
            if r.get('steps'):
                f.write("INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url) VALUES\n")
                step_vals = []
                for s in r['steps']:
                    step_vals.append(f"({escape_sql(r_id)}, {s['step_number']}, {escape_sql(s['instruction'])}, {escape_sql(s.get('step_image_url', ''))})")
                f.write(",\n".join(step_vals) + ";\n\n")

            # 4. Insert nutrition
            n = r.get('nutrition', {'calories': 350, 'protein': 25.0, 'carbohydrates': 30.0, 'fat': 12.0, 'fiber': 3.0, 'calcium': 50.0, 'iron': 2.5})
            f.write("INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)\n")
            f.write(f"VALUES ({escape_sql(r_id)}, {n.get('calories', 350)}, {n.get('protein', 25.0)}, {n.get('carbohydrates', 30.0)}, {n.get('fat', 12.0)}, {n.get('fiber', 3.0)}, {n.get('calcium', 50.0)}, {n.get('iron', 2.5)})\n")
            f.write("ON DUPLICATE KEY UPDATE calories=VALUES(calories);\n\n")

            # 5. Insert tags
            if r.get('tags'):
                f.write("INSERT INTO recipe_tags (recipe_id, tag_name) VALUES\n")
                tag_vals = [f"({escape_sql(r_id)}, {escape_sql(t)})" for t in r['tags']]
                f.write(",\n".join(tag_vals) + ";\n\n")

        f.write("SET FOREIGN_KEY_CHECKS = 1;\n")
        f.write("-- Hoàn thành nạp dữ liệu Cookpad!\n")

    print(f"\n🎉 Đã xuất thành công {len(recipes)} món ăn ra file SQL: {output_path}")

def save_to_mysql_direct(recipes: List[Dict[str, Any]], host: str, user: str, password: str, database: str, port: int = 3306):
    """Nạp trực tiếp vào MySQL đang chạy qua PyMySQL"""
    try:
        import pymysql
        conn = pymysql.connect(
            host=host,
            user=user,
            password=password,
            database=database,
            port=port,
            charset='utf8mb4',
            cursorclass=pymysql.cursors.DictCursor
        )
        with conn.cursor() as cursor:
            for r in recipes:
                # Insert Recipe
                cursor.execute("""
                    INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                    ON DUPLICATE KEY UPDATE name=VALUES(name), image_url=VALUES(image_url), description=VALUES(description)
                """, (r['id'], r['name'], r['description'], r['image_url'], r['cooking_time'], r['difficulty'], r['servings'], r['category'], r['source_url'], r['author_name']))
                
                # Delete old child records if re-inserting
                cursor.execute("DELETE FROM recipe_ingredients WHERE recipe_id = %s", (r['id'],))
                cursor.execute("DELETE FROM recipe_steps WHERE recipe_id = %s", (r['id'],))
                cursor.execute("DELETE FROM recipe_tags WHERE recipe_id = %s", (r['id'],))
                cursor.execute("DELETE FROM recipe_nutrition WHERE recipe_id = %s", (r['id'],))

                # Insert Ingredients
                for ing in r['ingredients']:
                    cursor.execute("""
                        INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main)
                        VALUES (%s, %s, %s, %s, %s)
                    """, (r['id'], ing['raw_text'], ing['ingredient_name'], ing['quantity'], 1))

                # Insert Steps
                for s in r['steps']:
                    cursor.execute("""
                        INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url)
                        VALUES (%s, %s, %s, %s)
                    """, (r['id'], s['step_number'], s['instruction'], s.get('step_image_url', '')))

                # Insert Nutrition
                n = r['nutrition']
                cursor.execute("""
                    INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                """, (r['id'], n['calories'], n['protein'], n['carbohydrates'], n['fat'], n['fiber'], n['calcium'], n['iron']))

                # Insert Tags
                for t in r['tags']:
                    cursor.execute("""
                        INSERT INTO recipe_tags (recipe_id, tag_name)
                        VALUES (%s, %s)
                    """, (r['id'], t))

            conn.commit()
            print(f"🎉 Đã lưu thành công {len(recipes)} món ăn vào Database MySQL `{database}`!")
        conn.close()
    except Exception as e:
        print(f"❌ Không thể nạp trực tiếp vào MySQL: {e}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Cookpad Recipe Crawler & MySQL Ingestion Tool")
    parser.add_argument("--max", type=int, default=30, help="Số lượng món tối đa muốn thu thập")
    parser.add_argument("--keywords", nargs="+", default=None, help="Từ khóa tìm kiếm trên Cookpad")
    parser.add_argument("--out-sql", type=str, default="backend/sql/02_mysql_seed_cookpad.sql", help="Đường dẫn file SQL xuất ra")
    parser.add_argument("--out-json", type=str, default="crawler/cookpad_recipes.json", help="Đường dẫn file JSON xuất ra")
    parser.add_argument("--mysql-host", type=str, default=None, help="Host MySQL (nếu muốn nạp trực tiếp)")
    parser.add_argument("--mysql-user", type=str, default="root", help="User MySQL")
    parser.add_argument("--mysql-pass", type=str, default="", help="Password MySQL")
    parser.add_argument("--mysql-db", type=str, default="foodai", help="Database Name")
    
    args = parser.parse_args()
    
    keywords = args.keywords if args.keywords else DEFAULT_SEARCH_KEYWORDS
    crawler = CookpadCrawler()
    recipes = crawler.crawl(keywords, max_recipes=args.max)
    
    # Xuất file JSON
    os.makedirs(os.path.dirname(args.out_json) or ".", exist_ok=True)
    with open(args.out_json, "w", encoding="utf-8") as f:
        json.dump(recipes, f, ensure_ascii=False, indent=2)
    print(f"💾 Đã lưu JSON: {args.out_json}")
    
    # Xuất file SQL
    os.makedirs(os.path.dirname(args.out_sql) or ".", exist_ok=True)
    export_to_sql_file(recipes, args.out_sql)
    
    # Nạp trực tiếp MySQL nếu chỉ định host
    if args.mysql_host:
        save_to_mysql_direct(recipes, args.mysql_host, args.mysql_user, args.mysql_pass, args.mysql_db)
