import { useState, FormEvent } from 'react';
import { Link, useNavigate, useLocation } from 'react-router-dom';
import { Eye, EyeOff, ChefHat, Mail, Lock } from 'lucide-react';
import toast from 'react-hot-toast';
import { useAuth } from '../context/AuthContext';
import { LoadingSpinner } from '../components/ui/LoadingSpinner';
import { AxiosError } from 'axios';

export function LoginPage() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [isLoading, setIsLoading] = useState(false);
  const { login } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const handleSubmit = async (e: FormEvent) => {
    e.preventDefault();
    if (!email || !password) {
      toast.error('Vui lòng điền đầy đủ thông tin');
      return;
    }

    setIsLoading(true);
    try {
      const loggedUser = await login(email, password);
      toast.success('Đăng nhập thành công!');
      const requestedFrom = (location.state as { from?: string })?.from;
      const targetPath = requestedFrom || (loggedUser.role === 'admin' ? '/admin' : '/dashboard');
      navigate(targetPath, { replace: true });
    } catch (error) {
      const err = error as AxiosError<{ error: string }>;
      toast.error(err.response?.data?.error || 'Đăng nhập thất bại');
    } finally {
      setIsLoading(false);
    }
  };

  const fillDemo = (role: 'admin' | 'user') => {
    if (role === 'admin') {
      setEmail('admin@foodsystem.com');
      setPassword('Admin@123456');
    } else {
      setEmail('user@foodsystem.com');
      setPassword('User@123456');
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-orange-50 via-amber-50 to-yellow-50 flex items-center justify-center p-4">
      <div className="w-full max-w-md">
        {/* Logo */}
        <div className="text-center mb-8">
          <div className="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-br from-orange-400 to-primary-600 rounded-2xl mb-4 shadow-lg">
            <ChefHat size={32} className="text-white" />
          </div>
          <h1 className="text-3xl font-bold gradient-text">FoodAI</h1>
          <p className="text-gray-500 mt-1">Gợi ý món ăn thông minh</p>
        </div>

        {/* Card */}
        <div className="card shadow-lg border-0">
          <h2 className="text-xl font-bold text-gray-800 mb-6 text-center">Đăng nhập</h2>

          {/* Demo accounts */}
          <div className="flex gap-2 mb-6 p-3 bg-blue-50 rounded-xl">
            <div className="flex-1">
              <p className="text-xs text-blue-600 font-medium mb-2">Tài khoản demo:</p>
              <div className="flex gap-2">
                <button
                  type="button"
                  onClick={() => fillDemo('user')}
                  className="flex-1 text-xs py-1.5 px-2 bg-white border border-blue-200 text-blue-700 rounded-lg hover:bg-blue-50 transition-colors"
                >
                  👤 Khách hàng
                </button>
                <button
                  type="button"
                  onClick={() => fillDemo('admin')}
                  className="flex-1 text-xs py-1.5 px-2 bg-white border border-blue-200 text-blue-700 rounded-lg hover:bg-blue-50 transition-colors"
                >
                  🛡️ Admin
                </button>
              </div>
            </div>
          </div>

          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5">Email</label>
              <div className="relative">
                <Mail size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
                <input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="input-field pl-10"
                  placeholder="your@email.com"
                  required
                  autoComplete="email"
                />
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5">Mật khẩu</label>
              <div className="relative">
                <Lock size={16} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
                <input
                  type={showPassword ? 'text' : 'password'}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="input-field pl-10 pr-10"
                  placeholder="••••••••"
                  required
                  autoComplete="current-password"
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
                  aria-label={showPassword ? 'Ẩn mật khẩu' : 'Hiện mật khẩu'}
                >
                  {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
                </button>
              </div>
            </div>

            <button
              type="submit"
              disabled={isLoading}
              className="w-full btn-primary py-3 flex items-center justify-center gap-2 text-base"
            >
              {isLoading ? <LoadingSpinner size="sm" color="text-white" /> : null}
              {isLoading ? 'Đang đăng nhập...' : 'Đăng nhập'}
            </button>
          </form>

          <p className="text-center text-sm text-gray-500 mt-6">
            Chưa có tài khoản?{' '}
            <Link to="/register" className="text-primary-600 font-medium hover:underline">
              Đăng ký ngay
            </Link>
          </p>
        </div>
      </div>
    </div>
  );
}
