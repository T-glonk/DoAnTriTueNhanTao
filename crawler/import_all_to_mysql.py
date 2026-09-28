"""
Import & Merge all Cookpad recipes and rare ingredient recipes into MySQL Database (foodai)
"""

import os
import sys
import json
import uuid
import pymysql

# Add crawler dir to sys.path
sys.path.insert(0, os.path.join(os.path.dirname(__file__)))

def run_import():
    host = os.environ.get('DB_HOST', 'localhost')
    port = int(os.environ.get('DB_PORT', 3307))
    user = os.environ.get('DB_USER', 'root')
    password = os.environ.get('DB_PASSWORD', '7855')
    database = os.environ.get('DB_NAME', 'foodai')

    conn = pymysql.connect(
        host=host,
        port=port,
        user=user,
        password=password,
        database=database,
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor,
        autocommit=True
    )

    with conn.cursor() as cur:
        # Tăng kích thước cột để lưu trữ thoải mái
        cur.execute("ALTER TABLE recipe_ingredients MODIFY COLUMN raw_text TEXT")
        cur.execute("ALTER TABLE recipe_ingredients MODIFY COLUMN ingredient_name VARCHAR(500)")
        cur.execute("ALTER TABLE recipe_ingredients MODIFY COLUMN quantity VARCHAR(500)")
        cur.execute("ALTER TABLE recipes MODIFY COLUMN servings VARCHAR(255)")
        cur.execute("ALTER TABLE recipes MODIFY COLUMN source_url VARCHAR(500)")

    all_recipes = []
    seen_names = set()

    # 1. Load original json
    orig_path = 'crawler/cookpad_recipes.json'
    if os.path.exists(orig_path):
        with open(orig_path, 'r', encoding='utf-8') as f:
            recipes = json.load(f)
            for r in recipes:
                norm_name = r['name'].strip().lower()
                if norm_name not in seen_names:
                    seen_names.add(norm_name)
                    all_recipes.append(r)

    # 2. Load rare json from crawler
    rare_path = 'crawler/cookpad_rare_recipes.json'
    if os.path.exists(rare_path):
        with open(rare_path, 'r', encoding='utf-8') as f:
            recipes = json.load(f)
            for r in recipes:
                norm_name = r['name'].strip().lower()
                if norm_name not in seen_names:
                    seen_names.add(norm_name)
                    all_recipes.append(r)

    # 3. Load handcrafted rich recipes
    try:
        from seed_diverse_recipes import NEW_RECIPES
        for r in NEW_RECIPES:
            norm_name = r['name'].strip().lower()
            if norm_name not in seen_names:
                seen_names.add(norm_name)
                all_recipes.append(r)
    except Exception as e:
        print("Error importing seed_diverse_recipes:", e)

    print(f"Total unique recipes to insert/update: {len(all_recipes)}")

    with conn.cursor() as cur:
        for r in all_recipes:
            # Check existing by name
            cur.execute("SELECT id FROM recipes WHERE name = %s", (r['name'],))
            row = cur.fetchone()
            if row:
                recipe_id = row['id']
                cur.execute("""
                    UPDATE recipes
                    SET description = %s, image_url = %s, cooking_time = %s, difficulty = %s,
                        servings = %s, category = %s, source_url = %s, author_name = %s
                    WHERE id = %s
                """, (
                    r.get('description', '')[:1000], r.get('image_url', ''), r.get('cooking_time', 30),
                    r.get('difficulty', 'Trung bình'), str(r.get('servings', '4 phần'))[:200], r.get('category', 'Món chính'),
                    r.get('source_url', '')[:500], r.get('author_name', 'Cookpad')[:255], recipe_id
                ))
            else:
                recipe_id = r.get('id') or str(uuid.uuid4())
                cur.execute("""
                    INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """, (
                    recipe_id, r['name'], r.get('description', '')[:1000], r.get('image_url', ''),
                    r.get('cooking_time', 30), r.get('difficulty', 'Trung bình'), str(r.get('servings', '4 phần'))[:200],
                    r.get('category', 'Món chính'), r.get('source_url', '')[:500], r.get('author_name', 'Cookpad')[:255]
                ))

            # Delete old sub records to update cleanly
            cur.execute("DELETE FROM recipe_ingredients WHERE recipe_id = %s", (recipe_id,))
            cur.execute("DELETE FROM recipe_steps WHERE recipe_id = %s", (recipe_id,))
            cur.execute("DELETE FROM recipe_nutrition WHERE recipe_id = %s", (recipe_id,))
            cur.execute("DELETE FROM recipe_tags WHERE recipe_id = %s", (recipe_id,))

            # Ingredients
            for ing in r.get('ingredients', []):
                raw = str(ing.get('raw_text', ing.get('ingredient_name', '')))
                name = str(ing.get('ingredient_name', ''))[:450]
                qty = str(ing.get('quantity', ''))[:450]
                cur.execute("""
                    INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main)
                    VALUES (%s, %s, %s, %s, 1)
                """, (recipe_id, raw, name, qty))

            # Steps
            for s in r.get('steps', []):
                cur.execute("""
                    INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url)
                    VALUES (%s, %s, %s, %s)
                """, (recipe_id, s['step_number'], s['instruction'], s.get('step_image_url', '')))

            # Nutrition
            n = r.get('nutrition', {'calories': 350, 'protein': 25.0, 'carbohydrates': 30.0, 'fat': 12.0, 'fiber': 3.0, 'calcium': 50.0, 'iron': 2.5})
            cur.execute("""
                INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """, (recipe_id, n.get('calories', 350), n.get('protein', 25.0), n.get('carbohydrates', 30.0), n.get('fat', 12.0), n.get('fiber', 3.0), n.get('calcium', 50.0), n.get('iron', 2.5)))

            # Tags
            for t in r.get('tags', ['món ngon']):
                cur.execute("INSERT INTO recipe_tags (recipe_id, tag_name) VALUES (%s, %s)", (recipe_id, str(t)[:100]))

        # Check total
        cur.execute("SELECT COUNT(*) as total_recipes FROM recipes")
        tot_rec = cur.fetchone()['total_recipes']
        cur.execute("SELECT COUNT(*) as total_ingredients FROM recipe_ingredients")
        tot_ing = cur.fetchone()['total_ingredients']

    conn.close()

    # Save merged json
    with open('crawler/cookpad_recipes.json', 'w', encoding='utf-8') as f:
        json.dump(all_recipes, f, ensure_ascii=False, indent=2)

    print(f"\n🎉 DONE: Đã đồng bộ toàn bộ CSDL món ăn!")
    print(f"📊 Tổng số món ăn trong MySQL (foodai): {tot_rec} món")
    print(f"🥬 Tổng số định lượng nguyên liệu: {tot_ing} nguyên liệu")

if __name__ == '__main__':
    run_import()
