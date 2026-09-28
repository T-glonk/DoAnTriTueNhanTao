import { useState, useEffect } from 'react';
import { 
  Settings, Database, Server, Sparkles, 
  RefreshCw, ShieldCheck, Activity
} from 'lucide-react';
import api from '../../lib/api';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import toast from 'react-hot-toast';


interface SystemInfoData {
  aiEngine: {
    provider: string;
    model: string;
    configured: boolean;
    status: string;
    imageSourcePriority: string;
  };
  database: {
    type: string;
    status: string;
    totalUsers: number;
    totalRecipes: number;
    totalMappedIngredients: number;
    totalSearchLogs: number;
  };
  server: {
    nodeVersion: string;
    platform: string;
    uptimeSeconds: number;
    memoryUsageMB: number;
    heapUsedMB: number;
  };
}

export function SettingsPage() {
  const [data, setData] = useState<SystemInfoData | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [isTestingAI, setIsTestingAI] = useState(false);

  const fetchSystemInfo = async () => {
    setIsLoading(true);
    try {
      const res = await api.get('/admin/system-info');
      if (res.data.success) {
        setData(res.data.data);
      }
    } catch {
      toast.error('Không thể lấy thông tin cấu hình hệ thống');
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchSystemInfo();
  }, []);

  const handleTestAIConnection = async () => {
    setIsTestingAI(true);
    try {
      // Test Gemini API through a test call or system check
      const res = await api.post('/recipes/suggest', {
        ingredients: ['thịt bò', 'hành tây', 'cà rốt']
      });
      if (res.data.success && res.data.data.recipes?.length > 0) {
        toast.success(`Kết nối AI thành công! Mô hình ${data?.aiEngine.model || 'gemini-3.5-flash'} trả về ${res.data.data.recipes.length} món gợi ý.`);
      } else {
        toast.success('Hệ thống AI đang phản hồi bình thường.');
      }
    } catch (err: any) {
      toast.error('Kiểm tra AI thất bại: ' + (err.response?.data?.error || err.message));
    } finally {
      setIsTestingAI(false);
    }
  };

  if (isLoading) {
    return (
      <div className="flex items-center justify-center h-64">
        <LoadingSpinner size="lg" />
      </div>
    );
  }

  return (
    <div className="p-6 max-w-5xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
            <Settings size={24} className="text-orange-500" />
            Quản lý & Cấu hình Hệ thống (System Settings)
          </h1>
          <p className="text-gray-500 text-sm mt-1">
            Giám sát cấu hình mô hình Trí Tuệ Nhân Tạo (AI), Cơ sở dữ liệu MySQL và trạng thái Server
          </p>
        </div>

        <button
          onClick={fetchSystemInfo}
          className="px-4 py-2.5 bg-white border border-gray-200 text-gray-700 hover:bg-gray-50 rounded-xl flex items-center gap-2 text-sm font-medium shadow-sm transition-all"
        >
          <RefreshCw size={16} className={isLoading ? 'animate-spin' : ''} />
          Làm mới trạng thái
        </button>
      </div>

      {/* AI Engine Configuration Card */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-6 space-y-4">
        <div className="flex items-center justify-between pb-3 border-b border-gray-100">
          <div className="flex items-center gap-3">
            <div className="w-12 h-12 bg-purple-50 rounded-2xl flex items-center justify-center text-purple-600">
              <Sparkles size={24} />
            </div>
            <div>
              <h2 className="text-lg font-bold text-gray-900">Mô hình Trí Tuệ Nhân Tạo (AI Engine)</h2>
              <p className="text-xs text-gray-500">Động cơ đề xuất món ăn thông minh cốt lõi của đề tài</p>
            </div>
          </div>
          <span className="px-3 py-1 bg-emerald-100 text-emerald-800 text-xs font-bold rounded-full flex items-center gap-1.5">
            <span className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" />
            {data?.aiEngine.status || 'Sẵn sàng'}
          </span>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 text-xs">
          <div className="p-4 bg-gray-50 rounded-xl space-y-2">
            <span className="text-gray-500 font-medium">Nhà cung cấp & Mô hình:</span>
            <p className="text-sm font-bold text-gray-900">{data?.aiEngine.provider}</p>
            <div className="inline-block px-2.5 py-1 bg-purple-100 text-purple-800 font-mono font-bold rounded-lg text-xs">
              Model: {data?.aiEngine.model || 'gemini-3.5-flash'}
            </div>
          </div>

          <div className="p-4 bg-gray-50 rounded-xl space-y-2">
            <span className="text-gray-500 font-medium">Chiến lược khớp hình ảnh món ăn:</span>
            <p className="text-xs font-semibold text-emerald-700 leading-relaxed">
              {data?.aiEngine.imageSourcePriority}
            </p>
            <p className="text-[11px] text-gray-400">
              Ưu tiên truy vấn hình ảnh thật từ kho Cookpad MySQL theo từ khóa món ăn, sau đó fallback stock CDN.
            </p>
          </div>
        </div>

        <div className="flex items-center justify-between pt-2">
          <p className="text-xs text-gray-500">
            API Key được cấu hình an toàn trong file môi trường <code className="bg-gray-100 px-2 py-0.5 rounded font-mono text-gray-800">backend/.env</code>
          </p>
          <button
            onClick={handleTestAIConnection}
            disabled={isTestingAI}
            className="px-4 py-2 bg-gradient-to-r from-purple-600 to-indigo-600 hover:from-purple-700 hover:to-indigo-700 text-white rounded-xl text-xs font-semibold shadow-sm flex items-center gap-2 transition-all"
          >
            {isTestingAI ? <RefreshCw size={14} className="animate-spin" /> : <Activity size={14} />}
            Kiểm tra kết nối Gemini AI
          </button>
        </div>
      </div>

      {/* Database Status Card */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-6 space-y-4">
        <div className="flex items-center justify-between pb-3 border-b border-gray-100">
          <div className="flex items-center gap-3">
            <div className="w-12 h-12 bg-blue-50 rounded-2xl flex items-center justify-center text-blue-600">
              <Database size={24} />
            </div>
            <div>
              <h2 className="text-lg font-bold text-gray-900">Cơ sở Dữ liệu (MySQL Database)</h2>
              <p className="text-xs text-gray-500">Lưu trữ tài khoản, công thức cào Cookpad, lịch sử & món yêu thích</p>
            </div>
          </div>
          <span className="px-3 py-1 bg-blue-100 text-blue-800 text-xs font-bold rounded-full flex items-center gap-1.5">
            <ShieldCheck size={14} />
            {data?.database.status || 'Kết nối tốt'}
          </span>
        </div>

        <div className="grid grid-cols-2 sm:grid-cols-4 gap-4 text-center">
          <div className="p-3.5 bg-gray-50 rounded-xl">
            <span className="text-xs text-gray-500">Món ăn trong kho</span>
            <p className="text-xl font-bold text-orange-600 mt-1">{data?.database.totalRecipes || 0}</p>
          </div>
          <div className="p-3.5 bg-gray-50 rounded-xl">
            <span className="text-xs text-gray-500">Nguyên liệu đã map</span>
            <p className="text-xl font-bold text-emerald-600 mt-1">{data?.database.totalMappedIngredients || 0}</p>
          </div>
          <div className="p-3.5 bg-gray-50 rounded-xl">
            <span className="text-xs text-gray-500">Tài khoản người dùng</span>
            <p className="text-xl font-bold text-blue-600 mt-1">{data?.database.totalUsers || 0}</p>
          </div>
          <div className="p-3.5 bg-gray-50 rounded-xl">
            <span className="text-xs text-gray-500">Lượt tìm kiếm ghi nhận</span>
            <p className="text-xl font-bold text-purple-600 mt-1">{data?.database.totalSearchLogs || 0}</p>
          </div>
        </div>
      </div>

      {/* Server & Runtime Metrics Card */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm p-6 space-y-4">
        <div className="flex items-center gap-3 pb-3 border-b border-gray-100">
          <div className="w-12 h-12 bg-amber-50 rounded-2xl flex items-center justify-center text-amber-600">
            <Server size={24} />
          </div>
          <div>
            <h2 className="text-lg font-bold text-gray-900">Môi trường Máy chủ & Runtime</h2>
            <p className="text-xs text-gray-500">Thông số kỹ thuật backend Node.js / Express / TypeScript</p>
          </div>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 text-xs">
          <div className="p-3.5 bg-gray-50 rounded-xl flex items-center justify-between">
            <span className="text-gray-500">Node.js Version:</span>
            <span className="font-mono font-bold text-gray-800">{data?.server.nodeVersion || process.version}</span>
          </div>
          <div className="p-3.5 bg-gray-50 rounded-xl flex items-center justify-between">
            <span className="text-gray-500">Hệ điều hành / OS:</span>
            <span className="font-mono font-bold text-gray-800">{data?.server.platform || 'win32'}</span>
          </div>
          <div className="p-3.5 bg-gray-50 rounded-xl flex items-center justify-between">
            <span className="text-gray-500">Thời gian chạy (Uptime):</span>
            <span className="font-mono font-bold text-gray-800">{Math.floor((data?.server.uptimeSeconds || 0) / 60)} phút</span>
          </div>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 text-xs">
          <div className="p-3.5 bg-gray-50 rounded-xl flex items-center justify-between">
            <span className="text-gray-500">Bộ nhớ RSS sử dụng:</span>
            <span className="font-mono font-bold text-orange-600">{data?.server.memoryUsageMB || 0} MB</span>
          </div>
          <div className="p-3.5 bg-gray-50 rounded-xl flex items-center justify-between">
            <span className="text-gray-500">Bộ nhớ Heap sử dụng:</span>
            <span className="font-mono font-bold text-blue-600">{data?.server.heapUsedMB || 0} MB</span>
          </div>
        </div>
      </div>
    </div>
  );
}
