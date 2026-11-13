import { Router, Request, Response } from 'express';
import bcrypt from 'bcryptjs';
import { v4 as uuidv4 } from 'uuid';
import { getPool } from '../database/db';
import { authenticateToken, requireAdmin } from '../middleware/auth';

const router = Router();
router.use(authenticateToken);
router.use(requireAdmin);

/**
 * FR-05.1: Admin xem danh sách toàn bộ người dùng với phân trang
 * FR-05.2: Admin tìm kiếm người dùng theo tên, email, username
 */
router.get('/users', async (req: Request, res: Response): Promise<void> => {
  try {
    const page = Math.max(1, parseInt(req.query.page as string) || 1);
    const limit = Math.max(1, Math.min(100, parseInt(req.query.limit as string) || 10));
    const search = (req.query.search as string || '').trim();
    const offset = (page - 1) * limit;

    const pool = getPool();

    let countSql = `SELECT COUNT(*) as total FROM users`;
    let selectSql = `
      SELECT id, username, email, full_name, role, avatar, is_active, created_at, updated_at
      FROM users
    `;
    const params: any[] = [];
    const countParams: any[] = [];

    if (search) {
      const searchPattern = `%${search}%`;
      const filterClause = ` WHERE username LIKE ? OR email LIKE ? OR full_name LIKE ?`;
      countSql += filterClause;
      selectSql += filterClause;
      countParams.push(searchPattern, searchPattern, searchPattern);
      params.push(searchPattern, searchPattern, searchPattern);
    }

    selectSql += ` ORDER BY created_at DESC LIMIT ? OFFSET ?`;
    params.push(limit, offset);

    const [totalRows] = await pool.query<any[]>(countSql, countParams);
    const total = totalRows[0]?.total || 0;

    const [users] = await pool.query<any[]>(selectSql, params);

    res.json({
      success: true,
      data: {
        users: users.map(u => ({ ...u, is_active: !!u.is_active })),
        meta: {
          page,
          limit,
          total,
          totalPages: Math.ceil(total / limit) || 1,
        }
      }
    });
  } catch (err) {
    console.error('Error fetching users:', err);
    res.status(500).json({ success: false, error: 'Không thể lấy danh sách người dùng' });
  }
});

/**
 * Lấy chi tiết 1 người dùng kèm thống kê số lần tìm kiếm & món yêu thích
 */
router.get('/users/:id', async (req: Request, res: Response): Promise<void> => {
  try {
    const pool = getPool();
    const [userRows] = await pool.query<any[]>(
      `SELECT id, username, email, full_name, role, avatar, is_active, created_at, updated_at FROM users WHERE id = ?`,
      [req.params.id]
    );

    if (!userRows[0]) {
      res.status(404).json({ success: false, error: 'Không tìm thấy người dùng' });
      return;
    }

    const [[searchRows], [favRows]] = await Promise.all([
      pool.query<any[]>('SELECT COUNT(*) as cnt FROM search_history WHERE user_id = ?', [req.params.id]),
      pool.query<any[]>('SELECT COUNT(*) as cnt FROM favorite_recipes WHERE user_id = ?', [req.params.id]),
    ]);

    res.json({
      success: true,
      data: {
        user: { ...userRows[0], is_active: !!userRows[0].is_active },
        stats: {
          searchCount: searchRows[0]?.cnt || 0,
          favoriteCount: favRows[0]?.cnt || 0,
        }
      }
    });
  } catch (err) {
    console.error('Error getting user detail:', err);
    res.status(500).json({ success: false, error: 'Lỗi server khi lấy thông tin người dùng' });
  }
});

/**
 * FR-05.3: Admin tạo tài khoản người dùng mới
 */
