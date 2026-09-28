import { useState, useEffect } from 'react';
import { History, Trash2, RotateCcw } from 'lucide-react';
import toast from 'react-hot-toast';
import { useNavigate } from 'react-router-dom';
import api from '../../lib/api';
import { SearchHistoryItem } from '../../types';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';

function formatDate(dateStr: string): string {
  const date = new Date(dateStr);
  const now = new Date();
  const diff = now.getTime() - date.getTime();
  const minutes = Math.floor(diff / 60000);
  const hours = Math.floor(diff / 3600000);
  const days = Math.floor(diff / 86400000);

  if (minutes < 60) return `${minutes} phút trước`;
  if (hours < 24) return `${hours} giờ trước`;
  if (days < 7) return `${days} ngày trước`;
  return date.toLocaleDateString('vi-VN');
}

export function HistoryPage() {
  const [history, setHistory] = useState<SearchHistoryItem[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    api.get<{ data: { history: SearchHistoryItem[] } }>('/recipes/history')
      .then(res => setHistory(res.data.data.history))
      .catch(() => toast.error('Không thể tải lịch sử'))
      .finally(() => setIsLoading(false));
  }, []);

  const clearHistory = async () => {
    if (!confirm('Xóa toàn bộ lịch sử tìm kiếm?')) return;
    try {
      await api.delete('/recipes/history');
      setHistory([]);
      toast.success('Đã xóa lịch sử');
    } catch {
      toast.error('Không thể xóa');
    }
  };

  const reuseSearch = (ingredients: string[]) => {
    // Store in sessionStorage and navigate to home
    sessionStorage.setItem('reuse_ingredients', JSON.stringify(ingredients));
    navigate('/dashboard');
    toast.success('Đã chuyển về trang tìm kiếm');
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <LoadingSpinner size="lg" />
      </div>
    );
  }

  return (
    <div className="p-6 max-w-4xl mx-auto">
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 bg-blue-100 rounded-xl flex items-center justify-center">
            <History size={20} className="text-blue-500" />
          </div>
          <div>
            <h1 className="text-xl font-bold text-gray-900">Lịch sử tìm kiếm</h1>
            <p className="text-sm text-gray-500">{history.length} lần tìm kiếm gần đây</p>
          </div>
        </div>
        {history.length > 0 && (
          <button
            onClick={clearHistory}
            className="flex items-center gap-2 text-sm text-red-500 hover:text-red-700 font-medium px-3 py-2 hover:bg-red-50 rounded-lg transition-colors"
          >
            <Trash2 size={14} />
            Xóa tất cả
          </button>
        )}
      </div>

      {history.length === 0 ? (
        <div className="text-center py-20">
          <div className="text-6xl mb-4">🔍</div>
          <h3 className="text-lg font-semibold text-gray-800">Chưa có lịch sử tìm kiếm</h3>
          <p className="text-gray-500 mt-2">Hãy tìm kiếm món ăn đầu tiên của bạn!</p>
        </div>
      ) : (
        <div className="space-y-3">
          {history.map(item => (
            <div
              key={item.id}
              className="bg-white rounded-xl p-4 border border-gray-100 hover:border-orange-200 hover:shadow-sm transition-all"
            >
              <div className="flex items-start justify-between gap-3">
                <div className="flex-1 min-w-0">
                  <div className="flex flex-wrap gap-1.5 mb-2">
                    {item.ingredients.map(ing => (
                      <span
                        key={ing}
                        className="px-2.5 py-1 bg-orange-50 text-orange-700 rounded-full text-xs font-medium"
                      >
                        {ing}
                      </span>
                    ))}
                  </div>
                  <p className="text-xs text-gray-400">{formatDate(item.created_at)}</p>
                </div>
                <button
                  onClick={() => reuseSearch(item.ingredients)}
                  className="flex items-center gap-1.5 text-xs text-primary-600 font-medium px-3 py-1.5 hover:bg-primary-50 rounded-lg transition-colors flex-shrink-0"
                  title="Tìm lại với nguyên liệu này"
                >
                  <RotateCcw size={13} />
                  Dùng lại
                </button>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
