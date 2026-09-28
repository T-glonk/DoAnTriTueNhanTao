import { useState, FormEvent } from 'react';
import { User, Shield, Lock, Save, Camera } from 'lucide-react';
import toast from 'react-hot-toast';
import api from '../../lib/api';
import { useAuth } from '../../context/AuthContext';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import { AxiosError } from 'axios';
import { User as UserType } from '../../types';

export function ProfilePage() {
  const { user, updateUser } = useAuth();
  const [activeTab, setActiveTab] = useState<'profile' | 'password'>('profile');
  const [profileForm, setProfileForm] = useState({
    full_name: user?.full_name || '',
    avatar: user?.avatar || '',
  });
  const [passwordForm, setPasswordForm] = useState({
    current_password: '',
    new_password: '',
    confirm_password: '',
  });
  const [isLoadingProfile, setIsLoadingProfile] = useState(false);
  const [isLoadingPassword, setIsLoadingPassword] = useState(false);

  const handleProfileUpdate = async (e: FormEvent) => {
    e.preventDefault();
    setIsLoadingProfile(true);
    try {
      const res = await api.put<{ data: { user: UserType } }>('/auth/profile', profileForm);
      updateUser(res.data.data.user);
      toast.success('Cập nhật thông tin thành công!');
    } catch (error) {
      const err = error as AxiosError<{ error: string }>;
      toast.error(err.response?.data?.error || 'Cập nhật thất bại');
    } finally {
      setIsLoadingProfile(false);
    }
  };

  const handlePasswordChange = async (e: FormEvent) => {
    e.preventDefault();
    if (passwordForm.new_password !== passwordForm.confirm_password) {
      toast.error('Mật khẩu mới không khớp');
      return;
    }
    setIsLoadingPassword(true);
    try {
      await api.put('/auth/change-password', {
        current_password: passwordForm.current_password,
        new_password: passwordForm.new_password,
      });
      toast.success('Đổi mật khẩu thành công!');
      setPasswordForm({ current_password: '', new_password: '', confirm_password: '' });
    } catch (error) {
      const err = error as AxiosError<{ error: string }>;
      toast.error(err.response?.data?.error || 'Đổi mật khẩu thất bại');
    } finally {
      setIsLoadingPassword(false);
    }
  };

  const avatarUrl = profileForm.avatar || `https://api.dicebear.com/8.x/avataaars/svg?seed=${user?.username}`;

  return (
    <div className="p-6 max-w-2xl mx-auto">
      {/* Profile header */}
      <div className="card mb-6 text-center">
        <div className="relative inline-block mb-4">
          <img
            src={avatarUrl}
            alt="Avatar"
            className="w-20 h-20 rounded-full border-4 border-orange-100 mx-auto object-cover"
            onError={(e) => {
              (e.target as HTMLImageElement).src = `https://ui-avatars.com/api/?name=${user?.full_name}&background=f97316&color=fff`;
            }}
          />
          <div className="absolute bottom-0 right-0 p-1.5 bg-primary-500 rounded-full text-white cursor-pointer hover:bg-primary-600 transition-colors">
            <Camera size={12} />
          </div>
        </div>
        <h2 className="text-lg font-bold text-gray-900">{user?.full_name}</h2>
        <p className="text-gray-500 text-sm">{user?.email}</p>
        <div className="flex items-center justify-center gap-2 mt-2">
          <span className={`badge ${user?.role === 'admin' ? 'bg-purple-100 text-purple-700' : 'badge-blue'}`}>
            {user?.role === 'admin' ? '🛡️ Admin' : '👤 Người dùng'}
          </span>
        </div>
        <p className="text-xs text-gray-400 mt-2">
          Tham gia từ {user?.created_at ? new Date(user.created_at).toLocaleDateString('vi-VN') : 'N/A'}
        </p>
      </div>

      {/* Tabs */}
      <div className="flex gap-1 bg-gray-100 rounded-xl p-1 mb-6">
        <button
          onClick={() => setActiveTab('profile')}
          className={`flex-1 flex items-center justify-center gap-2 py-2.5 rounded-lg text-sm font-medium transition-all ${
            activeTab === 'profile'
              ? 'bg-white text-gray-900 shadow-sm'
              : 'text-gray-500 hover:text-gray-700'
          }`}
        >
          <User size={16} />
          Thông tin
        </button>
        <button
          onClick={() => setActiveTab('password')}
          className={`flex-1 flex items-center justify-center gap-2 py-2.5 rounded-lg text-sm font-medium transition-all ${
            activeTab === 'password'
              ? 'bg-white text-gray-900 shadow-sm'
              : 'text-gray-500 hover:text-gray-700'
          }`}
        >
          <Lock size={16} />
          Mật khẩu
        </button>
      </div>

      {activeTab === 'profile' && (
        <div className="card animate-fade-in">
          <div className="flex items-center gap-3 mb-5">
            <div className="w-8 h-8 bg-blue-100 rounded-lg flex items-center justify-center">
              <Shield size={16} className="text-blue-500" />
            </div>
            <h3 className="font-semibold text-gray-800">Thông tin cá nhân</h3>
          </div>
          <form onSubmit={handleProfileUpdate} className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5">Họ và tên</label>
              <input
                type="text"
                value={profileForm.full_name}
                onChange={(e) => setProfileForm(p => ({ ...p, full_name: e.target.value }))}
                className="input-field"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5">Email</label>
              <input
                type="email"
                value={user?.email}
                className="input-field bg-gray-50 cursor-not-allowed"
                disabled
              />
              <p className="text-xs text-gray-400 mt-1">Email không thể thay đổi</p>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5">Tên đăng nhập</label>
              <input
                type="text"
                value={user?.username}
                className="input-field bg-gray-50 cursor-not-allowed"
                disabled
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5">URL Avatar (tùy chọn)</label>
              <input
                type="url"
                value={profileForm.avatar}
                onChange={(e) => setProfileForm(p => ({ ...p, avatar: e.target.value }))}
                className="input-field"
                placeholder="https://example.com/avatar.jpg"
              />
            </div>
            <button
              type="submit"
              disabled={isLoadingProfile}
              className="w-full btn-primary py-3 flex items-center justify-center gap-2"
            >
              {isLoadingProfile ? <LoadingSpinner size="sm" color="text-white" /> : <Save size={16} />}
              {isLoadingProfile ? 'Đang lưu...' : 'Lưu thay đổi'}
            </button>
          </form>
        </div>
      )}

      {activeTab === 'password' && (
        <div className="card animate-fade-in">
          <div className="flex items-center gap-3 mb-5">
            <div className="w-8 h-8 bg-orange-100 rounded-lg flex items-center justify-center">
              <Lock size={16} className="text-orange-500" />
            </div>
            <h3 className="font-semibold text-gray-800">Đổi mật khẩu</h3>
          </div>
          <form onSubmit={handlePasswordChange} className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5">Mật khẩu hiện tại</label>
              <input
                type="password"
                value={passwordForm.current_password}
                onChange={(e) => setPasswordForm(p => ({ ...p, current_password: e.target.value }))}
                className="input-field"
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5">Mật khẩu mới</label>
              <input
                type="password"
                value={passwordForm.new_password}
                onChange={(e) => setPasswordForm(p => ({ ...p, new_password: e.target.value }))}
                className="input-field"
                minLength={6}
                required
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1.5">Xác nhận mật khẩu mới</label>
              <input
                type="password"
                value={passwordForm.confirm_password}
                onChange={(e) => setPasswordForm(p => ({ ...p, confirm_password: e.target.value }))}
                className="input-field"
                required
              />
            </div>
            <button
              type="submit"
              disabled={isLoadingPassword}
              className="w-full btn-primary py-3 flex items-center justify-center gap-2"
            >
              {isLoadingPassword ? <LoadingSpinner size="sm" color="text-white" /> : <Lock size={16} />}
              {isLoadingPassword ? 'Đang đổi...' : 'Đổi mật khẩu'}
            </button>
          </form>
        </div>
      )}
    </div>
  );
}