router.post('/users', async (req: Request, res: Response): Promise<void> => {
  try {
    const { username, email, password, full_name, role = 'user' } = req.body;
    if (!username || !email || !password || !full_name) {
      res.status(400).json({ success: false, error: 'Vui lòng điền đầy đủ họ tên, username, email và mật khẩu' });
      return;
    }

    if (password.length < 6) {
      res.status(400).json({ success: false, error: 'Mật khẩu phải có ít nhất 6 ký tự' });
      return;
    }

    const pool = getPool();
    const [existing] = await pool.query<any[]>(
      'SELECT id, email, username FROM users WHERE email = ? OR username = ?',
      [email.trim(), username.trim()]
    );

    if (existing.length > 0) {
      const match = existing[0];
      const isEmail = match.email.toLowerCase() === email.trim().toLowerCase();
      res.status(409).json({
        success: false,
        error: isEmail ? 'Email này đã được sử dụng' : 'Tên đăng nhập này đã tồn tại'
      });
      return;
    }

    const hashedPassword = await bcrypt.hash(password, 12);
    const userId = uuidv4();

    await pool.query(
      `INSERT INTO users (id, username, email, password, full_name, role, is_active)
       VALUES (?, ?, ?, ?, ?, ?, 1)`,
      [userId, username.trim(), email.trim(), hashedPassword, full_name.trim(), role === 'admin' ? 'admin' : 'user']
    );

    const [newUser] = await pool.query<any[]>(
      'SELECT id, username, email, full_name, role, avatar, is_active, created_at, updated_at FROM users WHERE id = ?',
      [userId]
    );

    res.status(201).json({
      success: true,
      message: 'Tạo tài khoản thành công',
      data: { user: { ...newUser[0], is_active: !!newUser[0].is_active } }
    });
  } catch (err) {
    console.error('Error creating user:', err);
    res.status(500).json({ success: false, error: 'Tạo tài khoản thất bại' });
  }
});

/**
 * FR-05.4: Admin chỉnh sửa thông tin người dùng
 * FR-05.5: Admin kích hoạt / vô hiệu hoá tài khoản người dùng
 * FR-05.9: Admin không thể tự vô hiệu hoá tài khoản của chính mình
 */
router.put('/users/:id', async (req: Request, res: Response): Promise<void> => {
  try {
    const { full_name, email, role, is_active } = req.body;
    const currentAdminId = req.user!.userId;
    const targetUserId = req.params.id;

    // FR-05.9: Không thể tự vô hiệu hoá tài khoản của chính mình
    if (targetUserId === currentAdminId && is_active === false) {
      res.status(400).json({
        success: false,
        error: 'Bạn không thể tự vô hiệu hóa tài khoản của chính mình!'
      });
      return;
    }

    const pool = getPool();

    // Kiểm tra người dùng tồn tại
    const [existing] = await pool.query<any[]>('SELECT id, email, role FROM users WHERE id = ?', [targetUserId]);
    if (!existing[0]) {
      res.status(404).json({ success: false, error: 'Không tìm thấy người dùng' });
      return;
    }

    // Nếu sửa email, kiểm tra trùng lặp
    if (email && email.trim() !== existing[0].email) {
      const [emailCheck] = await pool.query<any[]>(
        'SELECT id FROM users WHERE email = ? AND id != ?',
        [email.trim(), targetUserId]
      );
      if (emailCheck.length > 0) {
        res.status(409).json({ success: false, error: 'Email này đã được tài khoản khác sử dụng' });
        return;
      }
    }

    const newFullName = full_name !== undefined ? full_name.trim() : existing[0].full_name;
    const newEmail = email !== undefined ? email.trim() : existing[0].email;
    const newRole = role !== undefined ? (role === 'admin' ? 'admin' : 'user') : existing[0].role;
    const newIsActive = is_active !== undefined ? (is_active ? 1 : 0) : existing[0].is_active;

    await pool.query(
      `UPDATE users SET full_name = ?, email = ?, role = ?, is_active = ?, updated_at = NOW() WHERE id = ?`,
      [newFullName, newEmail, newRole, newIsActive, targetUserId]
    );

    const [updated] = await pool.query<any[]>(
      'SELECT id, username, email, full_name, role, avatar, is_active, created_at, updated_at FROM users WHERE id = ?',
      [targetUserId]
    );

    res.json({
      success: true,
      message: 'Cập nhật tài khoản thành công',
      data: { user: { ...updated[0], is_active: !!updated[0].is_active } }
    });
  } catch (err) {
    console.error('Error updating user:', err);
    res.status(500).json({ success: false, error: 'Cập nhật thất bại' });
  }
});

/**
 * FR-05.7: Admin đặt lại mật khẩu người dùng
 */
