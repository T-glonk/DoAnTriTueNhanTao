-- ============================================================
-- SEED DATA - Dữ liệu mẫu ban đầu
-- Admin account + Test user
-- ============================================================

USE FoodAI;
GO

-- Tạo tài khoản Admin (password: Admin@123456 - đã hash bcrypt)
IF NOT EXISTS (SELECT id FROM users WHERE email = 'admin@foodsystem.com')
BEGIN
    INSERT INTO users (id, username, email, password, full_name, role, is_active)
    VALUES (
        NEWID(),
        'admin',
        'admin@foodsystem.com',
        '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewdBPj4tbJFBSGmS',
        N'Quản trị viên',
        'admin',
        1
    );
    PRINT 'Admin account created: admin@foodsystem.com / Admin@123456';
END
GO

-- Tạo tài khoản User mẫu (password: User@123456 - đã hash bcrypt)
IF NOT EXISTS (SELECT id FROM users WHERE email = 'user@foodsystem.com')
BEGIN
    INSERT INTO users (id, username, email, password, full_name, role, is_active)
    VALUES (
        NEWID(),
        'testuser',
        'user@foodsystem.com',
        '$2a$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi',
        N'Người dùng thử nghiệm',
        'user',
        1
    );
    PRINT 'Test user created: user@foodsystem.com / User@123456';
END
GO

PRINT '=== Seed data hoàn thành! ===';
GO
