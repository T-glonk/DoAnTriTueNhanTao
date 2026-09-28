import { useState, useEffect } from 'react';
import { Users, Search, Heart, UserCheck, UserX, TrendingUp, Activity, Utensils } from 'lucide-react';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, PieChart, Pie, Cell, Legend } from 'recharts';
import api from '../../lib/api';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import toast from 'react-hot-toast';

interface AdminStatsExtended {
  totalUsers: number;
  activeUsers: number;
  inactiveUsers: number;
  adminUsers: number;
  newUsersToday: number;
  totalSearches: number;
  searchesToday: number;
  totalFavorites: number;
  totalRecipes?: number;
}

interface DashboardData {
  stats: AdminStatsExtended;
  recentUsers: Array<{ id: string; username: string; email: string; full_name: string; role: string; is_active: boolean; created_at: string }>;
  topIngredients: Array<{ name: string; count: number }>;
}

const COLORS = ['#f97316', '#22c55e', '#3b82f6', '#8b5cf6', '#ec4899', '#14b8a6', '#f59e0b', '#6366f1', '#ef4444', '#84cc16'];

import { LucideIcon } from 'lucide-react';

interface StatCardProps {
  icon: LucideIcon;
  label: string;
  value: number | string;
  color: string;
  bgColor: string;
  sub?: string;
}

function StatCard({ icon: Icon, label, value, color, bgColor, sub }: StatCardProps) {
  return (
    <div className="bg-white rounded-2xl p-5 border border-gray-100 flex items-start gap-4 shadow-sm hover:shadow-md transition-shadow">
      <div className={`w-12 h-12 ${bgColor} rounded-xl flex items-center justify-center flex-shrink-0`}>
        <Icon size={22} className={color} />
      </div>
      <div>
        <p className="text-sm text-gray-500">{label}</p>
        <p className="text-2xl font-bold text-gray-900">{typeof value === 'number' ? value.toLocaleString('vi-VN') : value}</p>
        {sub && <p className="text-xs text-gray-400 mt-0.5">{sub}</p>}
      </div>
    </div>
  );
}

