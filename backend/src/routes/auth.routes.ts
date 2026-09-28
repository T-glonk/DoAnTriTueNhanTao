import { Router, Request, Response } from 'express';
import bcrypt from 'bcryptjs';
import jwt, { SignOptions } from 'jsonwebtoken';
import { v4 as uuidv4 } from 'uuid';
import { getPool } from '../database/db';
import { authenticateToken } from '../middleware/auth';
import { UserPublic } from '../types';

const router = Router();
const JWT_SECRET = process.env.JWT_SECRET || 'fallback-secret';
const JWT_EXPIRES_IN = (process.env.JWT_EXPIRES_IN || '7d') as SignOptions['expiresIn'];

// Register
router.post('/register', async (req: Request, res: Response): Promise<void> => {
  try {
    const { username, email, password, full_name } = req.body;
    if (!username || !email || !password || !full_name) {
      res.status(400).json({ success: false, error: 'Vui lòng điền đầy đủ thông tin' });
      return;
    }
    if (password.length < 6) {
      res.status(400).json({ success: false, error: 'Mật khẩu phải có ít nhất 6 ký tự' });
      return;
    }

    const pool = getPool();
    const [existing] = await pool.query<any[]>(
      'SELECT id FROM users WHERE email = ? OR username = ?',
      [email, username]
    );

    if (existing.length > 0) {
      res.status(409).json({ success: false, error: 'Email hoặc tên đăng nhập đã được sử dụng' });
      return;
    }

    const hashedPassword = await bcrypt.hash(password, 12);
    const userId = uuidv4();

    await pool.query(
      `INSERT INTO users (id, username, email, password, full_name, role, is_active)
       VALUES (?, ?, ?, ?, ?, 'user', 1)`,
      [userId, username, email, hashedPassword, full_name]
    );

    const token = jwt.sign({ userId, role: 'user', email }, JWT_SECRET, { expiresIn: JWT_EXPIRES_IN });

    res.status(201).json({
      success: true,
      message: 'Đăng ký thành công',
      data: { token, user: { id: userId, username, email, full_name, role: 'user' } }
    });
  } catch (error) {
    console.error('Register error:', error);
    res.status(500).json({ success: false, error: 'Đăng ký thất bại' });
  }
});

// Login
router.post('/login', async (req: Request, res: Response): Promise<void> => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      res.status(400).json({ success: false, error: 'Vui lòng nhập email và mật khẩu' });
      return;
    }

    const pool = getPool();
    const [rows] = await pool.query<any[]>(
      'SELECT * FROM users WHERE email = ?',
      [email]
    );

    const user = rows[0];
    if (!user) {
      res.status(401).json({ success: false, error: 'Email hoặc mật khẩu không đúng' });
      return;
    }
    if (!user.is_active) {
      res.status(403).json({ success: false, error: 'Tài khoản đã bị vô hiệu hóa' });
      return;
    }

    const isValid = await bcrypt.compare(password, user.password);
    if (!isValid) {
      res.status(401).json({ success: false, error: 'Email hoặc mật khẩu không đúng' });
      return;
    }

    const token = jwt.sign(
      { userId: user.id, role: user.role, email: user.email },
      JWT_SECRET,
      { expiresIn: JWT_EXPIRES_IN }
    );

    const userPublic: UserPublic = {
      id: user.id,
      username: user.username,
      email: user.email,
      full_name: user.full_name,
      role: user.role,
      avatar: user.avatar,
      is_active: !!user.is_active,
      created_at: user.created_at,
      updated_at: user.updated_at,
    };

    res.json({ success: true, message: 'Đăng nhập thành công', data: { token, user: userPublic } });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({ success: false, error: 'Đăng nhập thất bại' });
  }
});

// Get current user
router.get('/me', authenticateToken, async (req: Request, res: Response): Promise<void> => {
  try {
    const pool = getPool();
    const [rows] = await pool.query<any[]>(
      'SELECT id, username, email, full_name, role, avatar, is_active, created_at, updated_at FROM users WHERE id = ?',
      [req.user!.userId]
    );

    const user = rows[0];
    if (!user) {
      res.status(404).json({ success: false, error: 'Không tìm thấy người dùng' });
      return;
    }
    res.json({ success: true, data: { user: { ...user, is_active: !!user.is_active } } });
  } catch {
    res.status(500).json({ success: false, error: 'Lỗi server' });
  }
});

// Update profile
router.put('/profile', authenticateToken, async (req: Request, res: Response): Promise<void> => {
  try {
    const { full_name, avatar } = req.body;
    const pool = getPool();
    await pool.query(
      `UPDATE users SET full_name = ?, avatar = ?, updated_at = NOW() WHERE id = ?`,
      [full_name, avatar || null, req.user!.userId]
    );

    const [rows] = await pool.query<any[]>(
      'SELECT id, username, email, full_name, role, avatar, is_active, created_at, updated_at FROM users WHERE id = ?',
      [req.user!.userId]
    );

    res.json({ success: true, message: 'Cập nhật thành công', data: { user: rows[0] } });
  } catch {
    res.status(500).json({ success: false, error: 'Cập nhật thất bại' });
  }
});

// Change password
router.put('/change-password', authenticateToken, async (req: Request, res: Response): Promise<void> => {
  try {
    const { current_password, new_password } = req.body;
    if (!current_password || !new_password || new_password.length < 6) {
      res.status(400).json({ success: false, error: 'Thông tin mật khẩu không hợp lệ' });
      return;
    }

    const pool = getPool();
    const [rows] = await pool.query<any[]>(
      'SELECT password FROM users WHERE id = ?',
      [req.user!.userId]
    );

    const user = rows[0];
    const isValid = await bcrypt.compare(current_password, user.password);
    if (!isValid) {
      res.status(400).json({ success: false, error: 'Mật khẩu hiện tại không đúng' });
      return;
    }

    const hashed = await bcrypt.hash(new_password, 12);
    await pool.query(
      `UPDATE users SET password = ?, updated_at = NOW() WHERE id = ?`,
      [hashed, req.user!.userId]
    );

    res.json({ success: true, message: 'Đổi mật khẩu thành công' });
  } catch {
    res.status(500).json({ success: false, error: 'Đổi mật khẩu thất bại' });
  }
});

export default router;
