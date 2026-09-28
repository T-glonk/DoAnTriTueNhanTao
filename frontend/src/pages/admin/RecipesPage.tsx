import { useState, useEffect } from 'react';
import { 
  Utensils, Search, Plus, Trash2, Edit3, Eye, 
  Clock, Users, Flame, ChevronLeft, ChevronRight,
  Sparkles, RefreshCw,
  Layers, CheckCircle2, X
} from 'lucide-react';
import api from '../../lib/api';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import toast from 'react-hot-toast';


interface RecipeItem {
  id: string;
  name: string;
  description: string | null;
  image_url: string | null;
  cooking_time: number;
  difficulty: string;
  servings: string;
  category: string;
  source_url: string | null;
  author_name: string | null;
  created_at: string;
  ingredient_count: number;
  step_count: number;
}

interface RecipeDetail extends RecipeItem {
  ingredients: Array<{ raw_text: string; ingredient_name: string; quantity: string }>;
  steps: Array<{ step_number: number; instruction: string; step_image_url?: string }>;
  nutrition: {
    calories: number;
    protein: number;
    carbohydrates: number;
    fat: number;
    fiber: number;
    calcium?: number;
    iron?: number;
  } | null;
  tags: string[];
}

const CATEGORIES = [
  'Tất cả',
  'Món chính',
  'Súp/Canh',
  'Salad',
  'Ăn sáng',
  'Món phụ',
  'Món chay',
  'Tráng miệng'
];