export function DashboardPage() {
  const [data, setData] = useState<DashboardData | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    api.get<{ data: DashboardData }>('/admin/stats')
      .then(res => setData(res.data.data))
      .catch(() => toast.error('Không thể tải dữ liệu thống kê hệ thống'))
      .finally(() => setIsLoading(false));
  }, []);

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <LoadingSpinner size="lg" />
      </div>
    );
  }

  if (!data) return null;

  const { stats, recentUsers, topIngredients } = data;

  const userStatusData = [
    { name: 'Hoạt động', value: stats.activeUsers || 0 },
    { name: 'Vô hiệu hóa', value: stats.inactiveUsers || 0 },
  ];

  return (
    <div className="p-6 max-w-7xl mx-auto space-y-6">
      {/* Header */}
      <div>
        <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
          <Activity size={24} className="text-orange-500" />
          Tổng quan Quản trị Hệ thống
        </h1>
        <p className="text-gray-500 text-sm mt-1">
          Báo cáo thống kê thời gian thực & Phân tích nguyên liệu (FR-05.8 & FR-05.10)
        </p>
      </div>

      {/* Stats grid (FR-05.8) */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <StatCard
          icon={Users}
          label="Tổng người dùng"
          value={stats.totalUsers}
          color="text-blue-600"
          bgColor="bg-blue-50"
          sub={`+${stats.newUsersToday || 0} hôm nay`}
        />
        <StatCard
          icon={UserCheck}
          label="Đang hoạt động"
          value={stats.activeUsers}
          color="text-emerald-600"
          bgColor="bg-emerald-50"
          sub={`${stats.inactiveUsers} vô hiệu hóa`}
        />
        <StatCard
          icon={Utensils}
          label="Món ăn Cookpad (MySQL)"
          value={stats.totalRecipes || 80}
          color="text-orange-600"
          bgColor="bg-orange-50"
          sub="Đã chuẩn hóa nguyên liệu"
        />
        <StatCard
          icon={Search}
          label="Tổng lượt tìm kiếm"
          value={stats.totalSearches}
          color="text-purple-600"
          bgColor="bg-purple-50"
          sub={`+${stats.searchesToday || 0} hôm nay`}
        />
      </div>

      {/* Quick Access System Management Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        <a
          href="/admin/recipes"
          className="bg-white p-4 rounded-2xl border border-gray-100 hover:border-orange-300 hover:shadow-md transition-all group flex items-center justify-between"
        >
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 bg-orange-50 rounded-xl flex items-center justify-center text-orange-600 group-hover:scale-110 transition-transform">
              <Utensils size={20} />
            </div>
            <div>
              <h4 className="font-bold text-gray-900 text-sm">Kho Món Cookpad</h4>
              <p className="text-xs text-gray-500">Quản lý & Thêm món</p>
            </div>
          </div>
          <span className="text-xs font-semibold text-orange-600 group-hover:translate-x-1 transition-transform">➔</span>
        </a>

        <a
          href="/admin/users"
          className="bg-white p-4 rounded-2xl border border-gray-100 hover:border-blue-300 hover:shadow-md transition-all group flex items-center justify-between"
        >
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 bg-blue-50 rounded-xl flex items-center justify-center text-blue-600 group-hover:scale-110 transition-transform">
              <Users size={20} />
            </div>
            <div>
              <h4 className="font-bold text-gray-900 text-sm">Người Dùng</h4>
              <p className="text-xs text-gray-500">Phân quyền & Khóa TK</p>
            </div>
          </div>
          <span className="text-xs font-semibold text-blue-600 group-hover:translate-x-1 transition-transform">➔</span>
        </a>

        <a
          href="/admin/history"
          className="bg-white p-4 rounded-2xl border border-gray-100 hover:border-purple-300 hover:shadow-md transition-all group flex items-center justify-between"
        >
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 bg-purple-50 rounded-xl flex items-center justify-center text-purple-600 group-hover:scale-110 transition-transform">
              <Search size={20} />
            </div>
            <div>
              <h4 className="font-bold text-gray-900 text-sm">AI Query Logs</h4>
              <p className="text-xs text-gray-500">Lịch sử & Từ khóa</p>
            </div>
          </div>
          <span className="text-xs font-semibold text-purple-600 group-hover:translate-x-1 transition-transform">➔</span>
        </a>

        <a
          href="/admin/settings"
          className="bg-white p-4 rounded-2xl border border-gray-100 hover:border-emerald-300 hover:shadow-md transition-all group flex items-center justify-between"
        >
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 bg-emerald-50 rounded-xl flex items-center justify-center text-emerald-600 group-hover:scale-110 transition-transform">
              <Activity size={20} />
            </div>
            <div>
              <h4 className="font-bold text-gray-900 text-sm">Trạng thái Hệ thống</h4>
              <p className="text-xs text-gray-500">Gemini AI & MySQL</p>
            </div>
          </div>
          <span className="text-xs font-semibold text-emerald-600 group-hover:translate-x-1 transition-transform">➔</span>
        </a>
      </div>

      {/* Today highlights banner */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">

        <div className="bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-2xl p-5 shadow-sm">
          <div className="flex items-center gap-3">
            <div className="p-3 bg-white/20 rounded-xl backdrop-blur-sm">
              <TrendingUp size={24} />
            </div>
            <div>
              <p className="text-blue-100 text-sm font-medium">Tài khoản mới hôm nay</p>
              <p className="text-3xl font-bold">{stats.newUsersToday || 0}</p>
            </div>
          </div>
        </div>
        <div className="bg-gradient-to-r from-orange-500 to-amber-600 text-white rounded-2xl p-5 shadow-sm">
          <div className="flex items-center gap-3">
            <div className="p-3 bg-white/20 rounded-xl backdrop-blur-sm">
              <Heart size={24} />
            </div>
            <div>
              <p className="text-orange-100 text-sm font-medium">Lượt lưu món yêu thích</p>
              <p className="text-3xl font-bold">{stats.totalFavorites || 0}</p>
            </div>
          </div>
        </div>
      </div>

      {/* Charts (FR-05.10) */}
      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* Top ingredients bar chart */}
        <div className="bg-white rounded-2xl p-5 border border-gray-100 shadow-sm">
          <h3 className="font-bold text-gray-800 mb-4 flex items-center gap-2">
            🥘 Top nguyên liệu được tìm kiếm nhiều nhất (FR-05.10)
          </h3>
          {topIngredients.length > 0 ? (
            <ResponsiveContainer width="100%" height={260}>
              <BarChart data={topIngredients.slice(0, 8)} layout="vertical" margin={{ left: 30, right: 20 }}>
                <CartesianGrid strokeDasharray="3 3" horizontal={false} stroke="#f3f4f6" />
                <XAxis type="number" tick={{ fontSize: 12 }} />
                <YAxis dataKey="name" type="category" tick={{ fontSize: 12 }} width={80} />
                <Tooltip
                  formatter={(value: number) => [`${value} lần`, 'Số lần']}
                  contentStyle={{ borderRadius: '12px', border: '1px solid #e5e7eb', boxShadow: '0 4px 6px -1px rgb(0 0 0 / 0.1)' }}
                />
                <Bar dataKey="count" fill="#ea580c" radius={[0, 6, 6, 0]} />
              </BarChart>
            </ResponsiveContainer>
          ) : (
            <div className="flex items-center justify-center h-52 text-gray-400">
              Chưa có dữ liệu tìm kiếm
            </div>
          )}
        </div>

        {/* User status pie chart */}
        <div className="bg-white rounded-2xl p-5 border border-gray-100 shadow-sm flex flex-col justify-between">
          <h3 className="font-bold text-gray-800 mb-2 flex items-center gap-2">
            👥 Tỷ lệ trạng thái tài khoản
          </h3>
          {stats.totalUsers > 0 ? (
            <ResponsiveContainer width="100%" height={200}>
              <PieChart>
                <Pie
                  data={userStatusData}
                  cx="50%"
                  cy="50%"
                  innerRadius={55}
                  outerRadius={85}
                  paddingAngle={5}
                  dataKey="value"
                >
                  <Cell fill="#10b981" />
                  <Cell fill="#ef4444" />
                </Pie>
                <Tooltip />
                <Legend verticalAlign="bottom" height={36} />
              </PieChart>
            </ResponsiveContainer>
          ) : (
            <div className="flex items-center justify-center h-48 text-gray-400">
              Chưa có người dùng
            </div>
          )}

          {/* Stats breakdown below pie */}
          <div className="grid grid-cols-2 gap-3 mt-3 pt-3 border-t">
            <div className="flex items-center gap-2.5 p-3 bg-emerald-50 rounded-xl">
              <UserCheck size={18} className="text-emerald-600" />
              <div>
                <p className="text-xs text-gray-500 font-medium">Hoạt động</p>
                <p className="font-bold text-emerald-700 text-lg">{stats.activeUsers}</p>
              </div>
            </div>
            <div className="flex items-center gap-2.5 p-3 bg-rose-50 rounded-xl">
              <UserX size={18} className="text-rose-600" />
              <div>
                <p className="text-xs text-gray-500 font-medium">Vô hiệu hóa</p>
                <p className="font-bold text-rose-700 text-lg">{stats.inactiveUsers}</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Top 10 ingredients detailed chips */}
      {topIngredients.length > 0 && (
        <div className="bg-white rounded-2xl p-5 border border-gray-100 shadow-sm">
          <h3 className="font-bold text-gray-800 mb-4 flex items-center gap-2">
            🏆 Bảng xếp hạng Top 10 nguyên liệu phổ biến
          </h3>
          <div className="grid grid-cols-2 sm:grid-cols-5 gap-3">
            {topIngredients.slice(0, 10).map((ing, index) => (
              <div key={ing.name} className="flex items-center gap-2.5 p-3 bg-gray-50 rounded-xl hover:bg-orange-50 transition-colors border border-gray-100">
                <span
                  className="w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold text-white shrink-0 shadow-sm"
                  style={{ backgroundColor: COLORS[index % COLORS.length] }}
                >
                  {index + 1}
                </span>
                <div className="min-w-0 flex-1">
                  <p className="text-sm font-semibold text-gray-800 truncate">{ing.name}</p>
                  <p className="text-xs text-gray-500">{ing.count} lần tìm</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}

      {/* Recent users list */}
      <div className="bg-white rounded-2xl p-5 border border-gray-100 shadow-sm">
        <h3 className="font-bold text-gray-800 mb-4 flex items-center gap-2">
          👤 Người dùng đăng ký gần đây
        </h3>
        {recentUsers.length === 0 ? (
          <p className="text-gray-500 text-center py-8">Chưa có người dùng mới</p>
        ) : (
          <div className="divide-y divide-gray-100">
            {recentUsers.map(u => (
              <div key={u.id} className="flex items-center justify-between py-3 hover:bg-gray-50 px-2 rounded-xl transition-colors">
                <div className="flex items-center gap-3">
                  <div className={`w-9 h-9 rounded-full flex items-center justify-center text-white font-bold text-sm ${
                    u.role === 'admin' ? 'bg-purple-600' : 'bg-orange-500'
                  }`}>
                    {u.full_name.charAt(0).toUpperCase()}
                  </div>
                  <div>
                    <p className="font-semibold text-gray-900 text-sm">{u.full_name}</p>
                    <p className="text-xs text-gray-500">{u.email} • <span className="font-mono">{u.username}</span></p>
                  </div>
                </div>
                <div className="text-right">
                  <span className={`text-[11px] font-semibold px-2 py-0.5 rounded-full ${
                    u.is_active ? 'bg-emerald-100 text-emerald-700' : 'bg-rose-100 text-rose-700'
                  }`}>
                    {u.is_active ? 'Hoạt động' : 'Vô hiệu'}
                  </span>
                  <p className="text-xs text-gray-400 mt-1">
                    {new Date(u.created_at).toLocaleDateString('vi-VN')}
                  </p>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
