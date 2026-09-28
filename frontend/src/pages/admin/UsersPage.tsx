import { useState, useEffect, useCallback } from 'react';
import {
  Users, Search, Plus, Pencil, Trash2, ToggleLeft, ToggleRight,
  ChevronLeft, ChevronRight, X, Key, Shield, User as UserIcon, AlertTriangle
} from 'lucide-react';
import toast from 'react-hot-toast';
import api from '../../lib/api';
import { User, PaginationMeta } from '../../types';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import { useAuth } from '../../context/AuthContext';
import { AxiosError } from 'axios';

// ==========================================
// 1. Modal Thêm / Sửa người dùng
// ==========================================
interface UserModalProps {
  user?: User | null;
  onClose: () => void;
  onSave: () => void;
  currentUserId?: string;
}

function UserModal({ user, onClose, onSave, currentUserId }: UserModalProps) {
  const isEdit = Boolean(user);
  const isSelf = user?.id === currentUserId;

  const [form, setForm] = useState({
    username: user?.username || '',
    email: user?.email || '',
    full_name: user?.full_name || '',
    password: '',
    role: (user?.role || 'user') as 'admin' | 'user',
    is_active: user?.is_active !== false,
  });
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsLoading(true);
    try {
      if (isEdit && user) {
        await api.put(`/admin/users/${user.id}`, {
          full_name: form.full_name,
          email: form.email,
          role: form.role,
          is_active: form.is_active,
        });
        toast.success('Cập nhật thông tin người dùng thành công!');
      } else {
        await api.post('/admin/users', form);
        toast.success('Tạo tài khoản người dùng thành công!');
      }
      onSave();
      onClose();
    } catch (error) {
      const err = error as AxiosError<{ error: string }>;
      toast.error(err.response?.data?.error || 'Thao tác thất bại');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div
      className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50 p-4 animate-fade-in"
      onClick={(e) => e.target === e.currentTarget && onClose()}
    >
      <div className="bg-white rounded-2xl max-w-md w-full p-6 shadow-2xl animate-slide-up border border-gray-100">
        <div className="flex items-center justify-between mb-5 pb-3 border-b">
          <div className="flex items-center gap-2">
            <div className="p-2 bg-orange-100 text-orange-600 rounded-lg">
              {isEdit ? <Pencil size={18} /> : <Plus size={18} />}
            </div>
            <h3 className="text-lg font-bold text-gray-900">
              {isEdit ? 'Chỉnh sửa người dùng' : 'Thêm người dùng mới'}
            </h3>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-gray-100 text-gray-400 hover:text-gray-600 rounded-lg transition-colors">
            <X size={18} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Họ và tên <span className="text-red-500">*</span></label>
            <input
              type="text"
              value={form.full_name}
              onChange={e => setForm(p => ({ ...p, full_name: e.target.value }))}
              className="w-full px-3.5 py-2.5 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-orange-500 text-sm"
              placeholder="Nguyễn Văn A"
              required
            />
          </div>

          {!isEdit && (
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Tên đăng nhập <span className="text-red-500">*</span></label>
              <input
                type="text"
                value={form.username}
                onChange={e => setForm(p => ({ ...p, username: e.target.value }))}
                className="w-full px-3.5 py-2.5 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-orange-500 text-sm"
                placeholder="nguyenvana"
                required
              />
            </div>
          )}

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Email <span className="text-red-500">*</span></label>
            <input
              type="email"
              value={form.email}
              onChange={e => setForm(p => ({ ...p, email: e.target.value }))}
              className="w-full px-3.5 py-2.5 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-orange-500 text-sm"
              placeholder="user@example.com"
              required
            />
          </div>

          {!isEdit && (
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Mật khẩu ban đầu <span className="text-red-500">*</span></label>
              <input
                type="password"
                value={form.password}
                onChange={e => setForm(p => ({ ...p, password: e.target.value }))}
                className="w-full px-3.5 py-2.5 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-orange-500 text-sm"
                placeholder="Ít nhất 6 ký tự"
                minLength={6}
                required
              />
            </div>
          )}

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Vai trò (Role)</label>
            <select
              value={form.role}
              onChange={e => setForm(p => ({ ...p, role: e.target.value as 'admin' | 'user' }))}
              className="w-full px-3.5 py-2.5 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-orange-500 text-sm bg-white"
              disabled={isSelf}
            >
              <option value="user">Người dùng (user)</option>
              <option value="admin">Quản trị viên (admin)</option>
            </select>
            {isSelf && <p className="text-xs text-gray-400 mt-1">Không thể tự thay đổi vai trò của chính mình</p>}
          </div>

          <div className="flex items-center gap-3 pt-2">
            <input
              type="checkbox"
              id="is_active_modal"
              checked={form.is_active}
              onChange={e => setForm(p => ({ ...p, is_active: e.target.checked }))}
              disabled={isSelf}
              className="w-4 h-4 text-orange-600 rounded focus:ring-orange-500"
            />
            <label htmlFor="is_active_modal" className="text-sm font-medium text-gray-700 cursor-pointer">
              Kích hoạt tài khoản ngay
            </label>
          </div>
          {isSelf && <p className="text-xs text-amber-600">Bạn không thể tự vô hiệu hoá tài khoản của chính mình</p>}

          <div className="flex justify-end gap-3 pt-4 border-t mt-5">
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2 text-sm text-gray-600 hover:bg-gray-100 rounded-xl transition-colors font-medium"
            >
              Hủy
            </button>
            <button
              type="submit"
              disabled={isLoading}
              className="px-5 py-2 text-sm bg-orange-600 text-white hover:bg-orange-700 rounded-xl transition-colors font-medium flex items-center gap-2 shadow-sm disabled:opacity-50"
            >
              {isLoading ? <LoadingSpinner size="sm" color="text-white" /> : null}
              <span>{isEdit ? 'Lưu thay đổi' : 'Tạo tài khoản'}</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

// ==========================================
// 2. Modal Đặt lại mật khẩu (Reset Password)
// ==========================================
interface ResetPasswordModalProps {
  user: User;
  onClose: () => void;
}

function ResetPasswordModal({ user, onClose }: ResetPasswordModalProps) {
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (newPassword.length < 6) {
      toast.error('Mật khẩu phải có ít nhất 6 ký tự');
      return;
    }
    if (newPassword !== confirmPassword) {
      toast.error('Mật khẩu xác nhận không khớp');
      return;
    }

    setIsLoading(true);
    try {
      await api.put(`/admin/users/${user.id}/reset-password`, { new_password: newPassword });
      toast.success(`Đặt lại mật khẩu cho ${user.full_name} thành công!`);
      onClose();
    } catch (error) {
      const err = error as AxiosError<{ error: string }>;
      toast.error(err.response?.data?.error || 'Đặt lại mật khẩu thất bại');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div
      className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50 p-4 animate-fade-in"
      onClick={(e) => e.target === e.currentTarget && onClose()}
    >
      <div className="bg-white rounded-2xl max-w-md w-full p-6 shadow-2xl animate-slide-up border border-gray-100">
        <div className="flex items-center justify-between mb-4 pb-3 border-b">
          <div className="flex items-center gap-2">
            <div className="p-2 bg-blue-100 text-blue-600 rounded-lg">
              <Key size={18} />
            </div>
            <h3 className="text-lg font-bold text-gray-900">Đặt lại mật khẩu</h3>
          </div>
          <button onClick={onClose} className="p-2 hover:bg-gray-100 text-gray-400 hover:text-gray-600 rounded-lg transition-colors">
            <X size={18} />
          </button>
        </div>

        <p className="text-sm text-gray-500 mb-4">
          Đặt lại mật khẩu mới cho người dùng: <strong className="text-gray-800">{user.full_name}</strong> ({user.email})
        </p>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Mật khẩu mới <span className="text-red-500">*</span></label>
            <input
              type="password"
              value={newPassword}
              onChange={e => setNewPassword(e.target.value)}
              className="w-full px-3.5 py-2.5 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
              placeholder="Nhập ít nhất 6 ký tự"
              minLength={6}
              required
            />
          </div>

          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Xác nhận mật khẩu mới <span className="text-red-500">*</span></label>
            <input
              type="password"
              value={confirmPassword}
              onChange={e => setConfirmPassword(e.target.value)}
              className="w-full px-3.5 py-2.5 border border-gray-300 rounded-xl focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
              placeholder="Nhập lại mật khẩu"
              minLength={6}
              required
            />
          </div>

          <div className="flex justify-end gap-3 pt-3 border-t">
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2 text-sm text-gray-600 hover:bg-gray-100 rounded-xl font-medium"
            >
              Hủy
            </button>
            <button
              type="submit"
              disabled={isLoading}
              className="px-5 py-2 text-sm bg-blue-600 text-white hover:bg-blue-700 rounded-xl font-medium flex items-center gap-2 shadow-sm disabled:opacity-50"
            >
              {isLoading ? <LoadingSpinner size="sm" color="text-white" /> : null}
              <span>Xác nhận đặt lại</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}

// ==========================================
// 3. Modal Xác nhận xóa người dùng
// ==========================================
interface DeleteConfirmModalProps {
  user: User;
  onClose: () => void;
  onConfirm: () => void;
  isLoading: boolean;
}

function DeleteConfirmModal({ user, onClose, onConfirm, isLoading }: DeleteConfirmModalProps) {
  return (
    <div
      className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50 p-4 animate-fade-in"
      onClick={(e) => e.target === e.currentTarget && onClose()}
    >
      <div className="bg-white rounded-2xl max-w-sm w-full p-6 shadow-2xl animate-slide-up border border-gray-100 text-center">
        <div className="w-12 h-12 bg-red-100 text-red-600 rounded-full flex items-center justify-center mx-auto mb-4">
          <AlertTriangle size={24} />
        </div>
        <h3 className="text-lg font-bold text-gray-900 mb-2">Xác nhận xóa tài khoản?</h3>
        <p className="text-sm text-gray-500 mb-6">
          Bạn có chắc chắn muốn xóa tài khoản <strong>{user.full_name}</strong> ({user.email})? Hành động này không thể khôi phục!
        </p>
        <div className="flex justify-center gap-3">
          <button
            onClick={onClose}
            className="px-4 py-2 text-sm text-gray-600 hover:bg-gray-100 rounded-xl font-medium"
          >
            Hủy
          </button>
          <button
            onClick={onConfirm}
            disabled={isLoading}
            className="px-5 py-2 text-sm bg-red-600 text-white hover:bg-red-700 rounded-xl font-medium flex items-center gap-2 shadow-sm disabled:opacity-50"
          >
            {isLoading ? <LoadingSpinner size="sm" color="text-white" /> : null}
            <span>Xóa tài khoản</span>
          </button>
        </div>
      </div>
    </div>
  );
}

// ==========================================
// 4. Trang Quản lý Người dùng (Chính)
// ==========================================
export function UsersPage() {
  const { user: currentUser } = useAuth();
  const [users, setUsers] = useState<User[]>([]);
  const [meta, setMeta] = useState<PaginationMeta>({ page: 1, limit: 10, total: 0, totalPages: 1 });
  const [search, setSearch] = useState('');
  const [isLoading, setIsLoading] = useState(true);

  // Modals state
  const [modalUser, setModalUser] = useState<User | null | undefined>(undefined); // undefined: đóng, null: tạo mới, User: sửa
  const [resetPwdUser, setResetPwdUser] = useState<User | null>(null);
  const [deleteTargetUser, setDeleteTargetUser] = useState<User | null>(null);
  const [isDeleting, setIsDeleting] = useState(false);

  // Load danh sách người dùng
  const fetchUsers = useCallback(async (page: number = 1, searchQuery: string = search) => {
    setIsLoading(true);
    try {
      const response = await api.get<{ data: { users: User[]; meta: PaginationMeta } }>('/admin/users', {
        params: { page, limit: 10, search: searchQuery }
      });
      setUsers(response.data.data.users);
      setMeta(response.data.data.meta);
    } catch (error) {
      console.error(error);
      toast.error('Không thể tải danh sách người dùng');
    } finally {
      setIsLoading(false);
    }
  }, [search]);

  useEffect(() => {
    fetchUsers(1, search);
  }, [fetchUsers, search]);

  // Debounced Search
  const handleSearchChange = (val: string) => {
    setSearch(val);
  };

  // FR-05.5: Kích hoạt / vô hiệu hoá nhanh (Toggle Status)
  const handleToggleStatus = async (targetUser: User) => {
    if (targetUser.id === currentUser?.id) {
      toast.error('Bạn không thể tự vô hiệu hóa tài khoản của chính mình!');
      return;
    }

    const nextStatus = !targetUser.is_active;
    try {
      await api.put(`/admin/users/${targetUser.id}`, {
        is_active: nextStatus
      });
      toast.success(nextStatus ? `Đã kích hoạt tài khoản ${targetUser.full_name}` : `Đã vô hiệu hóa tài khoản ${targetUser.full_name}`);
      setUsers(prev => prev.map(u => u.id === targetUser.id ? { ...u, is_active: nextStatus } : u));
    } catch (error) {
      const err = error as AxiosError<{ error: string }>;
      toast.error(err.response?.data?.error || 'Không thể đổi trạng thái');
    }
  };

  // FR-05.6: Xác nhận xóa người dùng
  const handleDeleteUser = async () => {
    if (!deleteTargetUser) return;
    if (deleteTargetUser.id === currentUser?.id) {
      toast.error('Bạn không thể tự xóa tài khoản của chính mình!');
      setDeleteTargetUser(null);
      return;
    }
    if (deleteTargetUser.role === 'admin') {
      toast.error('Chỉ có thể xóa tài khoản Người dùng (role user). Không thể xóa tài khoản Quản trị viên!');
      setDeleteTargetUser(null);
      return;
    }

    setIsDeleting(true);
    try {
      await api.delete(`/admin/users/${deleteTargetUser.id}`);
      toast.success(`Đã xóa thành công tài khoản ${deleteTargetUser.full_name}`);
      setDeleteTargetUser(null);
      fetchUsers(meta.page, search);
    } catch (error) {
      const err = error as AxiosError<{ error: string }>;
      toast.error(err.response?.data?.error || 'Xóa tài khoản thất bại');
    } finally {
      setIsDeleting(false);
    }
  };

  return (
    <div className="p-6 max-w-7xl mx-auto">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-4 mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
            <Users size={24} className="text-orange-500" />
            Quản lý Người dùng
          </h1>
          <p className="text-gray-500 text-sm mt-1">
            Tổng số: <strong className="text-gray-800">{meta.total}</strong> tài khoản trong hệ thống
          </p>
        </div>
        <button
          onClick={() => setModalUser(null)} // null: tạo mới
          className="px-4 py-2.5 bg-orange-600 hover:bg-orange-700 text-white rounded-xl font-medium text-sm flex items-center gap-2 shadow-sm transition-all self-start sm:self-auto"
        >
          <Plus size={18} />
          <span>Thêm người dùng</span>
        </button>
      </div>

      {/* Filter & Search Bar (FR-05.2) */}
      <div className="bg-white rounded-2xl p-4 mb-6 border border-gray-100 shadow-sm flex items-center gap-3">
        <div className="relative flex-1">
          <Search size={18} className="absolute left-3.5 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            type="text"
            value={search}
            onChange={e => handleSearchChange(e.target.value)}
            placeholder="Tìm kiếm theo tên, email, username..."
            className="w-full pl-10 pr-4 py-2.5 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-orange-500 text-sm"
          />
          {search && (
            <button
              onClick={() => setSearch('')}
              className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
            >
              <X size={16} />
            </button>
          )}
        </div>
      </div>

      {/* Users Table (FR-05.1) */}
      <div className="bg-white rounded-2xl border border-gray-100 shadow-sm overflow-hidden mb-6">
        {isLoading ? (
          <div className="flex items-center justify-center py-20">
            <LoadingSpinner size="lg" />
          </div>
        ) : users.length === 0 ? (
          <div className="text-center py-16">
            <Users size={40} className="mx-auto text-gray-300 mb-3" />
            <p className="text-gray-500 font-medium">Không tìm thấy người dùng nào phù hợp</p>
            {search && (
              <button
                onClick={() => setSearch('')}
                className="mt-2 text-sm text-orange-600 hover:underline"
              >
                Xóa bộ lọc tìm kiếm
              </button>
            )}
          </div>
        ) : (
          <div className="overflow-x-auto">
            <table className="w-full text-left border-collapse">
              <thead>
                <tr className="bg-gray-50/80 border-b border-gray-100 text-xs font-semibold text-gray-500 uppercase tracking-wider">
                  <th className="py-3.5 px-4">Người dùng</th>
                  <th className="py-3.5 px-4">Tên đăng nhập</th>
                  <th className="py-3.5 px-4">Email</th>
                  <th className="py-3.5 px-4">Vai trò</th>
                  <th className="py-3.5 px-4">Trạng thái (FR-05.5)</th>
                  <th className="py-3.5 px-4">Ngày tạo</th>
                  <th className="py-3.5 px-4 text-right">Thao tác</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100 text-sm">
                {users.map(targetUser => {
                  const isSelf = targetUser.id === currentUser?.id;
                  const isAdminRole = targetUser.role === 'admin';

                  return (
                    <tr key={targetUser.id} className="hover:bg-gray-50/60 transition-colors">
                      {/* Full Name & Avatar */}
                      <td className="py-3.5 px-4">
                        <div className="flex items-center gap-3">
                          <div className={`w-9 h-9 rounded-full flex items-center justify-center text-white font-bold text-sm ${
                            isAdminRole ? 'bg-gradient-to-tr from-purple-600 to-indigo-600' : 'bg-gradient-to-tr from-orange-500 to-amber-500'
                          }`}>
                            {targetUser.full_name.charAt(0).toUpperCase()}
                          </div>
                          <div>
                            <p className="font-semibold text-gray-900 flex items-center gap-1.5">
                              {targetUser.full_name}
                              {isSelf && (
                                <span className="text-[10px] px-2 py-0.5 rounded-full bg-orange-100 text-orange-700 font-bold border border-orange-200">
                                  Bạn
                                </span>
                              )}
                            </p>
                          </div>
                        </div>
                      </td>

                      {/* Username */}
                      <td className="py-3.5 px-4 font-mono text-xs text-gray-600">
                        {targetUser.username}
                      </td>

                      {/* Email */}
                      <td className="py-3.5 px-4 text-gray-600">
                        {targetUser.email}
                      </td>

                      {/* Role Badge */}
                      <td className="py-3.5 px-4">
                        <span className={`inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-semibold ${
                          isAdminRole
                            ? 'bg-purple-100 text-purple-700 border border-purple-200'
                            : 'bg-blue-100 text-blue-700 border border-blue-200'
                        }`}>
                          {isAdminRole ? <Shield size={12} /> : <UserIcon size={12} />}
                          {isAdminRole ? 'Quản trị viên' : 'Người dùng'}
                        </span>
                      </td>

                      {/* Active / Inactive Status (FR-05.5) */}
                      <td className="py-3.5 px-4">
                        <button
                          onClick={() => handleToggleStatus(targetUser)}
                          disabled={isSelf}
                          className={`inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold transition-all ${
                            targetUser.is_active
                              ? 'bg-emerald-100 text-emerald-800 hover:bg-emerald-200'
                              : 'bg-rose-100 text-rose-800 hover:bg-rose-200'
                          } ${isSelf ? 'opacity-60 cursor-not-allowed' : 'cursor-pointer'}`}
                          title={isSelf ? 'Không thể tự đổi trạng thái của chính mình' : 'Nhấn để bật/tắt kích hoạt'}
                        >
                          {targetUser.is_active ? (
                            <>
                              <ToggleRight size={16} className="text-emerald-600" />
                              <span>Hoạt động</span>
                            </>
                          ) : (
                            <>
                              <ToggleLeft size={16} className="text-rose-600" />
                              <span>Vô hiệu hóa</span>
                            </>
                          )}
                        </button>
                      </td>

                      {/* Created Date */}
                      <td className="py-3.5 px-4 text-xs text-gray-500">
                        {new Date(targetUser.created_at).toLocaleDateString('vi-VN')}
                      </td>

                      {/* Actions */}
                      <td className="py-3.5 px-4 text-right">
                        <div className="flex items-center justify-end gap-1.5">
                          {/* FR-05.7: Đặt lại mật khẩu */}
                          <button
                            onClick={() => setResetPwdUser(targetUser)}
                            className="p-1.5 text-gray-500 hover:text-blue-600 hover:bg-blue-50 rounded-lg transition-colors"
                            title="Đặt lại mật khẩu (FR-05.7)"
                          >
                            <Key size={16} />
                          </button>

                          {/* FR-05.4: Sửa thông tin */}
                          <button
                            onClick={() => setModalUser(targetUser)}
                            className="p-1.5 text-gray-500 hover:text-orange-600 hover:bg-orange-50 rounded-lg transition-colors"
                            title="Chỉnh sửa thông tin (FR-05.4)"
                          >
                            <Pencil size={16} />
                          </button>

                          {/* FR-05.6: Xoá người dùng (chỉ role user, cấm xóa self & admin) */}
                          <button
                            onClick={() => setDeleteTargetUser(targetUser)}
                            disabled={isSelf || isAdminRole}
                            className={`p-1.5 rounded-lg transition-colors ${
                              isSelf || isAdminRole
                                ? 'text-gray-300 cursor-not-allowed'
                                : 'text-gray-500 hover:text-red-600 hover:bg-red-50 cursor-pointer'
                            }`}
                            title={
                              isSelf
                                ? 'Không thể xóa tài khoản của chính mình (FR-05.9)'
                                : isAdminRole
                                ? 'Không thể xóa tài khoản Admin (FR-05.6)'
                                : 'Xóa tài khoản người dùng (FR-05.6)'
                            }
                          >
                            <Trash2 size={16} />
                          </button>
                        </div>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        )}

        {/* Pagination Bar (FR-05.1) */}
        {!isLoading && meta.totalPages > 1 && (
          <div className="p-4 border-t border-gray-100 flex items-center justify-between text-sm text-gray-600">
            <div>
              Trang <strong>{meta.page}</strong> / <strong>{meta.totalPages}</strong> (Hiển thị {users.length}/{meta.total} người dùng)
            </div>
            <div className="flex items-center gap-2">
              <button
                onClick={() => fetchUsers(meta.page - 1, search)}
                disabled={meta.page <= 1}
                className="p-2 rounded-xl border border-gray-200 hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed"
                aria-label="Trang trước"
              >
                <ChevronLeft size={16} />
              </button>

              {Array.from({ length: meta.totalPages }, (_, i) => i + 1).map(p => (
                <button
                  key={p}
                  onClick={() => fetchUsers(p, search)}
                  className={`w-8 h-8 rounded-xl text-xs font-semibold transition-colors ${
                    p === meta.page
                      ? 'bg-orange-600 text-white'
                      : 'hover:bg-gray-100 text-gray-700'
                  }`}
                >
                  {p}
                </button>
              ))}

              <button
                onClick={() => fetchUsers(meta.page + 1, search)}
                disabled={meta.page >= meta.totalPages}
                className="p-2 rounded-xl border border-gray-200 hover:bg-gray-50 disabled:opacity-40 disabled:cursor-not-allowed"
                aria-label="Trang sau"
              >
                <ChevronRight size={16} />
              </button>
            </div>
          </div>
        )}
      </div>

      {/* Modal Thêm / Sửa người dùng */}
      {modalUser !== undefined && (
        <UserModal
          user={modalUser}
          onClose={() => setModalUser(undefined)}
          onSave={() => fetchUsers(meta.page, search)}
          currentUserId={currentUser?.id}
        />
      )}

      {/* Modal Đặt lại mật khẩu */}
      {resetPwdUser && (
        <ResetPasswordModal
          user={resetPwdUser}
          onClose={() => setResetPwdUser(null)}
        />
      )}

      {/* Modal Xác nhận xóa */}
      {deleteTargetUser && (
        <DeleteConfirmModal
          user={deleteTargetUser}
          onClose={() => setDeleteTargetUser(null)}
          onConfirm={handleDeleteUser}
          isLoading={isDeleting}
        />
      )}
    </div>
  );
}