router.put('/users/:id/reset-password', async (req: Request, res: Response): Promise<void> => {
  try {
    const { new_password } = req.body;
    if (!new_password || new_password.length < 6) {
      res.status(400).json({ success: false, error: 'Mật khẩu mới phải có ít nhất 6 ký tự' });
      return;
    }

    const pool = getPool();
    const hashedPassword = await bcrypt.hash(new_password, 12);

    const [result] = await pool.query<any>(
      `UPDATE users SET password = ?, updated_at = NOW() WHERE id = ?`,
      [hashedPassword, req.params.id]
    );

    if (result.affectedRows === 0) {
      res.status(404).json({ success: false, error: 'Không tìm thấy người dùng' });
      return;
    }

    res.json({ success: true, message: 'Đặt lại mật khẩu thành công' });
  } catch (err) {
    console.error('Error resetting password:', err);
    res.status(500).json({ success: false, error: 'Đặt lại mật khẩu thất bại' });
  }
});

/**
 * FR-05.6: Admin xoá tài khoản người dùng (chỉ role user)
 * FR-05.9: Admin không thể xoá tài khoản của chính mình
 */
router.delete('/users/:id', async (req: Request, res: Response): Promise<void> => {
  try {
    const currentAdminId = req.user!.userId;
    const targetUserId = req.params.id;

    // FR-05.9: Không thể tự xóa chính mình
    if (targetUserId === currentAdminId) {
      res.status(400).json({
        success: false,
        error: 'Bạn không thể tự xóa tài khoản của chính mình!'
      });
      return;
    }

    const pool = getPool();

    // Kiểm tra role của tài khoản mục tiêu
    const [targetRows] = await pool.query<any[]>('SELECT id, role, full_name FROM users WHERE id = ?', [targetUserId]);
    if (!targetRows[0]) {
      res.status(404).json({ success: false, error: 'Không tìm thấy người dùng' });
      return;
    }

    // FR-05.6: Chỉ cho phép xóa tài khoản có role = 'user', không thể xóa role 'admin'
    if (targetRows[0].role === 'admin') {
      res.status(403).json({
        success: false,
        error: 'Chỉ có thể xóa tài khoản Người dùng (role user). Không thể xóa tài khoản Quản trị viên!'
      });
      return;
    }

    const [result] = await pool.query<any>(`DELETE FROM users WHERE id = ?`, [targetUserId]);

    if (result.affectedRows === 0) {
      res.status(404).json({ success: false, error: 'Không tìm thấy người dùng' });
      return;
    }

    res.json({ success: true, message: `Đã xóa thành công tài khoản ${targetRows[0].full_name}` });
  } catch (err) {
    console.error('Error deleting user:', err);
    res.status(500).json({ success: false, error: 'Xóa tài khoản thất bại' });
  }
});

/**
 * FR-05.8: Admin xem thống kê tổng quan hệ thống
 * FR-05.10: Admin xem biểu đồ top nguyên liệu phổ biến
 */