export function RecipesPage() {
  const [recipes, setRecipes] = useState<RecipeItem[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('Tất cả');
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [totalRecipes, setTotalRecipes] = useState(0);

  // Modals state
  const [detailModalRecipe, setDetailModalRecipe] = useState<RecipeDetail | null>(null);
  const [isEditModalOpen, setIsEditModalOpen] = useState(false);
  const [editingRecipeId, setEditingRecipeId] = useState<string | null>(null);
  const [isDeletingId, setIsDeletingId] = useState<string | null>(null);

  // Form State
  const [formData, setFormData] = useState({
    name: '',
    description: '',
    image_url: '',
    cooking_time: 30,
    difficulty: 'Trung bình',
    servings: '2-4 người',
    category: 'Món chính',
    source_url: '',
    author_name: 'Admin FoodAI',
    ingredientsText: '',
    stepsText: '',
    calories: 350,
    protein: 20,
    carbs: 30,
    fat: 10,
    fiber: 4,
    tagsText: 'món ngon, dễ làm'
  });
  const [isSubmitting, setIsSubmitting] = useState(false);

  const fetchRecipes = async (currentPage = page, currentSearch = search, currentCat = selectedCategory) => {
    setIsLoading(true);
    try {
      const params = new URLSearchParams();
      params.append('page', currentPage.toString());
      params.append('limit', '12');
      if (currentSearch.trim()) params.append('search', currentSearch.trim());
      if (currentCat && currentCat !== 'Tất cả') params.append('category', currentCat);

      const res = await api.get(`/admin/recipes?${params.toString()}`);
      if (res.data.success) {
        setRecipes(res.data.data.recipes);
        setTotalPages(res.data.data.meta.totalPages);
        setTotalRecipes(res.data.data.meta.total);
      }
    } catch (err) {
      toast.error('Không thể tải danh sách món ăn');
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => {
    fetchRecipes(1, search, selectedCategory);
    setPage(1);
  }, [selectedCategory]);

  const handleSearchSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setPage(1);
    fetchRecipes(1, search, selectedCategory);
  };

  const handleOpenDetail = async (id: string) => {
    try {
      const res = await api.get(`/admin/recipes/${id}`);
      if (res.data.success) {
        setDetailModalRecipe(res.data.data.recipe);
      }
    } catch {
      toast.error('Không thể tải chi tiết món ăn');
    }
  };

  const handleOpenCreate = () => {
    setEditingRecipeId(null);
    setFormData({
      name: '',
      description: '',
      image_url: '',
      cooking_time: 30,
      difficulty: 'Trung bình',
      servings: '2-4 người',
      category: 'Món chính',
      source_url: '',
      author_name: 'Admin FoodAI',
      ingredientsText: '200g thịt bò\n1 củ cà rốt\n2 củ khoai tây\n1 củ hành tây\nGia vị: muối, tiêu, đường',
      stepsText: '1. Sơ chế sạch các loại nguyên liệu và cắt miếng vừa ăn.\n2. Ướp thịt bò cùng một ít muối tiêu và hành tỏi băm.\n3. Xào thịt bò cho săn lại rồi cho rau củ vào ninh mềm.\n4. Nêm nếm lại gia vị cho vừa miệng rồi tắt bếp.',
      calories: 350,
      protein: 22,
      carbs: 28,
      fat: 12,
      fiber: 4,
      tagsText: 'món ngon, bò, dễ làm'
    });
    setIsEditModalOpen(true);
  };

  const handleOpenEdit = async (id: string) => {
    setEditingRecipeId(id);
    try {
      const res = await api.get(`/admin/recipes/${id}`);
      if (res.data.success) {
        const r: RecipeDetail = res.data.data.recipe;
        
        const ingredientsText = (r.ingredients || [])
          .map(i => (i.quantity ? `${i.quantity} ${i.ingredient_name || i.raw_text}` : i.raw_text || i.ingredient_name))
          .join('\n');
          
        const stepsText = (r.steps || [])
          .map(s => `${s.step_number}. ${s.instruction}`)
          .join('\n');

        setFormData({
          name: r.name,
          description: r.description || '',
          image_url: r.image_url || '',
          cooking_time: r.cooking_time || 30,
          difficulty: r.difficulty || 'Trung bình',
          servings: r.servings || '2-4 người',
          category: r.category || 'Món chính',
          source_url: r.source_url || '',
          author_name: r.author_name || 'Admin FoodAI',
          ingredientsText: ingredientsText || '',
          stepsText: stepsText || '',
          calories: r.nutrition?.calories || 300,
          protein: r.nutrition?.protein || 15,
          carbs: r.nutrition?.carbohydrates || 25,
          fat: r.nutrition?.fat || 10,
          fiber: r.nutrition?.fiber || 3,
          tagsText: (r.tags || []).join(', ')
        });
        setIsEditModalOpen(true);
      }
    } catch {
      toast.error('Không thể tải thông tin món để chỉnh sửa');
    }
  };


  const handleSubmitForm = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.name.trim()) {
      toast.error('Vui lòng nhập tên món ăn');
      return;
    }

    setIsSubmitting(true);
    try {
      // Parse ingredients
      const ingredients = formData.ingredientsText
        .split('\n')
        .map(line => line.trim())
        .filter(Boolean)
        .map(line => ({ raw_text: line, ingredient_name: line, quantity: '' }));

      // Parse steps
      const steps = formData.stepsText
        .split('\n')
        .map(line => line.trim())
        .filter(Boolean)
        .map((line, idx) => {
          const cleanLine = line.replace(/^\d+[\.\:\)\-]\s*/, '');
          return { step_number: idx + 1, instruction: cleanLine, step_image_url: '' };
        });

      // Parse tags
      const tags = formData.tagsText
        .split(',')
        .map(t => t.trim())
        .filter(Boolean);

      const payload = {
        name: formData.name,
        description: formData.description,
        image_url: formData.image_url,
        cooking_time: Number(formData.cooking_time),
        difficulty: formData.difficulty,
        servings: formData.servings,
        category: formData.category,
        source_url: formData.source_url,
        author_name: formData.author_name,
        ingredients,
        steps,
        nutrition: {
          calories: Number(formData.calories) || 300,
          protein: Number(formData.protein) || 15,
          carbohydrates: Number(formData.carbs) || 25,
          fat: Number(formData.fat) || 10,
          fiber: Number(formData.fiber) || 3,
          calcium: 40,
          iron: 2
        },
        tags
      };

      if (editingRecipeId) {
        await api.put(`/admin/recipes/${editingRecipeId}`, payload);
        toast.success('Cập nhật món ăn thành công!');
      } else {
        await api.post('/admin/recipes', payload);
        toast.success('Thêm món mới vào kho thành công!');
      }

      setIsEditModalOpen(false);
      fetchRecipes(page, search, selectedCategory);
    } catch (err: any) {
      toast.error(err.response?.data?.error || 'Có lỗi xảy ra khi lưu món ăn');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleDeleteRecipe = async (id: string, name: string) => {
    if (!window.confirm(`Bạn có chắc chắn muốn xóa món "${name}" khỏi kho dữ liệu?`)) {
      return;
    }

    setIsDeletingId(id);
    try {
      await api.delete(`/admin/recipes/${id}`);
      toast.success(`Đã xóa món "${name}"`);
      fetchRecipes(page, search, selectedCategory);
    } catch {
      toast.error('Xóa món ăn thất bại');
    } finally {
      setIsDeletingId(null);
    }
  };

  return (
    <div className="p-6 max-w-7xl mx-auto space-y-6">
      {/* Header & Actions */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-gray-900 flex items-center gap-2">
            <Utensils size={24} className="text-orange-500" />
            Quản lý Kho Món Ăn & Ảnh Cookpad (MySQL)
          </h1>
          <p className="text-gray-500 text-sm mt-1">
            Kho dữ liệu lưu trữ công thức thực tế, định lượng nguyên liệu & ảnh CDN Cookpad phục vụ hệ thống AI
          </p>
        </div>
        <div className="flex items-center gap-3">
          <button
            onClick={() => fetchRecipes(page, search, selectedCategory)}
            className="p-2.5 bg-white border border-gray-200 text-gray-700 hover:bg-gray-50 rounded-xl flex items-center gap-2 text-sm font-medium shadow-sm transition-all"
            title="Làm mới dữ liệu"
          >
            <RefreshCw size={16} className={isLoading ? 'animate-spin' : ''} />
            Làm mới
          </button>
          <button
            onClick={handleOpenCreate}
            className="px-4 py-2.5 bg-gradient-to-r from-orange-500 to-amber-600 hover:from-orange-600 hover:to-amber-700 text-white font-medium rounded-xl flex items-center gap-2 text-sm shadow-sm transition-all"
          >
            <Plus size={18} />
            Thêm món mới
          </button>
        </div>
      </div>

      {/* Stats row */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
        <div className="bg-white p-4 rounded-2xl border border-gray-100 shadow-sm flex items-center gap-3">
          <div className="w-11 h-11 bg-orange-50 rounded-xl flex items-center justify-center text-orange-600">
            <Utensils size={20} />
          </div>
          <div>
            <p className="text-xs text-gray-500 font-medium">Tổng số món trong kho</p>
            <p className="text-xl font-bold text-gray-900">{totalRecipes}</p>
          </div>
        </div>

        <div className="bg-white p-4 rounded-2xl border border-gray-100 shadow-sm flex items-center gap-3">
          <div className="w-11 h-11 bg-emerald-50 rounded-xl flex items-center justify-center text-emerald-600">
            <CheckCircle2 size={20} />
          </div>
          <div>
            <p className="text-xs text-gray-500 font-medium">Nguồn ảnh Cookpad CDN</p>
            <p className="text-xl font-bold text-emerald-600">100% Khớp AI</p>
          </div>
        </div>

        <div className="bg-white p-4 rounded-2xl border border-gray-100 shadow-sm flex items-center gap-3">
          <div className="w-11 h-11 bg-blue-50 rounded-xl flex items-center justify-center text-blue-600">
            <Layers size={20} />
          </div>
          <div>
            <p className="text-xs text-gray-500 font-medium">Danh mục món ăn</p>
            <p className="text-xl font-bold text-gray-900">{CATEGORIES.length - 1} Loại</p>
          </div>
        </div>

        <div className="bg-white p-4 rounded-2xl border border-gray-100 shadow-sm flex items-center gap-3">
          <div className="w-11 h-11 bg-purple-50 rounded-xl flex items-center justify-center text-purple-600">
            <Sparkles size={20} />
          </div>
          <div>
            <p className="text-xs text-gray-500 font-medium">AI Matching Engine</p>
            <p className="text-xl font-bold text-purple-600">Active</p>
          </div>
        </div>
      </div>

      {/* Filter & Search Toolbar */}
      <div className="bg-white p-4 rounded-2xl border border-gray-100 shadow-sm space-y-3">
        <div className="flex flex-col md:flex-row gap-3">
          {/* Search bar */}
          <form onSubmit={handleSearchSubmit} className="flex-1 flex gap-2">
            <div className="relative flex-1">
              <Search size={18} className="absolute left-3.5 top-1/2 -translate-y-1/2 text-gray-400" />
              <input
                type="text"
                value={search}
                onChange={e => setSearch(e.target.value)}
                placeholder="Tìm theo tên món ăn, nguyên liệu, thịt bò, gà, cá..."
                className="w-full pl-10 pr-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-sm focus:outline-none focus:ring-2 focus:ring-orange-500/20 focus:border-orange-500 transition-all"
              />
            </div>
            <button
              type="submit"
              className="px-5 py-2.5 bg-gray-900 hover:bg-black text-white text-sm font-medium rounded-xl transition-all shadow-sm"
            >
              Tìm kiếm
            </button>
          </form>
        </div>

        {/* Category pills */}
        <div className="flex items-center gap-2 overflow-x-auto pb-1 pt-1 no-scrollbar">
          {CATEGORIES.map(cat => (
            <button
              key={cat}
              onClick={() => setSelectedCategory(cat)}
              className={`px-3.5 py-1.5 rounded-xl text-xs font-semibold whitespace-nowrap transition-all ${
                selectedCategory === cat
                  ? 'bg-orange-500 text-white shadow-sm shadow-orange-500/20'
                  : 'bg-gray-100 text-gray-600 hover:bg-gray-200'
              }`}
            >
              {cat}
            </button>
          ))}
        </div>
      </div>

      {/* Recipes Table / Cards Grid */}
      {isLoading ? (
        <div className="flex items-center justify-center h-64 bg-white rounded-2xl border border-gray-100">
          <LoadingSpinner size="lg" />
        </div>
      ) : recipes.length === 0 ? (
        <div className="bg-white rounded-2xl border border-gray-100 p-12 text-center">
          <div className="w-16 h-16 bg-orange-50 rounded-2xl flex items-center justify-center text-orange-500 mx-auto mb-3">
            <Utensils size={28} />
          </div>
          <h3 className="text-lg font-bold text-gray-800">Không tìm thấy món ăn nào</h3>
          <p className="text-gray-500 text-sm mt-1 max-w-md mx-auto">
            Không có kết quả khớp với từ khóa "{search}" trong danh mục "{selectedCategory}". Vui lòng thử tìm kiếm từ khóa khác hoặc thêm món mới.
          </p>
          <button
            onClick={() => { setSearch(''); setSelectedCategory('Tất cả'); fetchRecipes(1, '', 'Tất cả'); }}
            className="mt-4 px-4 py-2 bg-gray-100 hover:bg-gray-200 text-gray-700 text-sm font-medium rounded-xl transition-all"
          >
            Xóa bộ lọc
          </button>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-5">
          {recipes.map(recipe => (
            <div
              key={recipe.id}
              className="bg-white rounded-2xl border border-gray-100 overflow-hidden shadow-sm hover:shadow-md transition-all flex flex-col group"
            >
              {/* Image Banner */}
              <div className="relative h-44 bg-gray-100 overflow-hidden">
                <img
                  src={recipe.image_url || 'https://images.unsplash.com/photo-1547592180-85f173990554?w=600&auto=format&fit=crop&q=80'}
                  alt={recipe.name}
                  className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                  onError={(e: any) => {
                    const fallbacks = [
                      'https://images.unsplash.com/photo-1547592180-85f173990554?w=600&auto=format&fit=crop&q=80',
                      'https://images.unsplash.com/photo-1588168333986-5078d3ae3976?w=600&auto=format&fit=crop&q=80',
                      'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?w=600&auto=format&fit=crop&q=80',
                      'https://images.unsplash.com/photo-1562967914-608f82629710?w=600&auto=format&fit=crop&q=80',
                      'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=600&auto=format&fit=crop&q=80',
                      'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=600&auto=format&fit=crop&q=80'
                    ];
                    let h = 0;
                    for (let i = 0; i < recipe.name.length; i++) h = (h << 5) - h + recipe.name.charCodeAt(i);
                    e.target.src = fallbacks[Math.abs(h) % fallbacks.length];
                  }}
                />
                <div className="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent" />

                
                {/* Badges */}
                <div className="absolute top-3 left-3 flex items-center gap-1.5">
                  <span className="px-2.5 py-1 bg-black/60 backdrop-blur-md text-white text-xs font-semibold rounded-lg">
                    {recipe.category}
                  </span>
                  <span className="px-2.5 py-1 bg-orange-500/80 backdrop-blur-md text-white text-xs font-semibold rounded-lg">
                    {recipe.difficulty}
                  </span>
                </div>

                {recipe.image_url?.includes('cpcdn.com') && (
                  <div className="absolute top-3 right-3 px-2 py-0.5 bg-emerald-600/90 backdrop-blur-md text-white text-[11px] font-bold rounded-md flex items-center gap-1">
                    <span>Cookpad CDN</span>
                  </div>
                )}

                <div className="absolute bottom-3 left-3 right-3">
                  <h3 className="text-white font-bold text-base line-clamp-1 drop-shadow-sm">
                    {recipe.name}
                  </h3>
                </div>
              </div>

              {/* Info Body */}
              <div className="p-4 flex-1 flex flex-col justify-between space-y-3">
                <p className="text-xs text-gray-500 line-clamp-2">
                  {recipe.description || 'Công thức nấu món ngon từ cộng đồng Cookpad Việt Nam.'}
                </p>

                <div className="grid grid-cols-3 gap-2 py-2 border-y border-gray-50 text-xs text-gray-600">
                  <div className="flex items-center gap-1">
                    <Clock size={14} className="text-orange-500" />
                    <span>{recipe.cooking_time} phút</span>
                  </div>
                  <div className="flex items-center gap-1">
                    <Users size={14} className="text-blue-500" />
                    <span className="truncate">{recipe.servings}</span>
                  </div>
                  <div className="flex items-center gap-1">
                    <Layers size={14} className="text-emerald-500" />
                    <span>{recipe.ingredient_count} NL</span>
                  </div>
                </div>

                {/* Footer Controls */}
                <div className="flex items-center justify-between pt-1">
                  <span className="text-[11px] text-gray-400">
                    Tác giả: <strong className="text-gray-600">{recipe.author_name || 'Cookpad'}</strong>
                  </span>
                  
                  <div className="flex items-center gap-1.5">
                    <button
                      onClick={() => handleOpenDetail(recipe.id)}
                      className="p-2 hover:bg-gray-100 text-gray-600 rounded-lg transition-colors"
                      title="Xem chi tiết"
                    >
                      <Eye size={16} />
                    </button>
                    <button
                      onClick={() => handleOpenEdit(recipe.id)}
                      className="p-2 hover:bg-blue-50 text-blue-600 rounded-lg transition-colors"
                      title="Chỉnh sửa món"
                    >
                      <Edit3 size={16} />
                    </button>
                    <button
                      onClick={() => handleDeleteRecipe(recipe.id, recipe.name)}
                      disabled={isDeletingId === recipe.id}
                      className="p-2 hover:bg-rose-50 text-rose-600 rounded-lg transition-colors"
                      title="Xóa món khỏi hệ thống"
                    >
                      <Trash2 size={16} />
                    </button>
                  </div>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="flex items-center justify-between bg-white px-5 py-3.5 rounded-2xl border border-gray-100 shadow-sm">
          <p className="text-xs text-gray-500">
            Hiển thị trang <span className="font-bold text-gray-800">{page}</span> / <span className="font-bold text-gray-800">{totalPages}</span> ({totalRecipes} món)
          </p>
          <div className="flex items-center gap-2">
            <button
              onClick={() => {
                const prev = Math.max(1, page - 1);
                setPage(prev);
                fetchRecipes(prev, search, selectedCategory);
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
                fetchRecipes(next, search, selectedCategory);
              }}
              disabled={page >= totalPages}
              className="px-3 py-1.5 bg-gray-50 border border-gray-200 text-gray-700 hover:bg-gray-100 disabled:opacity-40 disabled:cursor-not-allowed rounded-xl text-xs font-semibold flex items-center gap-1 transition-all"
            >
              Sau <ChevronRight size={14} />
            </button>
          </div>
        </div>
      )}

      {/* DETAIL MODAL */}
      {detailModalRecipe && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-fade-in">
          <div className="bg-white rounded-3xl max-w-2xl w-full max-h-[90vh] overflow-y-auto shadow-2xl border border-gray-100 p-6 space-y-5">
            <div className="flex items-start justify-between">
              <div>
                <span className="px-2.5 py-1 bg-orange-100 text-orange-700 text-xs font-bold rounded-lg">
                  {detailModalRecipe.category}
                </span>
                <h2 className="text-2xl font-bold text-gray-900 mt-1">{detailModalRecipe.name}</h2>
                <p className="text-xs text-gray-400">Tác giả: {detailModalRecipe.author_name} | ID: {detailModalRecipe.id}</p>
              </div>
              <button
                onClick={() => setDetailModalRecipe(null)}
                className="p-2 hover:bg-gray-100 rounded-full text-gray-500"
              >
                <X size={20} />
              </button>
            </div>

            {/* Image Preview */}
            {detailModalRecipe.image_url && (
              <div className="h-56 rounded-2xl overflow-hidden bg-gray-100">
                <img
                  src={detailModalRecipe.image_url}
                  alt={detailModalRecipe.name}
                  className="w-full h-full object-cover"
                />
              </div>
            )}

            {/* Basic stats */}
            <div className="grid grid-cols-4 gap-3 bg-gray-50 p-3.5 rounded-2xl text-center text-xs">
              <div>
                <span className="text-gray-400 block">Thời gian</span>
                <strong className="text-gray-800 text-sm">{detailModalRecipe.cooking_time}p</strong>
              </div>
              <div>
                <span className="text-gray-400 block">Khẩu phần</span>
                <strong className="text-gray-800 text-sm">{detailModalRecipe.servings}</strong>
              </div>
              <div>
                <span className="text-gray-400 block">Độ khó</span>
                <strong className="text-gray-800 text-sm">{detailModalRecipe.difficulty}</strong>
              </div>
              <div>
                <span className="text-gray-400 block">Calo ước tính</span>
                <strong className="text-orange-600 text-sm">{detailModalRecipe.nutrition?.calories || 300} kcal</strong>
              </div>
            </div>

            {/* Ingredients */}
            <div>
              <h4 className="font-bold text-gray-900 text-sm mb-2 flex items-center gap-1.5">
                <Layers size={16} className="text-orange-500" />
                Nguyên liệu ({detailModalRecipe.ingredients?.length || 0})
              </h4>
              <div className="grid grid-cols-2 gap-2">
                {detailModalRecipe.ingredients?.map((ing, i) => (
                  <div key={i} className="p-2 bg-orange-50/50 border border-orange-100/80 rounded-xl text-xs flex justify-between">
                    <span className="font-medium text-gray-800">{ing.ingredient_name || ing.raw_text}</span>
                    <span className="text-gray-500">{ing.quantity}</span>
                  </div>
                ))}
              </div>
            </div>

            {/* Steps */}
            <div>
              <h4 className="font-bold text-gray-900 text-sm mb-2 flex items-center gap-1.5">
                <Flame size={16} className="text-orange-500" />
                Các bước thực hiện ({detailModalRecipe.steps?.length || 0})
              </h4>
              <div className="space-y-2">
                {detailModalRecipe.steps?.map(step => (
                  <div key={step.step_number} className="p-3 bg-gray-50 rounded-xl text-xs space-y-1">
                    <strong className="text-orange-600 block font-bold">Bước {step.step_number}:</strong>
                    <p className="text-gray-700 leading-relaxed">{step.instruction}</p>
                  </div>
                ))}
              </div>
            </div>

            {/* Actions */}
            <div className="flex items-center justify-end gap-2 pt-3 border-t">
              <button
                onClick={() => {
                  const id = detailModalRecipe.id;
                  setDetailModalRecipe(null);
                  handleOpenEdit(id);
                }}
                className="px-4 py-2 bg-blue-50 text-blue-700 hover:bg-blue-100 rounded-xl text-xs font-semibold"
              >
                Chỉnh sửa món này
              </button>
              <button
                onClick={() => setDetailModalRecipe(null)}
                className="px-4 py-2 bg-gray-900 text-white rounded-xl text-xs font-semibold"
              >
                Đóng
              </button>
            </div>
          </div>
        </div>
      )}

      {/* CREATE / EDIT MODAL */}
      {isEditModalOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-fade-in">
          <div className="bg-white rounded-3xl max-w-2xl w-full max-h-[92vh] overflow-y-auto shadow-2xl border border-gray-100 p-6 space-y-4">
            <div className="flex items-center justify-between pb-3 border-b">
              <h2 className="text-xl font-bold text-gray-900 flex items-center gap-2">
                {editingRecipeId ? <Edit3 size={20} className="text-blue-600" /> : <Plus size={20} className="text-orange-600" />}
                {editingRecipeId ? 'Chỉnh sửa món ăn Cookpad' : 'Thêm món ăn mới vào kho'}
              </h2>
              <button
                onClick={() => setIsEditModalOpen(false)}
                className="p-1.5 hover:bg-gray-100 rounded-full text-gray-500"
              >
                <X size={18} />
              </button>
            </div>

            <form onSubmit={handleSubmitForm} className="space-y-4 text-xs">
              {/* Name & Category */}
              <div className="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <div>
                  <label className="block text-gray-700 font-semibold mb-1">Tên món ăn (*)</label>
                  <input
                    type="text"
                    required
                    value={formData.name}
                    onChange={e => setFormData({ ...formData, name: e.target.value })}
                    placeholder="Ví dụ: Thịt bò xào hành cần tây"
                    className="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-orange-500/20 focus:border-orange-500 focus:outline-none"
                  />
                </div>
                <div>
                  <label className="block text-gray-700 font-semibold mb-1">Danh mục</label>
                  <select
                    value={formData.category}
                    onChange={e => setFormData({ ...formData, category: e.target.value })}
                    className="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-orange-500/20 focus:border-orange-500 focus:outline-none"
                  >
                    {CATEGORIES.filter(c => c !== 'Tất cả').map(c => (
                      <option key={c} value={c}>{c}</option>
                    ))}
                  </select>
                </div>
              </div>

              {/* Image URL & Preview */}
              <div>
                <label className="block text-gray-700 font-semibold mb-1">Link hình ảnh (CDN Cookpad / URL ảnh)</label>
                <input
                  type="url"
                  value={formData.image_url}
                  onChange={e => setFormData({ ...formData, image_url: e.target.value })}
                  placeholder="https://img-global.cpcdn.com/recipes/..."
                  className="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-orange-500/20 focus:border-orange-500 focus:outline-none"
                />
                {formData.image_url && (
                  <div className="mt-2 h-28 w-44 rounded-xl overflow-hidden bg-gray-100 border">
                    <img
                      src={formData.image_url}
                      alt="Preview"
                      className="w-full h-full object-cover"
                      onError={(e: any) => { e.target.style.display = 'none'; }}
                    />
                  </div>
                )}
              </div>

              {/* Cooking time, difficulty, servings */}
              <div className="grid grid-cols-3 gap-3">
                <div>
                  <label className="block text-gray-700 font-semibold mb-1">Thời gian nấu (phút)</label>
                  <input
                    type="number"
                    min={5}
                    max={360}
                    value={formData.cooking_time}
                    onChange={e => setFormData({ ...formData, cooking_time: Number(e.target.value) })}
                    className="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-orange-500/20 focus:border-orange-500 focus:outline-none"
                  />
                </div>
                <div>
                  <label className="block text-gray-700 font-semibold mb-1">Độ khó</label>
                  <select
                    value={formData.difficulty}
                    onChange={e => setFormData({ ...formData, difficulty: e.target.value })}
                    className="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-orange-500/20 focus:border-orange-500 focus:outline-none"
                  >
                    <option value="Dễ">Dễ</option>
                    <option value="Trung bình">Trung bình</option>
                    <option value="Khó">Khó</option>
                  </select>
                </div>
                <div>
                  <label className="block text-gray-700 font-semibold mb-1">Khẩu phần</label>
                  <input
                    type="text"
                    value={formData.servings}
                    onChange={e => setFormData({ ...formData, servings: e.target.value })}
                    placeholder="2-4 người"
                    className="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-orange-500/20 focus:border-orange-500 focus:outline-none"
                  />
                </div>
              </div>

              {/* Ingredients input */}
              <div>
                <label className="block text-gray-700 font-semibold mb-1">
                  Danh sách nguyên liệu (Mỗi dòng một nguyên liệu kèm định lượng)
                </label>
                <textarea
                  rows={4}
                  value={formData.ingredientsText}
                  onChange={e => setFormData({ ...formData, ingredientsText: e.target.value })}
                  placeholder="Ví dụ:&#10;300g thịt heo ba chỉ&#10;2 quả trứng gà&#10;1 củ hành tím băm&#10;Gia vị: Nước mắm, tiêu, đường"
                  className="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl font-mono focus:ring-2 focus:ring-orange-500/20 focus:border-orange-500 focus:outline-none"
                />
              </div>

              {/* Steps input */}
              <div>
                <label className="block text-gray-700 font-semibold mb-1">
                  Các bước chế biến (Mỗi dòng một bước)
                </label>
                <textarea
                  rows={4}
                  value={formData.stepsText}
                  onChange={e => setFormData({ ...formData, stepsText: e.target.value })}
                  placeholder="Ví dụ:&#10;1. Sơ chế sạch nguyên liệu và thái miếng vừa ăn.&#10;2. Ướp thịt với gia vị trong 15 phút.&#10;3. Bật bếp nấu đến khi chín mềm."
                  className="w-full px-3.5 py-2.5 bg-gray-50 border border-gray-200 rounded-xl font-mono focus:ring-2 focus:ring-orange-500/20 focus:border-orange-500 focus:outline-none"
                />
              </div>

              {/* Nutrition Inputs */}
              <div>
                <label className="block text-gray-700 font-semibold mb-1">Dinh dưỡng ước lượng</label>
                <div className="grid grid-cols-5 gap-2 bg-gray-50 p-2.5 rounded-xl">
                  <div>
                    <span className="text-[10px] text-gray-500">Calo (kcal)</span>
                    <input
                      type="number"
                      value={formData.calories}
                      onChange={e => setFormData({ ...formData, calories: Number(e.target.value) })}
                      className="w-full p-1.5 bg-white border rounded text-xs text-center"
                    />
                  </div>
                  <div>
                    <span className="text-[10px] text-gray-500">Protein (g)</span>
                    <input
                      type="number"
                      value={formData.protein}
                      onChange={e => setFormData({ ...formData, protein: Number(e.target.value) })}
                      className="w-full p-1.5 bg-white border rounded text-xs text-center"
                    />
                  </div>
                  <div>
                    <span className="text-[10px] text-gray-500">Carbs (g)</span>
                    <input
                      type="number"
                      value={formData.carbs}
                      onChange={e => setFormData({ ...formData, carbs: Number(e.target.value) })}
                      className="w-full p-1.5 bg-white border rounded text-xs text-center"
                    />
                  </div>
                  <div>
                    <span className="text-[10px] text-gray-500">Fat (g)</span>
                    <input
                      type="number"
                      value={formData.fat}
                      onChange={e => setFormData({ ...formData, fat: Number(e.target.value) })}
                      className="w-full p-1.5 bg-white border rounded text-xs text-center"
                    />
                  </div>
                  <div>
                    <span className="text-[10px] text-gray-500">Chất xơ (g)</span>
                    <input
                      type="number"
                      value={formData.fiber}
                      onChange={e => setFormData({ ...formData, fiber: Number(e.target.value) })}
                      className="w-full p-1.5 bg-white border rounded text-xs text-center"
                    />
                  </div>
                </div>
              </div>

              {/* Tags and Description */}
              <div className="grid grid-cols-2 gap-3">
                <div>
                  <label className="block text-gray-700 font-semibold mb-1">Tags (cách nhau bởi dấu phẩy)</label>
                  <input
                    type="text"
                    value={formData.tagsText}
                    onChange={e => setFormData({ ...formData, tagsText: e.target.value })}
                    placeholder="món ngon, nhanh, kho, canh"
                    className="w-full px-3 py-2 bg-gray-50 border rounded-xl"
                  />
                </div>
                <div>
                  <label className="block text-gray-700 font-semibold mb-1">Mô tả ngắn</label>
                  <input
                    type="text"
                    value={formData.description}
                    onChange={e => setFormData({ ...formData, description: e.target.value })}
                    placeholder="Công thức truyền thống gia đình..."
                    className="w-full px-3 py-2 bg-gray-50 border rounded-xl"
                  />
                </div>
              </div>

              {/* Submit Buttons */}
              <div className="flex items-center justify-end gap-3 pt-3 border-t">
                <button
                  type="button"
                  onClick={() => setIsEditModalOpen(false)}
                  className="px-4 py-2.5 bg-gray-100 hover:bg-gray-200 text-gray-700 rounded-xl font-medium"
                >
                  Hủy
                </button>
                <button
                  type="submit"
                  disabled={isSubmitting}
                  className="px-5 py-2.5 bg-orange-600 hover:bg-orange-700 text-white rounded-xl font-semibold shadow-sm flex items-center gap-2"
                >
                  {isSubmitting && <RefreshCw size={14} className="animate-spin" />}
                  {editingRecipeId ? 'Cập nhật món ăn' : 'Lưu vào hệ thống'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
