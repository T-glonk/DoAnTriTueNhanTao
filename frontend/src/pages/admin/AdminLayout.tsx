import { useState } from 'react';
import { Link, useLocation, useNavigate, Outlet } from 'react-router-dom';
import { 
  ChefHat, LayoutDashboard, Users, Utensils, 
  Sparkles, Settings, LogOut, Menu, X, Shield, Bell
} from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import toast from 'react-hot-toast';


const navItems = [
  { path: '/admin', icon: LayoutDashboard, label: 'Tổng quan hệ thống', exact: true },
  { path: '/admin/users', icon: Users, label: 'Quản lý người dùng' },
  { path: '/admin/recipes', icon: Utensils, label: 'Kho món ăn & Ảnh Cookpad' },
  { path: '/admin/history', icon: Sparkles, label: 'Lịch sử tìm kiếm & AI Logs' },
  { path: '/admin/settings', icon: Settings, label: 'Cài đặt & Trạng thái AI' },
];


export function AdminLayout() {
  const { user, logout } = useAuth();
  const location = useLocation();
  const navigate = useNavigate();
  const [mobileMenuOpen, setMobileMenuOpen] = useState(false);

  const handleLogout = () => {
    logout();
    toast.success('Đã đăng xuất');
    navigate('/login');
  };

  const isActive = (path: string, exact?: boolean) => {
    if (exact) return location.pathname === path;
    return location.pathname.startsWith(path);
  };

  return (
    <div className="min-h-screen bg-gray-50 flex">
      {/* Sidebar */}
      <aside className="hidden lg:flex flex-col w-64 bg-gray-900 fixed h-full z-10">
        {/* Logo */}
        <div className="p-6 border-b border-gray-700">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 bg-gradient-to-br from-orange-400 to-primary-600 rounded-xl flex items-center justify-center">
              <ChefHat size={20} className="text-white" />
            </div>
            <div>
              <h1 className="font-bold text-white text-lg leading-tight">FoodAI</h1>
              <div className="flex items-center gap-1">
                <Shield size={10} className="text-orange-400" />
                <p className="text-xs text-orange-400">Admin Panel</p>
              </div>
            </div>
          </div>
        </div>

        {/* Admin info */}
        <div className="p-4 mx-4 my-3 bg-gray-800 rounded-xl">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 bg-gradient-to-br from-orange-400 to-primary-500 rounded-full flex items-center justify-center text-white font-bold text-sm">
              {user?.full_name?.charAt(0).toUpperCase()}
            </div>
            <div className="min-w-0">
              <p className="font-semibold text-white text-sm truncate">{user?.full_name}</p>
              <p className="text-xs text-gray-400 truncate">Quản trị viên</p>
            </div>
          </div>
        </div>

        {/* Navigation */}
        <nav className="flex-1 px-4 py-2 space-y-1">
          {navItems.map(({ path, icon: Icon, label, exact }) => (
            <Link
              key={path}
              to={path}
              className={`flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium transition-all duration-200 ${
                isActive(path, exact)
                  ? 'bg-primary-600 text-white'
                  : 'text-gray-400 hover:bg-gray-800 hover:text-white'
              }`}
            >
              <Icon size={18} />
              {label}
            </Link>
          ))}
        </nav>

        {/* Back to user view */}
        <div className="px-4 mb-2">
          <Link
            to="/dashboard"
            className="flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium text-gray-400 hover:bg-gray-800 hover:text-white transition-all w-full"
          >
            <ChefHat size={18} />
            Xem góc khách hàng
          </Link>
        </div>

        {/* Logout */}
        <div className="p-4 border-t border-gray-700">
          <button
            onClick={handleLogout}
            className="flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium text-gray-400 hover:bg-red-900/50 hover:text-red-400 w-full transition-all"
          >
            <LogOut size={18} />
            Đăng xuất
          </button>
        </div>
      </aside>

      {/* Mobile header */}
      <div className="lg:hidden fixed top-0 left-0 right-0 bg-gray-900 z-20 px-4 py-3 flex items-center justify-between">
        <div className="flex items-center gap-2">
          <div className="w-8 h-8 bg-gradient-to-br from-orange-400 to-primary-600 rounded-lg flex items-center justify-center">
            <ChefHat size={16} className="text-white" />
          </div>
          <span className="font-bold text-white">FoodAI Admin</span>
        </div>
        <div className="flex items-center gap-2">
          <button className="p-2 text-gray-400 hover:text-white">
            <Bell size={18} />
          </button>
          <button
            onClick={() => setMobileMenuOpen(!mobileMenuOpen)}
            className="p-2 text-gray-400 hover:text-white"
          >
            {mobileMenuOpen ? <X size={20} /> : <Menu size={20} />}
          </button>
        </div>
      </div>

      {/* Mobile menu */}
      {mobileMenuOpen && (
        <div className="lg:hidden fixed inset-0 bg-black/70 z-30" onClick={() => setMobileMenuOpen(false)}>
          <div className="absolute top-0 left-0 w-64 h-full bg-gray-900 shadow-xl" onClick={e => e.stopPropagation()}>
            <div className="p-4 border-b border-gray-700">
              <span className="text-white font-bold">Menu Admin</span>
            </div>
            <nav className="p-4 space-y-1">
              {navItems.map(({ path, icon: Icon, label, exact }) => (
                <Link
                  key={path}
                  to={path}
                  onClick={() => setMobileMenuOpen(false)}
                  className={`flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-medium transition-all ${
                    isActive(path, exact)
                      ? 'bg-primary-600 text-white'
                      : 'text-gray-400 hover:bg-gray-800 hover:text-white'
                  }`}
                >
                  <Icon size={18} />
                  {label}
                </Link>
              ))}
            </nav>
            <div className="p-4 border-t border-gray-700">
              <button onClick={handleLogout} className="flex items-center gap-3 px-4 py-3 text-sm text-red-400 hover:bg-red-900/30 rounded-xl w-full">
                <LogOut size={18} />
                Đăng xuất
              </button>
            </div>
          </div>
        </div>
      )}

      {/* Main content */}
      <main className="flex-1 lg:ml-64">
        <div className="lg:hidden h-14" />
        <Outlet />
      </main>
    </div>
  );
}
