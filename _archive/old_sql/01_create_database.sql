-- ============================================================
-- FOODAI DATABASE - SQL SERVER
-- Tạo database và toàn bộ bảng cho hệ thống gợi ý món ăn
-- ============================================================

USE master;
GO

-- Tạo database nếu chưa tồn tại
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'FoodAI')
BEGIN
    CREATE DATABASE FoodAI
    COLLATE Vietnamese_CI_AS;
    PRINT 'Database FoodAI đã được tạo.';
END
ELSE
BEGIN
    PRINT 'Database FoodAI đã tồn tại.';
END
GO

USE FoodAI;
GO

-- ============================================================
-- BẢNG USERS
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='users' AND xtype='U')
BEGIN
    CREATE TABLE users (
        id          NVARCHAR(36)    NOT NULL PRIMARY KEY,
        username    NVARCHAR(50)    NOT NULL UNIQUE,
        email       NVARCHAR(100)   NOT NULL UNIQUE,
        password    NVARCHAR(255)   NOT NULL,
        full_name   NVARCHAR(100)   NOT NULL,
        role        NVARCHAR(10)    NOT NULL DEFAULT 'user'
                    CHECK (role IN ('admin', 'user')),
        avatar      NVARCHAR(500)   NULL,
        is_active   BIT             NOT NULL DEFAULT 1,
        created_at  DATETIME2       NOT NULL DEFAULT GETDATE(),
        updated_at  DATETIME2       NOT NULL DEFAULT GETDATE()
    );
    PRINT 'Bảng users đã được tạo.';
END
GO

-- ============================================================
-- BẢNG SEARCH_HISTORY
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='search_history' AND xtype='U')
BEGIN
    CREATE TABLE search_history (
        id          NVARCHAR(36)    NOT NULL PRIMARY KEY,
        user_id     NVARCHAR(36)    NOT NULL,
        ingredients NVARCHAR(MAX)   NOT NULL,  -- JSON array
        created_at  DATETIME2       NOT NULL DEFAULT GETDATE(),
        CONSTRAINT FK_search_history_users
            FOREIGN KEY (user_id) REFERENCES users(id)
            ON DELETE CASCADE
    );
    PRINT 'Bảng search_history đã được tạo.';
END
GO

-- ============================================================
-- BẢNG FAVORITE_RECIPES
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='favorite_recipes' AND xtype='U')
BEGIN
    CREATE TABLE favorite_recipes (
        id          NVARCHAR(36)    NOT NULL PRIMARY KEY,
        user_id     NVARCHAR(36)    NOT NULL,
        recipe_data NVARCHAR(MAX)   NOT NULL,  -- JSON object
        created_at  DATETIME2       NOT NULL DEFAULT GETDATE(),
        CONSTRAINT FK_favorite_recipes_users
            FOREIGN KEY (user_id) REFERENCES users(id)
            ON DELETE CASCADE
    );
    PRINT 'Bảng favorite_recipes đã được tạo.';
END
GO

-- ============================================================
-- BẢNG RECIPES (Cache công thức từ AI)
-- ============================================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='recipes' AND xtype='U')
BEGIN
    CREATE TABLE recipes (
        id              NVARCHAR(36)    NOT NULL PRIMARY KEY,
        name            NVARCHAR(200)   NOT NULL,
        description     NVARCHAR(500)   NULL,
        ingredients     NVARCHAR(MAX)   NOT NULL,  -- JSON array
        instructions    NVARCHAR(MAX)   NOT NULL,  -- JSON array
        nutrition       NVARCHAR(MAX)   NOT NULL,  -- JSON object
        image_url       NVARCHAR(500)   NULL,
        image_query     NVARCHAR(200)   NULL,
        cooking_time    INT             NULL,
        difficulty      NVARCHAR(20)    NULL
                        CHECK (difficulty IN (N'Dễ', N'Trung bình', N'Khó')),
        servings        INT             NULL,
        category        NVARCHAR(50)    NULL,
        tags            NVARCHAR(MAX)   NULL,      -- JSON array
        search_keywords NVARCHAR(500)   NULL,      -- Từ khóa nguyên liệu
        created_at      DATETIME2       NOT NULL DEFAULT GETDATE()
    );
    PRINT 'Bảng recipes đã được tạo.';
END
GO

-- ============================================================
-- INDEX để tăng tốc truy vấn
-- ============================================================
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_search_history_user_id')
    CREATE INDEX IX_search_history_user_id ON search_history(user_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_search_history_created_at')
    CREATE INDEX IX_search_history_created_at ON search_history(created_at DESC);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_favorite_recipes_user_id')
    CREATE INDEX IX_favorite_recipes_user_id ON favorite_recipes(user_id);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_recipes_name')
    CREATE INDEX IX_recipes_name ON recipes(name);

PRINT 'Indexes đã được tạo.';
GO

PRINT '=== Database FoodAI khởi tạo thành công! ===';
GO
