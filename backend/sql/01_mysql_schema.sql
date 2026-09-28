-- ====================================================================
-- FoodAI - Hệ thống gợi ý món ăn thông minh từ dữ liệu Cookpad
-- MySQL Database Schema (Tương thích 100% với MySQL Workbench)
-- ====================================================================

-- 1. Tạo Database với bảng mã UTF-8 đầy đủ hỗ trợ tiếng Việt
CREATE DATABASE IF NOT EXISTS foodai CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE foodai;

-- 2. Bảng Người dùng (Users)
CREATE TABLE IF NOT EXISTS users (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(10) NOT NULL DEFAULT 'user',
    avatar VARCHAR(500) NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_users_username (username),
    INDEX idx_users_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Bảng Món ăn (Recipes - Thu thập từ Cookpad)
CREATE TABLE IF NOT EXISTS recipes (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NULL,
    image_url VARCHAR(1000) NULL,
    cooking_time INT NULL DEFAULT 30,
    difficulty VARCHAR(20) NOT NULL DEFAULT 'Trung bình',
    servings VARCHAR(100) NULL DEFAULT '2-4 người',
    category VARCHAR(50) NOT NULL DEFAULT 'Món chính',
    source_url VARCHAR(500) NULL,
    author_name VARCHAR(100) NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_recipes_name (name),
    INDEX idx_recipes_category (category),
    INDEX idx_recipes_difficulty (difficulty)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Bảng Nguyên liệu của từng món (Recipe Ingredients)
CREATE TABLE IF NOT EXISTS recipe_ingredients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id VARCHAR(36) NOT NULL,
    raw_text TEXT NOT NULL,
    ingredient_name VARCHAR(255) NOT NULL,
    quantity VARCHAR(100) NULL,
    is_main TINYINT(1) NOT NULL DEFAULT 1,
    CONSTRAINT fk_ingredient_recipe FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    INDEX idx_ingredient_name (ingredient_name),
    INDEX idx_ingredient_recipe (recipe_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Bảng Các bước chế biến (Recipe Steps)
CREATE TABLE IF NOT EXISTS recipe_steps (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id VARCHAR(36) NOT NULL,
    step_number INT NOT NULL,
    instruction TEXT NOT NULL,
    step_image_url VARCHAR(1000) NULL,
    CONSTRAINT fk_step_recipe FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    INDEX idx_step_recipe (recipe_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Bảng Dinh dưỡng món ăn (Recipe Nutrition)
CREATE TABLE IF NOT EXISTS recipe_nutrition (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id VARCHAR(36) NOT NULL UNIQUE,
    calories INT NOT NULL DEFAULT 0,
    protein FLOAT NOT NULL DEFAULT 0,
    carbohydrates FLOAT NOT NULL DEFAULT 0,
    fat FLOAT NOT NULL DEFAULT 0,
    fiber FLOAT NOT NULL DEFAULT 0,
    calcium FLOAT NULL DEFAULT 0,
    iron FLOAT NULL DEFAULT 0,
    CONSTRAINT fk_nutrition_recipe FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 7. Bảng Thẻ phân loại món ăn (Recipe Tags)
CREATE TABLE IF NOT EXISTS recipe_tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recipe_id VARCHAR(36) NOT NULL,
    tag_name VARCHAR(50) NOT NULL,
    CONSTRAINT fk_tag_recipe FOREIGN KEY (recipe_id) REFERENCES recipes(id) ON DELETE CASCADE,
    INDEX idx_tag_name (tag_name),
    INDEX idx_tag_recipe (recipe_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 8. Bảng Lịch sử tìm kiếm của người dùng (Search History)
CREATE TABLE IF NOT EXISTS search_history (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    user_id VARCHAR(36) NOT NULL,
    ingredients TEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_history_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_history_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 9. Bảng Món ăn yêu thích của người dùng (Favorite Recipes)
CREATE TABLE IF NOT EXISTS favorite_recipes (
    id VARCHAR(36) NOT NULL PRIMARY KEY,
    user_id VARCHAR(36) NOT NULL,
    recipe_id VARCHAR(36) NULL,
    recipe_data LONGTEXT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_favorite_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_favorite_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ====================================================================
-- Dữ liệu tài khoản mặc định (Admin & Test User)
-- Admin: admin@foodsystem.com / Admin@123456
-- User:  user@foodsystem.com  / User@123456
-- ====================================================================
INSERT INTO users (id, username, email, password, full_name, role, is_active)
VALUES 
('admin-uuid-1111-2222-333344445555', 'admin', 'admin@foodsystem.com', '$2a$12$RjV96y5F8bU2j25mGjFqU.VjP.J4iK5t9GzU1K5q7mF9J2aR8v9mK', 'Quản trị viên', 'admin', 1),
('user-uuid-1111-2222-333344445555', 'testuser', 'user@foodsystem.com', '$2a$12$Z0bB8Yp4l4zFjIq2GZ/iDe3cQ3jX5P6kYt8M9V2oB4jK7nF6v8mK', 'Người dùng thử nghiệm', 'user', 1)
ON DUPLICATE KEY UPDATE updated_at = CURRENT_TIMESTAMP;