router.get('/stats', async (_req: Request, res: Response): Promise<void> => {
  try {
    const pool = getPool();

    // Thống kê người dùng
    const [userStats] = await pool.query<any[]>(`
      SELECT 
        COUNT(*) as total_users,
        SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) as active_users,
        SUM(CASE WHEN is_active = 0 THEN 1 ELSE 0 END) as inactive_users,
        SUM(CASE WHEN role = 'admin' THEN 1 ELSE 0 END) as admin_users,
        SUM(CASE WHEN DATE(created_at) = CURDATE() THEN 1 ELSE 0 END) as new_users_today
      FROM users
    `);

    // Thống kê tìm kiếm & yêu thích & món ăn
    const [searchStats] = await pool.query<any[]>(`
      SELECT 
        COUNT(*) as total_searches,
        SUM(CASE WHEN DATE(created_at) = CURDATE() THEN 1 ELSE 0 END) as searches_today
      FROM search_history
    `);
    const [favStats] = await pool.query<any[]>(`SELECT COUNT(*) as total_favorites FROM favorite_recipes`);
    const [recipeStats] = await pool.query<any[]>(`SELECT COUNT(*) as total_recipes FROM recipes`);

    // Người dùng đăng ký gần đây
    const [recentUsers] = await pool.query<any[]>(`
      SELECT id, username, email, full_name, role, is_active, created_at
      FROM users
      ORDER BY created_at DESC
      LIMIT 5
    `);

    // Top nguyên liệu được tìm kiếm nhiều nhất (tính từ bảng search_history)
    const [historyRows] = await pool.query<any[]>(`SELECT ingredients FROM search_history ORDER BY created_at DESC LIMIT 200`);
    const ingredientCounts: Record<string, number> = {};
    for (const row of historyRows) {
      try {
        const ings = typeof row.ingredients === 'string' ? JSON.parse(row.ingredients) : row.ingredients;
        if (Array.isArray(ings)) {
          for (const ing of ings) {
            const clean = ing.trim();
            if (clean) {
              const cap = clean.charAt(0).toUpperCase() + clean.slice(1);
              ingredientCounts[cap] = (ingredientCounts[cap] || 0) + 1;
            }
          }
        }
      } catch {}
    }

    // Nếu chưa có lịch sử tìm kiếm, lấy các nguyên liệu phổ biến trong kho Cookpad
    let popularIngredients = Object.entries(ingredientCounts)
      .map(([name, count]) => ({ name, count }))
      .sort((a, b) => b.count - a.count)
      .slice(0, 10);

    if (popularIngredients.length === 0) {
      const [topDbIngs] = await pool.query<any[]>(`
        SELECT ingredient_name as name, COUNT(*) as count
        FROM recipe_ingredients
        GROUP BY ingredient_name
        ORDER BY count DESC
        LIMIT 10
      `);
      popularIngredients = topDbIngs.map(i => ({
        name: i.name.charAt(0).toUpperCase() + i.name.slice(1),
        count: i.count
      }));
    }

    const u = userStats[0] || {};
    const s = searchStats[0] || {};

    res.json({
      success: true,
      data: {
        stats: {
          totalUsers: u.total_users || 0,
          activeUsers: u.active_users || 0,
          inactiveUsers: u.inactive_users || 0,
          adminUsers: u.admin_users || 0,
          newUsersToday: u.new_users_today || 0,
          totalSearches: s.total_searches || 0,
          searchesToday: s.searches_today || 0,
          totalFavorites: favStats[0]?.total_favorites || 0,
          totalRecipes: recipeStats[0]?.total_recipes || 0,
        },
        recentUsers: recentUsers.map(ru => ({ ...ru, is_active: !!ru.is_active })),
        topIngredients: popularIngredients,
      }
    });
  } catch (err) {
    console.error('Error getting admin stats:', err);
    res.status(500).json({ success: false, error: 'Không thể lấy thống kê hệ thống' });
  }
});

/**
 * ============================================================================
 * QUẢN LÝ KHO MÓN ĂN & HÌNH ẢNH COOKPAD (RECIPES CRUD)
 * ============================================================================
 */

/**
 * Lấy danh sách món ăn trong kho Cookpad có phân trang, tìm kiếm và lọc danh mục
 */
router.get('/recipes', async (req: Request, res: Response): Promise<void> => {
  try {
    const page = Math.max(1, parseInt(req.query.page as string) || 1);
    const limit = Math.max(1, Math.min(100, parseInt(req.query.limit as string) || 12));
    const search = (req.query.search as string || '').trim();
    const category = (req.query.category as string || '').trim();
    const offset = (page - 1) * limit;

    const pool = getPool();

    let countSql = `SELECT COUNT(DISTINCT r.id) as total FROM recipes r`;
    let selectSql = `
      SELECT 
        r.id, r.name, r.description, r.image_url, r.cooking_time, 
        r.difficulty, r.servings, r.category, r.source_url, r.author_name,
        r.created_at, r.updated_at,
        (SELECT COUNT(*) FROM recipe_ingredients ri WHERE ri.recipe_id = r.id) as ingredient_count,
        (SELECT COUNT(*) FROM recipe_steps rs WHERE rs.recipe_id = r.id) as step_count
      FROM recipes r
    `;

    const whereClauses: string[] = [];
    const params: any[] = [];
    const countParams: any[] = [];

    if (search) {
      whereClauses.push(`(r.name LIKE ? OR r.description LIKE ? OR EXISTS (
        SELECT 1 FROM recipe_ingredients ri2 WHERE ri2.recipe_id = r.id AND ri2.ingredient_name LIKE ?
      ))`);
      const pattern = `%${search}%`;
      countParams.push(pattern, pattern, pattern);
      params.push(pattern, pattern, pattern);
    }

    if (category && category !== 'Tất cả') {
      whereClauses.push(`r.category = ?`);
      countParams.push(category);
      params.push(category);
    }

    if (whereClauses.length > 0) {
      const clauseStr = ` WHERE ` + whereClauses.join(' AND ');
      countSql += clauseStr;
      selectSql += clauseStr;
    }

    selectSql += ` ORDER BY r.created_at DESC LIMIT ? OFFSET ?`;
    params.push(limit, offset);

    const [countRows] = await pool.query<any[]>(countSql, countParams);
    const total = countRows[0]?.total || 0;

    const [recipes] = await pool.query<any[]>(selectSql, params);

    res.json({
      success: true,
      data: {
        recipes,
        meta: {
          page,
          limit,
          total,
          totalPages: Math.ceil(total / limit) || 1,
        }
      }
    });
  } catch (err) {
    console.error('Error fetching admin recipes:', err);
    res.status(500).json({ success: false, error: 'Không thể lấy danh sách món ăn' });
  }
});

