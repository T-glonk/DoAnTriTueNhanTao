import { useState } from 'react';
import { Link, useLocation, useNavigate, Outlet } from 'react-router-dom';
import { ChefHat, Home, Heart, History, User, LogOut, Menu, X, Shield, LogIn, UserPlus } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import toast from 'react-hot-toast';

const navItems = [
  { path: '/dashboard', aliases: ['/', '/dashboard'], icon: Home, label: 'Trang chủ' },
  { path: '/dashboard/favorites', aliases: ['/favorites', '/dashboard/favorites'], icon: Heart, label: 'Yêu thích' },
  { path: '/dashboard/history', aliases: ['/history', '/dashboard/history'], icon: History, label: 'Lịch sử' },
  { path: '/dashboard/profile', aliases: ['/profile', '/dashboard/profile'], icon: User, label: 'Tài khoản' },
];

export function UserLayout() {
  const { user, logout } = useAuth();
  const location = useLocation();
  const navigate = useNavigate();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  const handleLogout = () => {
    logout();
    toast.success('Đã đăng xuất');
    navigate('/login');
  };

  return (
    <div className="min-h-screen bg-gray-50 flex">
      {/* Sidebar - desktop */}
      <aside className="hidden lg:flex flex-col w-64 bg-white border-r border-gray-100 fixed h-full z-10">
        {/* Logo */}
        <div className="p-6 border-b border-gray-100">
          <Link to="/" className="flex items-center gap-3">
            <div className="w-10 h-10 bg-gradient-to-br from-orange-400 to-primary-600 rounded-xl flex items-center justify-center">
              <ChefHat size={20} className="text-white" />
            </div>
            <div>
              <h1 className="font-bold text-gray-900 text-lg leading-tight">FoodAI</h1>
              <p className="text-xs text-gray-400">Gợi ý món ăn</p>
            </div>
          </Link>
        </div>

        {/* User info */}
        {user ? (
          <div className="p-4 mx-4 my-3 bg-gradient-to-r from-orange-50 to-amber-50 rounded-xl border border-orange-100">
            <div className="flex items-center gap-3">
              <div className="w-9 h-9 bg-gradient-to-br from-orange-300 to-primary-500 rounded-full flex items-center justify-center text-white font-bold text-sm shadow-xs">
                {user.full_name?.charAt(0).toUpperCase()}
              </div>
              <div className="min-w-0">
                <p className="font-semibold text-gray-800 text-sm truncate">{user.full_name}</p>
                <p className="text-xs text-gray-500 truncate">{user.email}</p>
              </div>
            </div>
          </div>
        ) : (
          <div className="p-4 mx-4 my-3 bg-gradient-to-r from-gray-50 to-orange-50/40 rounded-xl border border-dashed border-orange-200">
            <div className="flex items-center gap-3">
              <div className="w-9 h-9 bg-orange-100 text-orange-600 rounded-full flex items-center justify-center font-bold text-sm">
                <User size={18} />
              </div>
              <div className="min-w-0">
                <p className="font-semibold text-gray-800 text-sm truncate">Khách trải nghiệm</p>
                <p className="text-xs text-gray-400 truncate">Chưa đăng nhập</p>
              </div>
            </div>
          </div>
        )}

        {/* Admin Navigation Button */}
        {user?.role === 'admin' && (
          <div className="px-4 mb-2">
            <Link
              to="/admin"
              className="flex items-center gap-3 px-4 py-3 bg-gradient-to-r from-gray-900 to-gray-800 text-white rounded-xl text-sm font-semibold shadow-md hover:from-black hover:to-gray-900 transition-all border border-gray-700"
            >
              <Shield size={18} className="text-orange-400" />
              <span>Bảng Quản Trị Hệ Thống</span>
            </Link>
          </div>
        )}

        {/* Navigation */}
        <nav className="flex-1 px-4 py-2 space-y-1">
          {navItems.map(({ path, aliases, icon: Icon, label }) => {
            const isActive = aliases.includes(location.pathname);
            return (
              <Link
                key={path}
                to={path}
                className={`flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium transition-all duration-200 ${
                  isActive
                    ? 'bg-primary-50 text-primary-600 shadow-sm'
                    : 'text-gray-600 hover:bg-gray-50 hover:text-gray-900'
                }`}
              >
                <Icon size={18} />
                {label}
              </Link>
            );
          })}
        </nav>

        {/* Bottom Section - Logout if logged in, or 2 Buttons (Register & Login) if guest */}
        <div className="p-4 border-t border-gray-100 mt-auto bg-gradient-to-t from-orange-50/40 to-transparent">
          {user ? (
            <button
              onClick={handleLogout}
              className="flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium text-gray-600 hover:bg-red-50 hover:text-red-600 w-full transition-all duration-200"
            >
              <LogOut size={18} />
              Đăng xuất
            </button>
          ) : (
            <div className="space-y-2.5">
              <div className="flex items-center justify-between text-xs text-gray-500 font-medium px-1">
                <span>Tài khoản FoodAI</span>
                <span className="text-[10px] bg-orange-100 text-orange-700 px-2 py-0.5 rounded-full font-bold">Khách</span>
              </div>
              <div className="flex flex-col gap-2">
                <Link
                  to="/register"
                  id="btn-register-sidebar"
                  className="flex items-center justify-center gap-2 px-4 py-2.5 bg-gradient-to-r from-orange-500 via-orange-600 to-amber-500 hover:from-orange-600 hover:to-amber-600 text-white rounded-xl text-sm font-bold shadow-md shadow-orange-500/20 hover:shadow-lg transition-all duration-200"
                >
                  <UserPlus size={16} />
                  <span>Đăng ký</span>
                </Link>
                <Link
                  to="/login"
                  id="btn-login-sidebar"
                  className="flex items-center justify-center gap-2 px-4 py-2.5 bg-white border border-orange-200 text-orange-600 hover:bg-orange-50 hover:border-orange-300 rounded-xl text-sm font-bold shadow-xs transition-all duration-200"
                >
                  <LogIn size={16} />
                  <span>Đăng nhập</span>
                </Link>
              </div>
            </div>
          )}
        </div>
      </aside>

      {/* Mobile header */}
      <div className="lg:hidden fixed top-0 left-0 right-0 bg-white border-b border-gray-100 z-20 px-4 py-3 flex items-center justify-between">
        <Link to="/" className="flex items-center gap-2">
          <div className="w-8 h-8 bg-gradient-to-br from-orange-400 to-primary-600 rounded-lg flex items-center justify-center">
            <ChefHat size={16} className="text-white" />
          </div>
          <span className="font-bold text-gray-900">FoodAI</span>
        </Link>
        <button
          onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
          className="p-2 rounded-lg hover:bg-gray-100"
          aria-label="Menu"
        >
          {mobileMenuOpen ? <X size={20} /> : <Menu size={20} />}
        </button>
      </div>

      {/* Mobile menu */}
      {mobileMenuOpen && (
        <div className="lg:hidden fixed inset-0 bg-black/50 z-30" onClick={() => setMobileMenuOpen(false)}>
          <div className="absolute top-0 right-0 w-64 h-full bg-white shadow-xl" onClick={e => e.stopPropagation()}>
            <div className="p-4 border-b flex items-center justify-between">
              <span className="font-bold text-gray-900">Menu</span>
              <button onClick={() => setMobileMenuOpen(false)}>
                <X size={20} />
              </button>
            </div>
            {user?.role === 'admin' && (
              <div className="p-3 border-b border-gray-100">
                <Link
                  to="/admin"
                  onClick={() => setMobileMenuOpen(false)}
                  className="flex items-center gap-3 px-4 py-3 bg-gray-900 text-white rounded-xl text-sm font-semibold shadow-md"
                >
                  <Shield size={18} className="text-orange-400" />
                  <span>Trang Quản Trị Hệ Thống</span>
                </Link>
              </div>
            )}
            <nav className="p-4 space-y-1">
              {navItems.map(({ path, aliases, icon: Icon, label }) => (
                <Link
                  key={path}
                  to={path}
                  onClick={() => setMobileMenuOpen(false)}
                  className={`flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium transition-all ${
                    aliases.includes(location.pathname)
                      ? 'bg-primary-50 text-primary-600'
                      : 'text-gray-600 hover:bg-gray-50'
                  }`}
                >
                  <Icon size={18} />
                  {label}
                </Link>
              ))}
            </nav>
            <div className="p-4 border-t">
              {user ? (
                <button
                  onClick={handleLogout}
                  className="flex items-center gap-3 px-4 py-3 rounded-xl text-sm text-red-600 hover:bg-red-50 w-full"
                >
                  <LogOut size={18} />
                  Đăng xuất
                </button>
              ) : (
                <div className="space-y-2">
                  <Link
                    to="/register"
                    onClick={() => setMobileMenuOpen(false)}
                    className="flex items-center justify-center gap-2 px-4 py-2.5 bg-gradient-to-r from-orange-500 to-amber-500 text-white rounded-xl text-sm font-bold shadow-md"
                  >
                    <UserPlus size={16} />
                    <span>Đăng ký</span>
                  </Link>
                  <Link
                    to="/login"
                    onClick={() => setMobileMenuOpen(false)}
                    className="flex items-center justify-center gap-2 px-4 py-2.5 bg-orange-50 text-orange-600 rounded-xl text-sm font-bold"
                  >
                    <LogIn size={16} />
                    <span>Đăng nhập</span>
                  </Link>
                </div>
              )}
            </div>
          </div>
        </div>
      )}

      {/* Floating Auth Buttons on Mobile (Bottom-Left Corner) */}
      {!user && (
        <div className="lg:hidden fixed bottom-4 left-4 z-40 flex items-center gap-2 bg-white/95 backdrop-blur-md p-1.5 rounded-2xl shadow-xl border border-orange-200 animate-fade-in">
          <Link
            to="/register"
            id="mobile-btn-register"
            className="flex items-center gap-1.5 px-3 py-2 text-xs font-bold text-white bg-gradient-to-r from-orange-500 to-amber-500 hover:from-orange-600 rounded-xl shadow-md transition-all"
          >
            <UserPlus size={14} />
            <span>Đăng ký</span>
          </Link>
          <Link
            to="/login"
            id="mobile-btn-login"
            className="flex items-center gap-1.5 px-3 py-2 text-xs font-bold text-orange-600 bg-orange-50 hover:bg-orange-100 rounded-xl transition-all"
          >
            <LogIn size={14} />
            <span>Đăng nhập</span>
          </Link>
        </div>
      )}

      {/* Main content */}
      <main className="flex-1 lg:ml-64 pt-0 lg:pt-0">
        <div className="lg:hidden h-14" />
        <Outlet />
      </main>
    </div>
  );
}
