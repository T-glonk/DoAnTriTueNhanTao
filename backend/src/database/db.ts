import mysql, { Pool, PoolOptions, RowDataPacket, ResultSetHeader } from 'mysql2/promise';
import dotenv from 'dotenv';
import path from 'path';
import fs from 'fs';

// Đảm bảo nạp đúng file .env dù chạy từ bất kỳ thư mục nào
const envPaths = [
  path.resolve(__dirname, '../../.env'),
  path.resolve(__dirname, '../.env'),
  path.resolve(process.cwd(), 'backend/.env'),
  path.resolve(process.cwd(), '.env'),
];

for (const p of envPaths) {
  if (fs.existsSync(p)) {
    dotenv.config({ path: p });
    break;
  }
}

let pool: Pool | null = null;

export function getPool(): Pool {
  if (!pool) {
    const dbConfig: PoolOptions = {
      host: process.env.DB_HOST || 'localhost',
      port: parseInt(process.env.DB_PORT || '3306', 10),
      user: process.env.DB_USER || 'root',
      password: process.env.DB_PASSWORD || '',
      database: process.env.DB_NAME || 'foodai',
      waitForConnections: true,
      connectionLimit: 15,
      queueLimit: 0,
      charset: 'utf8mb4',
      timezone: '+07:00',
      multipleStatements: true,
    };
    pool = mysql.createPool(dbConfig);
  }
  return pool;
}

/**
 * Thực thi câu lệnh SQL SELECT / trả về danh sách dòng
 */
export async function queryRows<T = RowDataPacket>(sqlQuery: string, params: any[] = []): Promise<T[]> {
  const p = getPool();
  const [rows] = await p.query(sqlQuery, params);
  return rows as T[];
}

/**
 * Thực thi câu lệnh SQL INSERT / UPDATE / DELETE
 */
export async function executeQuery(sqlQuery: string, params: any[] = []): Promise<ResultSetHeader> {
  const p = getPool();
  const [result] = await p.execute(sqlQuery, params);
  return result as ResultSetHeader;
}

/**
 * Kiểm tra kết nối đến MySQL
 */
export async function checkConnection(): Promise<boolean> {
  try {
    const p = getPool();
    const conn = await p.getConnection();
    await conn.ping();
    conn.release();
    return true;
  } catch (error) {
    console.error('⚠️ Lỗi kết nối MySQL:', error instanceof Error ? error.message : error);
    return false;
  }
}
