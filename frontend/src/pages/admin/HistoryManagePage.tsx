import { useState, useEffect } from 'react';
import { 
  Search, Trash2, Calendar, Clock, 
  Sparkles, RefreshCw, ChevronLeft, ChevronRight,
  Shield
} from 'lucide-react';
import api from '../../lib/api';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import toast from 'react-hot-toast';


interface SearchHistoryLog {
  id: string;
  user_id: string;
  ingredients: string[];
  created_at: string;
  user: {
    username: string;
    email: string;
    full_name: string;
    role: string;
  };
}

export function HistoryManagePage() {
  const [history, setHistory] = useState<SearchHistoryLog[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalLogs, setTotalLogs] = useState(0);
  const [deletingId, setDeletingId] = useState<string | null>(null);

  const fetchHistory = async (currentPage = page, currentSearch = search) => {
    setIsLoading(true);
    try {
      const params = new URLSearchParams();
      params.append('page', currentPage.toString());
      params.append('limit', '15');
      if (currentSearch.trim()) params.append('search', currentSearch.trim());

      const res = await api.get(`/admin/search-history?${params.toString()}`);
      if (res.data.success) {
        setHistory(res.data.data.history);
        setTotalPages(res.data.data.meta.totalPages);
        setTotalLogs(res.data.data.meta.total);
      }
    } catch {
      toast.error('Không thể tải lịch sử tìm kiếm & AI logs');
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchHistory(1, search);
    setPage(1);
  }, []);

  const handleSearchSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setPage(1);
    fetchHistory(1, search);
  };

  const handleDeleteLog = async (id: string) => {
    if (!window.confirm('Bạn có chắc chắn muốn xóa bản ghi log này?')) return;

    setDeletingId(id);
    try {
      await api.delete(`/admin/search-history/${id}`);
      toast.success('Đã xóa bản ghi log thành công');
      fetchHistory(page, search);
    } catch {
      toast.error('Xóa bản ghi thất bại');
    } finally {
      setDeletingId(null);
    }
  };

  return (
    <div className="p-6 max-w-7xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
            <Sparkles size={24} className="text-orange-500" />
            Lịch sử Tìm kiếm & AI Query Logs
          </h1>
          <p className="text-gray-500 text-sm mt-1">
            Theo dõi tất cả các yêu cầu gợi ý món ăn, nguyên liệu người dùng nhập và hành vi tương tác với hệ thống AI
          </p>
        </div>

        <button
          onClick={() => fetchHistory(page, search)}
          className="px-4 py-2.5 bg-white border border-gray-200 text-gray-700 hover:bg-gray-50 rounded-xl flex items-center gap-2 text-sm font-medium shadow-sm transition-all"
        >
          <RefreshCw size={16} className={isLoading ? 'animate-spin' : ''} />
          Làm mới
        </button>
      </div>

      {/* Summary Cards */}
      <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div className="bg-white p-5 rounded-2xl border border-gray-100 shadow-sm flex items-center gap-4">
          <div className="w-12 h-12 bg-orange-50 rounded-xl flex items-center justify-center text-orange-600">
            <Search size={22} />
          </div>
          <div>
            <p className="text-xs text-gray-500 font-medium">Tổng lượt gọi AI gợi ý món</p>
            <p className="text-2xl font-bold text-gray-900">{totalLogs.toLocaleString('vi-VN')}</p>
          </div>
        </div>

        <div className="bg-white p-5 rounded-2xl border border-gray-100 shadow-sm flex items-center gap-4">
          <div className="w-12 h-12 bg-blue-50 rounded-xl flex items-center justify-center text-blue-600">
            <Clock size={22} />
          </div>
          <div>
            <p className="text-xs text-gray-500 font-medium">Tần suất thời gian thực</p>
            <p className="text-2xl font-bold text-blue-600">Real-time</p>
          </div>
        </div>

        <div className="bg-white p-5 rounded-2xl border border-gray-100 shadow-sm flex items-center gap-4">
          <div className="w-12 h-12 bg-purple-50 rounded-xl flex items-center justify-center text-purple-600">
            <Shield size={22} />
          </div>
          <div>
            <p className="text-xs text-gray-500 font-medium">Giám sát bảo mật</p>
            <p className="text-2xl font-bold text-purple-600">Được mã hóa</p>
          </div>
        </div>
      </div>

      {/* Search Filter Toolbar */}
      <div className="bg-white p-4 rounded-2xl border border-gray-100 shadow-sm">
        <form onSubmit={handleSearchSubmit} className="flex gap-2">
          <div className="relative flex-1">
            <Search size={18} className="absolute left-3.5 top-1/2 -translate-y-1/2 text-gray-400" />
            <input
              type="text"
              value={search}
              onChange={e => setSearch(e.target.value)}
              placeholder="Tìm theo nguyên liệu (thịt bò, trứng, rau...) hoặc người dùng (email, tên)..."
              className="w-full pl-10 pr-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-orange-500/20 focus:border-orange-500 transition-all"
            />
          </div>
          <button
            type="submit"
            className="px-5 py-2.5 bg-gray-900 hover:bg-black text-white text-sm font-medium rounded-xl transition-all shadow-sm"
          >
            Lọc kết quả
          </button>
        </form>
      </div>

      {/* Table of logs */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden">
        {isLoading ? (
          <div className="flex items-center justify-center h-64">
            <LoadingSpinner size="lg" />
          </div>
        ) : history.length === 0 ? (
          <div className="p-12 text-center">
            <div className="w-14 h-14 bg-gray-100 rounded-2xl flex items-center justify-center text-gray-400 mx-auto mb-3">
              <Search size={24} />
            </div>
            <h3 className="font-bold text-gray-800">Chưa có lịch sử tìm kiếm</h3>
            <p className="text-gray-500 text-xs mt-1">
              {search ? `Không tìm thấy bản ghi nào khớp với "${search}"` : 'Khi người dùng yêu cầu AI gợi ý món ăn, các truy vấn sẽ hiển thị tại đây.'}
            </p>
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-left text-xs">
              <thead className="bg-gray-50/80 border-b border-gray-100 text-gray-500 font-semibold uppercase tracking-wider">
                <tr>
                  <th className="py-3.5 px-4">Thời gian</th>
                  <th className="py-3.5 px-4">Người dùng</th>
                  <th className="py-3.5 px-4">Nguyên liệu đầu vào AI</th>
                  <th className="py-3.5 px-4 text-center">Số lượng</th>
                  <th className="py-3.5 px-4 text-right">Thao tác</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {history.map(item => (
                  <tr key={item.id} className="hover:bg-gray-50/70 transition-colors">
                    {/* Time */}
                    <td className="py-3.5 px-4 text-gray-600 whitespace-nowrap">
                      <div className="flex items-center gap-2">
                        <Calendar size={14} className="text-orange-500" />
                        <div>
                          <p className="font-semibold text-gray-900">
                            {new Date(item.created_at).toLocaleTimeString('vi-VN', { hour: '2-digit', minute: '2-digit' })}
                          </p>
                          <p className="text-[11px] text-gray-400">
                            {new Date(item.created_at).toLocaleDateString('vi-VN')}
                          </p>
                        </div>
                      </div>
                    </td>

                    {/* User */}
                    <td className="py-3.5 px-4">
                      <div className="flex items-center gap-2.5">
                        <div className={`w-8 h-8 rounded-full flex items-center justify-center text-white font-bold text-xs ${
                          item.user.role === 'admin' ? 'bg-purple-600' : 'bg-orange-500'
                        }`}>
                          {item.user.full_name?.charAt(0).toUpperCase() || 'U'}
                        </div>
                        <div>
                          <p className="font-semibold text-gray-900">{item.user.full_name}</p>
                          <p className="text-[11px] text-gray-500 font-mono">{item.user.email}</p>
                        </div>
                      </div>
                    </td>

                    {/* Ingredients chips */}
                    <td className="py-3.5 px-4">
                      <div className="flex flex-wrap gap-1.5 max-w-lg">
                        {Array.isArray(item.ingredients) ? (
                          item.ingredients.map((ing, idx) => (
                            <span
                              key={idx}
                              className="px-2.5 py-0.5 bg-orange-50 border border-orange-200/80 text-orange-700 font-medium rounded-lg text-[11px]"
                            >
                              🥘 {ing}
                            </span>
                          ))
                        ) : (
                          <span className="text-gray-500">{String(item.ingredients)}</span>
                        )}
                      </div>
                    </td>

                    {/* Count */}
                    <td className="py-3.5 px-4 text-center">
                      <span className="px-2 py-0.5 bg-gray-100 text-gray-700 font-bold rounded-md text-[11px]">
                        {Array.isArray(item.ingredients) ? item.ingredients.length : 1} NL
                      </span>
                    </td>

                    {/* Actions */}
                    <td className="py-3.5 px-4 text-right">
                      <button
                        onClick={() => handleDeleteLog(item.id)}
                        disabled={deletingId === item.id}
                        className="p-1.5 hover:bg-rose-50 text-rose-600 rounded-lg transition-colors"
                        title="Xóa bản ghi log"
                      >
                        <Trash2 size={16} />
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        )}

        {/* Pagination */}
        {totalPages > 1 && (
          <div className="flex items-center justify-between p-4 border-t border-gray-100">
            <p className="text-xs text-gray-500">
              Trang <span className="font-bold text-gray-800">{page}</span> / <span className="font-bold text-gray-800">{totalPages}</span> ({totalLogs} bản ghi)
            </p>
            <div className="flex items-center gap-2">
              <button
                onClick={() => {
                  const prev = Math.max(1, page - 1);
                  setPage(prev);
                  fetchHistory(prev, search);
                }}
                disabled={page <= 1}
                className="px-3 py-1.5 bg-gray-50 border border-gray-200 text-gray-700 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed rounded-xl text-xs font-semibold flex items-center gap-1 transition-all"
              >
                <ChevronLeft size={14} /> Trước
              </button>
              <button
                onClick={() => {
                  const next = Math.min(totalPages, page + 1);
                  setPage(next);
                  fetchHistory(next, search);
                }}
                disabled={page >= totalPages}
                className="px-3 py-1.5 bg-gray-50 border border-gray-200 text-gray-700 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed rounded-xl text-xs font-semibold flex items-center gap-1 transition-all"
              >
                Sau <ChevronRight size={14} />
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}
