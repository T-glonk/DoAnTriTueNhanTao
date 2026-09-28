import { Router, Request, Response } from 'express';
import { getPool } from '../database/db';
import { authenticateToken } from '../middleware/auth';
import { suggestRecipes } from '../services/recipe.service';
import { isAiEnabled } from '../services/gemini.service';
import { v4 as uuidv4 } from 'uuid';

const router = Router();

// Gợi ý món ăn dựa trên nguyên liệu
router.post('/suggest', authenticateToken, async (req: Request, res: Response): Promise<void> => {
  try {
    const { ingredients, mode } = req.body;
    if (!ingredients || !Array.isArray(ingredients) || ingredients.length === 0) {
      res.status(400).json({ success: false, error: 'Vui lòng cung cấp danh sách nguyên liệu' });
      return;
    }

    const userId = req.user!.userId;

    // Gọi dịch vụ gợi ý món ăn (Mặc định: Google Gemini AI, có thể chọn Database Cookpad)
    const { recipes, source } = await suggestRecipes(ingredients, userId, 6, mode || 'ai');

    res.json({
      success: true,
      data: {
        recipes,
        source,
        ai_enabled: isAiEnabled(),
        total_found: recipes.length,
      }
    });
  } catch (error) {
    console.error('Recipe suggestion error:', error);
    const msg = error instanceof Error ? error.message : 'Không thể gợi ý món ăn';
    res.status(500).json({ success: false, error: msg });
  }
});

// Sinh chi tiết công thức và phân tích dinh dưỡng cho món ăn bằng AI
router.post('/ai-recipe-detail', authenticateToken, async (req: Request, res: Response): Promise<void> => {
  try {
    const { dishName } = req.body;
    if (!dishName) {
      res.status(400).json({ success: false, error: 'Vui lòng cung cấp tên món ăn' });
      return;
    }

    const { generateRecipeDetailWithGemini } = await import('../services/gemini.service');
    const detail = await generateRecipeDetailWithGemini(dishName);
    res.json({ success: true, data: detail });
  } catch (error) {
    console.error('AI recipe detail error:', error);
    res.status(500).json({ success: false, error: 'Không thể sinh công thức AI' });
  }
});

// Thêm món vào danh sách yêu thích
router.post('/favorites', authenticateToken, async (req: Request, res: Response): Promise<void> => {
  try {
    const { recipe } = req.body;
    const userId = req.user!.userId;
    if (!recipe || !recipe.name) {
      res.status(400).json({ success: false, error: 'Dữ liệu món ăn không hợp lệ' });
      return;
    }

    const pool = getPool();

    // Kiểm tra đã lưu chưa bằng JSON search hoặc name
    const [existing] = await pool.query<any[]>(
      `SELECT id FROM favorite_recipes WHERE user_id = ? AND (recipe_id = ? OR JSON_UNQUOTE(JSON_EXTRACT(recipe_data, '$.name')) = ?)`,
      [userId, recipe.id || '', recipe.name]
    );

    if (existing.length > 0) {
      res.status(409).json({ success: false, error: 'Món ăn đã có trong danh sách yêu thích' });
      return;
    }

    const favoriteId = uuidv4();
    await pool.query(
      `INSERT INTO favorite_recipes (id, user_id, recipe_id, recipe_data) VALUES (?, ?, ?, ?)`,
      [favoriteId, userId, recipe.id || null, JSON.stringify(recipe)]
    );

    res.json({ success: true, message: 'Đã thêm vào yêu thích', data: { id: favoriteId } });
  } catch (error) {
    console.error('Error adding to favorites:', error);
    res.status(500).json({ success: false, error: 'Không thể thêm vào yêu thích' });
  }
});

// Lấy danh sách món ăn yêu thích
router.get('/favorites', authenticateToken, async (req: Request, res: Response): Promise<void> => {
  try {
    const pool = getPool();
    const [rows] = await pool.query<any[]>(
      `SELECT id, recipe_data, created_at FROM favorite_recipes WHERE user_id = ? ORDER BY created_at DESC`,
      [req.user!.userId]
    );

    const favorites = rows.map(row => {
      let parsed = {};
      try {
        parsed = typeof row.recipe_data === 'string' ? JSON.parse(row.recipe_data) : row.recipe_data;
      } catch {
        parsed = {};
      }
      return {
        id: row.id,
        recipe: parsed,
        created_at: row.created_at,
      };
    });

    res.json({ success: true, data: { favorites } });
  } catch (error) {
    console.error('Error fetching favorites:', error);
    res.status(500).json({ success: false, error: 'Không thể lấy danh sách yêu thích' });
  }
});

// Xóa món khỏi yêu thích
router.delete('/favorites/:id', authenticateToken, async (req: Request, res: Response): Promise<void> => {
  try {
    const pool = getPool();
    const [result] = await pool.query<any>(
      `DELETE FROM favorite_recipes WHERE id = ? AND user_id = ?`,
      [req.params.id, req.user!.userId]
    );

    if (result.affectedRows === 0) {
      res.status(404).json({ success: false, error: 'Không tìm thấy món ăn trong danh sách yêu thích' });
      return;
    }

    res.json({ success: true, message: 'Đã xóa khỏi yêu thích' });
  } catch (error) {
    console.error('Error deleting favorite:', error);
    res.status(500).json({ success: false, error: 'Không thể xóa món yêu thích' });
  }
});

// Lấy lịch sử tìm kiếm
router.get('/history', authenticateToken, async (req: Request, res: Response): Promise<void> => {
  try {
    const pool = getPool();
    const [rows] = await pool.query<any[]>(
      `SELECT id, ingredients, created_at FROM search_history WHERE user_id = ? ORDER BY created_at DESC LIMIT 20`,
      [req.user!.userId]
    );

    const history = rows.map(row => {
      let ings = [];
      try {
        ings = typeof row.ingredients === 'string' ? JSON.parse(row.ingredients) : row.ingredients;
      } catch {
        ings = [];
      }
      return {
        id: row.id,
        ingredients: ings,
        created_at: row.created_at,
      };
    });

    res.json({ success: true, data: { history } });
  } catch (error) {
    console.error('Error fetching history:', error);
    res.status(500).json({ success: false, error: 'Không thể lấy lịch sử tìm kiếm' });
  }
});

// Xóa toàn bộ lịch sử tìm kiếm
router.delete('/history', authenticateToken, async (req: Request, res: Response): Promise<void> => {
  try {
    const pool = getPool();
    await pool.query(`DELETE FROM search_history WHERE user_id = ?`, [req.user!.userId]);
    res.json({ success: true, message: 'Đã xóa lịch sử tìm kiếm' });
  } catch (error) {
    console.error('Error clearing history:', error);
    res.status(500).json({ success: false, error: 'Không thể xóa lịch sử' });
  }
});

// Trạng thái AI
router.get('/ai-status', authenticateToken, (_req: Request, res: Response): void => {
  res.json({
    success: true,
    data: {
      ai_enabled: isAiEnabled(),
      message: isAiEnabled() ? 'Gemini AI đang hoạt động' : 'Đang sử dụng Database Cookpad chuẩn xác',
    }
  });
});

export default router;