/**
 * Lấy chi tiết đầy đủ 1 món ăn trong kho (kèm nguyên liệu, các bước, dinh dưỡng, tags)
 */
router.get('/recipes/:id', async (req: Request, res: Response): Promise<void> => {
  try {
    const pool = getPool();
    const recipeId = req.params.id;

    const [recipeRows] = await pool.query<any[]>(`SELECT * FROM recipes WHERE id = ?`, [recipeId]);
    if (!recipeRows[0]) {
      res.status(404).json({ success: false, error: 'Không tìm thấy món ăn' });
      return;
    }

    const [ingredients] = await pool.query<any[]>(
      `SELECT raw_text, ingredient_name, quantity, is_main FROM recipe_ingredients WHERE recipe_id = ?`,
      [recipeId]
    );

    const [steps] = await pool.query<any[]>(
      `SELECT step_number, instruction, step_image_url FROM recipe_steps WHERE recipe_id = ? ORDER BY step_number ASC`,
      [recipeId]
    );

    const [nutritionRows] = await pool.query<any[]>(
      `SELECT calories, protein, carbohydrates, fat, fiber, calcium, iron FROM recipe_nutrition WHERE recipe_id = ?`,
      [recipeId]
    );

    const [tagsRows] = await pool.query<any[]>(
      `SELECT tag_name FROM recipe_tags WHERE recipe_id = ?`,
      [recipeId]
    );

    res.json({
      success: true,
      data: {
        recipe: {
          ...recipeRows[0],
          ingredients,
          steps,
          nutrition: nutritionRows[0] || null,
          tags: tagsRows.map(t => t.tag_name),
        }
      }
    });
  } catch (err) {
    console.error('Error fetching recipe detail:', err);
    res.status(500).json({ success: false, error: 'Lỗi server khi lấy chi tiết món ăn' });
  }
});

/**
 * Thêm món ăn mới vào kho dữ liệu
 */
router.post('/recipes', async (req: Request, res: Response): Promise<void> => {
  try {
    const {
      name,
      description,
      image_url,
      cooking_time = 30,
      difficulty = 'Trung bình',
      servings = '2-4 người',
      category = 'Món chính',
      source_url = '',
      author_name = 'Admin FoodAI',
      ingredients = [],
      steps = [],
      nutrition,
      tags = []
    } = req.body;

    if (!name || !name.trim()) {
      res.status(400).json({ success: false, error: 'Tên món ăn là bắt buộc' });
      return;
    }

    const pool = getPool();
    const recipeId = uuidv4();

    // 1. Insert Recipe
    await pool.query(
      `INSERT INTO recipes (id, name, description, image_url, cooking_time, difficulty, servings, category, source_url, author_name)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        recipeId,
        name.trim(),
        description ? description.trim() : null,
        image_url ? image_url.trim() : null,
        parseInt(cooking_time) || 30,
        difficulty,
        servings,
        category,
        source_url ? source_url.trim() : null,
        author_name ? author_name.trim() : 'Admin'
      ]
    );

    // Đồng bộ ngay hình ảnh vào cookpad_dish_images để AI tự động lấy được ảnh này
    if (image_url && image_url.trim()) {
      try {
        const normKey = name.toLowerCase().trim();
        await pool.query(
          `INSERT INTO cookpad_dish_images (query_key, image_url, recipe_title, source)
           VALUES (?, ?, ?, 'admin')
           ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), source = 'admin'`,
          [normKey, image_url.trim(), name.trim()]
        );
      } catch (imgSyncErr) {
        // ignore
      }
    }

    // 2. Insert Ingredients
    if (Array.isArray(ingredients) && ingredients.length > 0) {
      for (const ing of ingredients) {
        if (ing.ingredient_name || ing.raw_text) {
          await pool.query(
            `INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main)
             VALUES (?, ?, ?, ?, 1)`,
            [
              recipeId,
              ing.raw_text || ing.ingredient_name,
              (ing.ingredient_name || ing.raw_text).toLowerCase().trim(),
              ing.quantity || 'Tùy lượng'
            ]
          );
        }
      }
    }

    // 3. Insert Steps
    if (Array.isArray(steps) && steps.length > 0) {
      let stepNum = 1;
      for (const step of steps) {
        const text = typeof step === 'string' ? step : step.instruction;
        if (text && text.trim()) {
          await pool.query(
            `INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url)
             VALUES (?, ?, ?, ?)`,
            [recipeId, stepNum, text.trim(), (step.step_image_url || '').trim()]
          );
          stepNum++;
        }
      }
    }

    // 4. Insert Nutrition
    if (nutrition) {
      await pool.query(
        `INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
        [
          recipeId,
          nutrition.calories || 300,
          nutrition.protein || 15,
          nutrition.carbohydrates || 25,
          nutrition.fat || 10,
          nutrition.fiber || 3,
          nutrition.calcium || 0,
          nutrition.iron || 0
        ]
      );
    }

    // 5. Insert Tags
    if (Array.isArray(tags) && tags.length > 0) {
      for (const tag of tags) {
        if (tag && tag.trim()) {
          await pool.query(
            `INSERT INTO recipe_tags (recipe_id, tag_name) VALUES (?, ?)`,
            [recipeId, tag.trim().toLowerCase()]
          );
        }
      }
    }

    res.status(201).json({
      success: true,
      message: 'Thêm món ăn vào kho thành công',
      data: { id: recipeId, name }
    });
  } catch (err) {
    console.error('Error creating recipe:', err);
    res.status(500).json({ success: false, error: 'Thêm món ăn thất bại' });
  }
});

/**
 * Chỉnh sửa thông tin món ăn trong kho
 */
router.put('/recipes/:id', async (req: Request, res: Response): Promise<void> => {
  try {
    const recipeId = req.params.id;
    const {
      name,
      description,
      image_url,
      cooking_time,
      difficulty,
      servings,
      category,
      source_url,
      author_name,
      ingredients,
      steps,
      nutrition,
      tags
    } = req.body;

    const pool = getPool();

    const [existing] = await pool.query<any[]>(`SELECT id FROM recipes WHERE id = ?`, [recipeId]);
    if (!existing[0]) {
      res.status(404).json({ success: false, error: 'Không tìm thấy món ăn' });
      return;
    }

    // Update main recipe record
    await pool.query(
      `UPDATE recipes SET 
        name = COALESCE(?, name),
        description = COALESCE(?, description),
        image_url = COALESCE(?, image_url),
        cooking_time = COALESCE(?, cooking_time),
        difficulty = COALESCE(?, difficulty),
        servings = COALESCE(?, servings),
        category = COALESCE(?, category),
        source_url = COALESCE(?, source_url),
        author_name = COALESCE(?, author_name),
        updated_at = NOW()
       WHERE id = ?`,
      [
        name ? name.trim() : null,
        description !== undefined ? description.trim() : null,
        image_url !== undefined ? image_url.trim() : null,
        cooking_time ? parseInt(cooking_time) : null,
        difficulty,
        servings,
        category,
        source_url,
        author_name,
        recipeId
      ]
    );

    // Đồng bộ ngay hình ảnh Admin cập nhật vào cookpad_dish_images để AI tự động lấy được ảnh này
    if (image_url && image_url.trim()) {
      try {
        const finalName = (name || existing[0].name || '').trim();
        const normKey = finalName.toLowerCase().trim();
        await pool.query(
          `INSERT INTO cookpad_dish_images (query_key, image_url, recipe_title, source)
           VALUES (?, ?, ?, 'admin')
           ON DUPLICATE KEY UPDATE image_url = VALUES(image_url), source = 'admin'`,
          [normKey, image_url.trim(), finalName]
        );
      } catch (imgSyncErr) {
        // ignore
      }
    }

    // Update ingredients if provided
    if (Array.isArray(ingredients)) {
      await pool.query(`DELETE FROM recipe_ingredients WHERE recipe_id = ?`, [recipeId]);
      for (const ing of ingredients) {
        if (ing.ingredient_name || ing.raw_text) {
          await pool.query(
            `INSERT INTO recipe_ingredients (recipe_id, raw_text, ingredient_name, quantity, is_main)
             VALUES (?, ?, ?, ?, 1)`,
            [
              recipeId,
              ing.raw_text || ing.ingredient_name,
              (ing.ingredient_name || ing.raw_text).toLowerCase().trim(),
              ing.quantity || 'Tùy lượng'
            ]
          );
        }
      }
    }

    // Update steps if provided
    if (Array.isArray(steps)) {
      await pool.query(`DELETE FROM recipe_steps WHERE recipe_id = ?`, [recipeId]);
      let stepNum = 1;
      for (const step of steps) {
        const text = typeof step === 'string' ? step : step.instruction;
        if (text && text.trim()) {
          await pool.query(
            `INSERT INTO recipe_steps (recipe_id, step_number, instruction, step_image_url)
             VALUES (?, ?, ?, ?)`,
            [recipeId, stepNum, text.trim(), (step.step_image_url || '').trim()]
          );
          stepNum++;
        }
      }
    }

    // Update nutrition if provided
    if (nutrition) {
      await pool.query(`DELETE FROM recipe_nutrition WHERE recipe_id = ?`, [recipeId]);
      await pool.query(
        `INSERT INTO recipe_nutrition (recipe_id, calories, protein, carbohydrates, fat, fiber, calcium, iron)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
        [
          recipeId,
          nutrition.calories || 300,
          nutrition.protein || 15,
          nutrition.carbohydrates || 25,
          nutrition.fat || 10,
          nutrition.fiber || 3,
          nutrition.calcium || 0,
          nutrition.iron || 0
        ]
      );
    }

    // Update tags if provided
    if (Array.isArray(tags)) {
      await pool.query(`DELETE FROM recipe_tags WHERE recipe_id = ?`, [recipeId]);
      for (const tag of tags) {
        if (tag && tag.trim()) {
          await pool.query(
            `INSERT INTO recipe_tags (recipe_id, tag_name) VALUES (?, ?)`,
            [recipeId, tag.trim().toLowerCase()]
          );
        }
      }
    }

    res.json({
      success: true,
      message: 'Cập nhật món ăn thành công'
    });
  } catch (err) {
    console.error('Error updating recipe:', err);
    res.status(500).json({ success: false, error: 'Cập nhật món ăn thất bại' });
  }
});

/**
 * Xóa món ăn khỏi kho Cookpad
 */
router.delete('/recipes/:id', async (req: Request, res: Response): Promise<void> => {
  try {
    const pool = getPool();
    const recipeId = req.params.id;

    const [result] = await pool.query<any>(`DELETE FROM recipes WHERE id = ?`, [recipeId]);
    if (result.affectedRows === 0) {
      res.status(404).json({ success: false, error: 'Không tìm thấy món ăn để xóa' });
      return;
    }

    res.json({ success: true, message: 'Đã xóa món ăn thành công khỏi hệ thống' });
  } catch (err) {
    console.error('Error deleting recipe:', err);
    res.status(500).json({ success: false, error: 'Xóa món ăn thất bại' });
  }
});

/**
 * ============================================================================
 * QUẢN LÝ LỊCH SỬ TÌM KIẾM & AI QUERY LOGS
 * ============================================================================
 */

/**
 * Lấy danh sách toàn bộ lịch sử tìm kiếm & gọi AI từ tất cả người dùng
 */
router.get('/search-history', async (req: Request, res: Response): Promise<void> => {
  try {
    const page = Math.max(1, parseInt(req.query.page as string) || 1);
    const limit = Math.max(1, Math.min(100, parseInt(req.query.limit as string) || 15));
    const search = (req.query.search as string || '').trim();
    const offset = (page - 1) * limit;

    const pool = getPool();

    let countSql = `
      SELECT COUNT(*) as total 
      FROM search_history sh
      LEFT JOIN users u ON sh.user_id = u.id
    `;
    let selectSql = `
      SELECT 
        sh.id, sh.user_id, sh.ingredients, sh.created_at,
        u.username, u.email, u.full_name, u.role
      FROM search_history sh
      LEFT JOIN users u ON sh.user_id = u.id
    `;

    const params: any[] = [];
    const countParams: any[] = [];

    if (search) {
      const searchPattern = `%${search}%`;
      const filterClause = ` WHERE sh.ingredients LIKE ? OR u.email LIKE ? OR u.full_name LIKE ? OR u.username LIKE ?`;
      countSql += filterClause;
      selectSql += filterClause;
      countParams.push(searchPattern, searchPattern, searchPattern, searchPattern);
      params.push(searchPattern, searchPattern, searchPattern, searchPattern);
    }

    selectSql += ` ORDER BY sh.created_at DESC LIMIT ? OFFSET ?`;
    params.push(limit, offset);

    const [totalRows] = await pool.query<any[]>(countSql, countParams);
    const total = totalRows[0]?.total || 0;

    const [rows] = await pool.query<any[]>(selectSql, params);

    const history = rows.map(r => {
      let parsedIngredients = [];
      try {
        parsedIngredients = typeof r.ingredients === 'string' ? JSON.parse(r.ingredients) : r.ingredients;
      } catch {
        parsedIngredients = [r.ingredients];
      }
      return {
        id: r.id,
        user_id: r.user_id,
        ingredients: parsedIngredients,
        created_at: r.created_at,
        user: {
          username: r.username || 'Khách / Ẩn danh',
          email: r.email || 'N/A',
          full_name: r.full_name || 'Khách',
          role: r.role || 'user'
        }
      };
    });

    res.json({
      success: true,
      data: {
        history,
        meta: {
          page,
          limit,
          total,
          totalPages: Math.ceil(total / limit) || 1,
        }
      }
    });
  } catch (err) {
    console.error('Error fetching search history logs:', err);
    res.status(500).json({ success: false, error: 'Không thể lấy lịch sử tìm kiếm' });
  }
});

/**
 * Xóa một bản ghi lịch sử tìm kiếm
 */
router.delete('/search-history/:id', async (req: Request, res: Response): Promise<void> => {
  try {
    const pool = getPool();
    const [result] = await pool.query<any>(`DELETE FROM search_history WHERE id = ?`, [req.params.id]);
    if (result.affectedRows === 0) {
      res.status(404).json({ success: false, error: 'Không tìm thấy bản ghi lịch sử' });
      return;
    }
    res.json({ success: true, message: 'Đã xóa bản ghi lịch sử thành công' });
  } catch (err) {
    console.error('Error deleting search history:', err);
    res.status(500).json({ success: false, error: 'Xóa bản ghi lịch sử thất bại' });
  }
});

/**
 * ============================================================================
 * TRẠNG THÁI HỆ THỐNG & AI ENGINE (SYSTEM INFO)
 * ============================================================================
 */

router.get('/system-info', async (_req: Request, res: Response): Promise<void> => {
  try {
    const pool = getPool();

    const [[userCount], [recipeCount], [ingCount], [searchCount]] = await Promise.all([
      pool.query<any[]>('SELECT COUNT(*) as cnt FROM users'),
      pool.query<any[]>('SELECT COUNT(*) as cnt FROM recipes'),
      pool.query<any[]>('SELECT COUNT(*) as cnt FROM recipe_ingredients'),
      pool.query<any[]>('SELECT COUNT(*) as cnt FROM search_history')
    ]);

    const hasGeminiKey = !!process.env.GEMINI_API_KEY && process.env.GEMINI_API_KEY.length > 10;
    const mem = process.memoryUsage();

    res.json({
      success: true,
      data: {
        aiEngine: {
          provider: 'Google DeepMind Gemini AI',
          model: 'gemini-3.5-flash',
          configured: hasGeminiKey,
          status: hasGeminiKey ? 'Sẵn sàng (Operational)' : 'Chưa cấu hình API Key',
          imageSourcePriority: 'MySQL Cookpad DB (img-global.cpcdn.com) ➔ Fallback Stock CDN',
        },
        database: {
          type: 'MySQL (InnoDB / utf8mb4)',
          status: 'Đang kết nối (Connected)',
          totalUsers: userCount[0]?.cnt || 0,
          totalRecipes: recipeCount[0]?.cnt || 0,
          totalMappedIngredients: ingCount[0]?.cnt || 0,
          totalSearchLogs: searchCount[0]?.cnt || 0,
        },
        server: {
          nodeVersion: process.version,
          platform: process.platform,
          uptimeSeconds: Math.floor(process.uptime()),
          memoryUsageMB: Math.round(mem.rss / (1024 * 1024)),
          heapUsedMB: Math.round(mem.heapUsed / (1024 * 1024)),
        }
      }
    });
  } catch (err) {
    console.error('Error getting system info:', err);
    res.status(500).json({ success: false, error: 'Không thể lấy thông tin hệ thống' });
  }
});

export default router;

