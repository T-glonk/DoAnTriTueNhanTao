import { useState, useEffect, KeyboardEvent } from 'react';
import { Link } from 'react-router-dom';
import { Search, Plus, X, Sparkles, ChefHat, Lightbulb, RotateCcw, Shield } from 'lucide-react';
import toast from 'react-hot-toast';
import { useAuth } from '../../context/AuthContext';
import { RecipeCard } from '../../components/ui/RecipeCard';
import { RecipeModal } from '../../components/ui/RecipeModal';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import api from '../../lib/api';
import { Recipe } from '../../types';
import { AxiosError } from 'axios';

const SUGGESTED_INGREDIENTS = [
  'Thịt heo', 'Thịt bò', 'Thịt gà', 'Tôm', 'Trứng', 'Cà chua', 'Hành tây', 'Cá hồi',
  'Đậu phụ', 'Nấm', 'Măng', 'Lá lốt', 'Tía tô', 'Bí ngòi', 'Đậu bắp', 'Ếch', 'Lươn'
];

const EXAMPLE_COMBOS = [
  { label: '🥩 Thịt bò + Cà chua + Hành tây', ingredients: ['Thịt bò', 'Cà chua', 'Hành tây'] },
  { label: '🥚 Trứng + Cà chua + Hành lá', ingredients: ['Trứng', 'Cà chua', 'Hành lá'] },
  { label: '🍗 Thịt gà + Nấm + Gừng', ingredients: ['Thịt gà', 'Nấm', 'Gừng'] },
  { label: '🦐 Tôm + Đậu bắp + Cà chua', ingredients: ['Tôm', 'Đậu bắp', 'Cà chua'] },
  { label: '🥬 Đậu phụ + Cà chua + Nấm', ingredients: ['Đậu phụ', 'Cà chua', 'Nấm'] },
  { label: '🐸 Ếch + Măng cay', ingredients: ['Ếch', 'Măng cay'] },
  { label: '🐍 Lươn + Chuối xanh', ingredients: ['Lươn', 'Chuối xanh'] },
  { label: '🐚 Ốc + Lá lốt', ingredients: ['Ốc', 'Lá lốt'] },
];

export function HomePage() {
  const { user } = useAuth();
  const [ingredients, setIngredients] = useState<string[]>([]);
  const [inputValue, setInputValue] = useState('');
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [favorites, setFavorites] = useState<Set<string>>(new Set());
  const [isLoading, setIsLoading] = useState(false);
  const [selectedRecipe, setSelectedRecipe] = useState<Recipe | null>(null);
  const [hasSearched, setHasSearched] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const ITEMS_PER_PAGE = 3;

  // Lấy nguyên liệu từ trang lịch sử nếu có
  useEffect(() => {
    const saved = sessionStorage.getItem('reuse_ingredients');
    if (saved) {
      const ings = JSON.parse(saved) as string[];
      setIngredients(ings);
      sessionStorage.removeItem('reuse_ingredients');
    }
  }, []);

  const addIngredient = (value: string) => {
    const trimmed = value.trim();
    if (!trimmed) return;
    if (ingredients.map(i => i.toLowerCase()).includes(trimmed.toLowerCase())) {
      toast.error('Nguyên liệu đã có trong danh sách');
      return;
    }
    if (ingredients.length >= 15) {
      toast.error('Tối đa 15 nguyên liệu');
      return;
    }
    setIngredients(prev => [...prev, trimmed]);
    setInputValue('');
  };

  const handleKeyDown = (e: KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter' || e.key === ',') {
      e.preventDefault();
      addIngredient(inputValue);
    }
  };

  const removeIngredient = (ing: string) => {
    setIngredients(prev => prev.filter(i => i !== ing));
  };

  const useCombo = (combo: string[]) => {
    setIngredients(combo);
    setInputValue('');
  };

  const handleSuggest = async () => {
    if (ingredients.length === 0) {
      toast.error('Vui lòng thêm ít nhất 1 nguyên liệu');
      return;
    }

    setIsLoading(true);
    setHasSearched(true);
    setRecipes([]);
    setCurrentPage(1);

    try {
      const response = await api.post<{
        success: boolean;
        data: { recipes: Recipe[]; source: 'ai' | 'fallback' | 'database' | 'hybrid'; ai_enabled: boolean };
      }>('/recipes/suggest', { 
        ingredients,
        mode: 'ai',
      });

      const { recipes: newRecipes } = response.data.data;
      setRecipes(newRecipes);

      if (newRecipes.length > 0) {
        toast.success(`🤖 Trí tuệ nhân tạo Gemini AI đã sáng tạo ${newRecipes.length} món ăn phù hợp!`);
      } else {
        toast.error('Không tìm thấy món ăn phù hợp với các nguyên liệu này.');
      }
    } catch (error) {
      const err = error as AxiosError<{ error: string }>;
      toast.error(err.response?.data?.error || 'Không thể gợi ý món ăn. Vui lòng thử lại!');
    } finally {
      setIsLoading(false);
    }
  };

  const handleFavorite = async (recipe: Recipe) => {
    if (!user) {
      toast.error('Vui lòng đăng nhập để lưu món ăn yêu thích!');
      return;
    }

    const isFav = favorites.has(recipe.id);

    if (isFav) {
      setFavorites(prev => { const n = new Set(prev); n.delete(recipe.id); return n; });
      toast.success('Đã xóa khỏi yêu thích');
      return;
    }

    try {
      await api.post('/recipes/favorites', { recipe });
      setFavorites(prev => new Set([...prev, recipe.id]));
      toast.success('❤️ Đã thêm vào yêu thích!');
    } catch (error) {
      const err = error as AxiosError<{ error: string }>;
      if (err.response?.status === 409) {
        toast.error('Món ăn đã có trong yêu thích');
      } else {
        toast.error('Không thể thêm vào yêu thích');
      }
    }
  };

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Hero / Search Section */}
      <div className="bg-gradient-to-br from-orange-500 via-orange-600 to-amber-600 text-white relative overflow-hidden">
        {/* Decorative background glow */}
        <div className="absolute top-0 right-0 w-96 h-96 bg-white/10 rounded-full blur-3xl pointer-events-none -mr-20 -mt-20" />
        <div className="absolute bottom-0 left-0 w-80 h-80 bg-purple-500/20 rounded-full blur-3xl pointer-events-none -ml-20 -mb-20" />

        <div className="max-w-4xl mx-auto px-4 sm:px-6 py-10 relative z-10">
          {/* Admin Switch Banner */}
          {user?.role === 'admin' && (
            <div className="mb-6 p-4 bg-gray-900/90 backdrop-blur-md rounded-2xl border border-orange-400/40 flex flex-col sm:flex-row items-center justify-between gap-3 shadow-lg">
              <div className="flex items-center gap-3">
                <div className="w-9 h-9 bg-orange-500 rounded-xl flex items-center justify-center text-white flex-shrink-0">
                  <Shield size={20} />
                </div>
                <div>
                  <p className="text-sm font-semibold text-white">Bạn đang đăng nhập với tư cách Quản trị viên</p>
                  <p className="text-xs text-orange-200">Quản lý người dùng, kho món ăn Cookpad, lịch sử AI và thống kê</p>
                </div>
              </div>
              <Link
                to="/admin"
                className="px-4 py-2 bg-gradient-to-r from-orange-500 to-amber-500 hover:from-orange-600 hover:to-amber-600 text-white rounded-xl text-xs font-bold transition-all shadow-md flex-shrink-0 flex items-center gap-1.5"
              >
                <span>Mở Trang Quản Trị</span>
                <span>→</span>
              </Link>
            </div>
          )}

          {/* Greeting */}
          <div className="flex items-center gap-3 mb-2">
            <ChefHat size={28} className="text-amber-200" />
            <h1 className="text-2xl sm:text-3xl font-bold">
              Xin chào, {user?.full_name || 'bạn'}! 👋
            </h1>
          </div>
          <p className="text-orange-100 text-sm sm:text-base mb-4">
            Ứng dụng <strong>Trí Tuệ Nhân Tạo (AI)</strong> để phân tích nguyên liệu bạn có sẵn, sáng tạo công thức và tư vấn dinh dưỡng chi tiết.
          </p>

          {/* AI Badge indicator */}
          <div className="inline-flex items-center gap-2 px-4 py-1.5 rounded-full text-xs font-semibold mb-5 bg-white/20 backdrop-blur-md text-white border border-white/30 shadow-xs">
            <Sparkles size={14} className="text-amber-200" />
            <span>Động cơ AI: Google Gemini AI (AI Chef & Nutritionist)</span>
          </div>

          {/* Search card */}
          <div className="bg-white rounded-3xl p-4 sm:p-5 shadow-xl text-gray-800 border border-white/20">
            {/* Selected ingredient chips */}
            {ingredients.length > 0 && (
              <div className="flex flex-wrap gap-2 mb-3">
                {ingredients.map(ing => (
                  <span
                    key={ing}
                    className="flex items-center gap-1.5 bg-orange-100 text-orange-700 px-3 py-1.5 rounded-full text-sm font-medium animate-fade-in"
                  >
                    {ing}
                    <button
                      onClick={() => removeIngredient(ing)}
                      className="hover:text-red-500 transition-colors ml-0.5"
                      aria-label={`Xóa ${ing}`}
                    >
                      <X size={13} />
                    </button>
                  </span>
                ))}
                <button
                  onClick={() => setIngredients([])}
                  className="text-xs text-gray-400 hover:text-red-500 transition-colors px-2 py-1"
                >
                  Xóa tất cả
                </button>
              </div>
            )}

            {/* Input row */}
            <div className="flex gap-2">
              <div className="flex-1 relative">
                <Search size={17} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
                <input
                  type="text"
                  value={inputValue}
                  onChange={e => setInputValue(e.target.value)}
                  onKeyDown={handleKeyDown}
                  className="w-full pl-10 pr-4 py-3.5 border border-gray-200 rounded-2xl focus:outline-none focus:ring-2 focus:ring-orange-400 text-gray-800 text-sm"
                  placeholder="Nhập nguyên liệu bạn có (vd: Thịt bò, Cà chua, Trứng...) rồi nhấn Enter..."
                />
              </div>
              <button
                onClick={() => addIngredient(inputValue)}
                disabled={!inputValue.trim()}
                className="p-3.5 bg-orange-100 text-orange-600 hover:bg-orange-200 rounded-2xl transition-colors disabled:opacity-40 disabled:cursor-not-allowed flex-shrink-0"
                aria-label="Thêm nguyên liệu"
              >
                <Plus size={20} />
              </button>
              <button
                onClick={() => handleSuggest()}
                disabled={isLoading || ingredients.length === 0}
                className="flex items-center gap-2 px-6 py-3.5 bg-gradient-to-r from-orange-500 via-orange-600 to-amber-600 text-white rounded-2xl font-bold hover:opacity-95 transition-opacity disabled:opacity-50 disabled:cursor-not-allowed shadow-md flex-shrink-0"
              >
                {isLoading ? (
                  <LoadingSpinner size="sm" color="text-white" />
                ) : (
                  <Sparkles size={18} />
                )}
                <span className="hidden sm:inline text-sm">
                  {isLoading ? 'AI đang phân tích...' : 'Gợi ý món ăn AI'}
                </span>
              </button>
            </div>

            {/* Quick add suggestions */}
            <div className="mt-3.5 border-t border-gray-100 pt-3">
              <p className="text-xs text-gray-400 mb-2 flex items-center gap-1">
                <Lightbulb size={12} className="text-amber-500" /> Thêm nhanh nguyên liệu phổ biến:
              </p>
              <div className="flex flex-wrap gap-1.5">
                {SUGGESTED_INGREDIENTS
                  .filter(ing => !ingredients.map(i => i.toLowerCase()).includes(ing.toLowerCase()))
                  .slice(0, 10)
                  .map(ing => (
                    <button
                      key={ing}
                      onClick={() => addIngredient(ing)}
                      className="text-xs px-3 py-1 bg-gray-100 text-gray-600 rounded-full hover:bg-orange-100 hover:text-orange-600 transition-colors"
                    >
                      + {ing}
                    </button>
                  ))}
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Main content */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 py-8">

        {/* Loading state */}
        {isLoading && (
          <div className="flex flex-col items-center justify-center py-20 animate-fade-in">
            <div className="relative w-24 h-24 mb-6">
              <div className="absolute inset-0 border-4 border-purple-200 rounded-full animate-ping opacity-30" />
              <div className="absolute inset-0 border-4 border-orange-300 rounded-full" />
              <div className="absolute inset-0 border-4 border-purple-600 rounded-full animate-spin border-t-transparent" />
              <div className="absolute inset-0 flex items-center justify-center text-4xl">
                🤖
              </div>
            </div>
            <p className="text-gray-800 font-bold text-lg text-center">
              Trí tuệ nhân tạo Gemini AI đang phân tích nguyên liệu...
            </p>
            <p className="text-gray-500 text-sm mt-1.5 text-center max-w-md">
              Đầu bếp AI đang sáng tạo công thức tối ưu, tính toán chỉ số dinh dưỡng và chuẩn bị mẹo chế biến cho bạn.
            </p>
          </div>
        )}

        {/* Results */}
        {!isLoading && recipes.length > 0 && (() => {
          const totalPages = Math.ceil(recipes.length / ITEMS_PER_PAGE);
          const startIndex = (currentPage - 1) * ITEMS_PER_PAGE;
          const currentRecipes = recipes.slice(startIndex, startIndex + ITEMS_PER_PAGE);

          return (
            <div id="recipe-results-section" className="animate-fade-in scroll-mt-6">
              {/* Result header */}
              <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 mb-6 p-4 sm:p-5 bg-white rounded-3xl shadow-xs border border-gray-100">
                <div>
                  <h2 className="text-xl font-bold text-gray-900 flex items-center gap-2">
                    <Sparkles className="text-purple-600" size={22} />
                    <span>Món ăn được sáng tạo bởi Trí Tuệ Nhân Tạo ({recipes.length} món)</span>
                  </h2>
                  
                  <div className="flex flex-wrap items-center gap-2 mt-1.5">
                    <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold bg-purple-100 text-purple-800 border border-purple-200">
                      <Sparkles size={12} className="text-purple-600" />
                      Google Gemini AI (AI Chef & Nutritionist)
                    </span>
                    <span className="text-xs text-gray-400">• Nguyên liệu có sẵn: {ingredients.join(', ')}</span>
                    {totalPages > 1 && (
                      <span className="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold bg-orange-100 text-orange-700">
                        Trang {currentPage} / {totalPages} (3 món/trang)
                      </span>
                    )}
                  </div>
                </div>

                <button
                  onClick={() => handleSuggest()}
                  className="btn-secondary text-sm flex items-center gap-1.5 self-start sm:self-auto hover:border-orange-300"
                >
                  <RotateCcw size={14} />
                  <span>Gợi ý lại</span>
                </button>
              </div>

              {/* Recipe Grid: hiển thị 3 món trên trang hiện tại */}
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-3 gap-6">
                {currentRecipes.map(recipe => (
                  <RecipeCard
                    key={recipe.id}
                    recipe={recipe}
                    onFavorite={handleFavorite}
                    isFavorite={favorites.has(recipe.id)}
                    onViewDetail={setSelectedRecipe}
                  />
                ))}
              </div>

              {/* Thanh cuộn / Chuyển trang (Hiển thị 3 món đầu, chuyển trang để xem các món còn lại) */}
              {totalPages > 1 && (
                <div className="mt-8 p-4 sm:p-5 bg-white rounded-3xl border border-gray-100 shadow-sm flex flex-col sm:flex-row items-center justify-between gap-4">
                  <div className="text-sm text-gray-600 flex items-center gap-2">
                    <span className="w-2.5 h-2.5 rounded-full bg-orange-500 animate-pulse flex-shrink-0" />
                    <span>
                      Đang xem món <strong>{startIndex + 1} - {Math.min(startIndex + ITEMS_PER_PAGE, recipes.length)}</strong> trên tổng số <strong>{recipes.length} món</strong>
                    </span>
                  </div>

                  <div className="flex items-center gap-2 flex-wrap justify-center">
                    <button
                      onClick={() => {
                        setCurrentPage(prev => Math.max(1, prev - 1));
                        document.getElementById('recipe-results-section')?.scrollIntoView({ behavior: 'smooth' });
                      }}
                      disabled={currentPage === 1}
                      className="px-4 py-2 rounded-xl text-sm font-semibold border border-gray-200 text-gray-700 hover:bg-orange-50 hover:text-orange-600 hover:border-orange-300 transition-all disabled:opacity-30 disabled:cursor-not-allowed flex items-center gap-1.5 cursor-pointer"
                    >
                      ← Trang trước
                    </button>

                    {/* Nút số trang */}
                    <div className="flex items-center gap-1.5">
                      {Array.from({ length: totalPages }).map((_, idx) => {
                        const pageNum = idx + 1;
                        const isAct = pageNum === currentPage;
                        return (
                          <button
                            key={pageNum}
                            onClick={() => {
                              setCurrentPage(pageNum);
                              document.getElementById('recipe-results-section')?.scrollIntoView({ behavior: 'smooth' });
                            }}
                            className={`min-w-9 h-9 px-3 rounded-xl text-sm font-bold transition-all flex items-center justify-center cursor-pointer ${
                              isAct
                                ? 'bg-gradient-to-r from-orange-500 to-amber-500 text-white shadow-md shadow-orange-500/20'
                                : 'bg-gray-100 text-gray-600 hover:bg-orange-100 hover:text-orange-600'
                            }`}
                          >
                            Trang {pageNum}
                          </button>
                        );
                      })}
                    </div>

                    <button
                      onClick={() => {
                        setCurrentPage(prev => Math.min(totalPages, prev + 1));
                        document.getElementById('recipe-results-section')?.scrollIntoView({ behavior: 'smooth' });
                      }}
                      disabled={currentPage === totalPages}
                      className="px-4 py-2 rounded-xl text-sm font-semibold bg-gradient-to-r from-orange-500 to-amber-500 text-white hover:opacity-95 shadow-md shadow-orange-500/20 transition-all disabled:opacity-30 disabled:cursor-not-allowed flex items-center gap-1.5 cursor-pointer"
                    >
                      <span>Trang tiếp theo ({Math.max(0, recipes.length - startIndex - currentRecipes.length)} món)</span>
                      <span>→</span>
                    </button>
                  </div>
                </div>
              )}
            </div>
          );
        })()}

        {/* Empty state: before search */}
        {!isLoading && !hasSearched && (
          <div className="py-10">
            <div className="text-center max-w-2xl mx-auto mb-8">
              <h2 className="text-xl font-bold text-gray-800 mb-2 flex items-center justify-center gap-2">
                <Sparkles size={20} className="text-purple-600" />
                Gợi ý combo nguyên liệu phổ biến
              </h2>
              <p className="text-gray-500 text-sm">
                Chọn nhanh một trong các combo dưới đây để trải nghiệm khả năng phân tích và sáng tạo món ăn của AI
              </p>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 max-w-5xl mx-auto">
              {EXAMPLE_COMBOS.map(combo => (
                <button
                  key={combo.label}
                  onClick={() => useCombo(combo.ingredients)}
                  className="card p-4 text-left hover:border-purple-300 hover:shadow-md transition-all group bg-white border border-gray-100 rounded-2xl"
                >
                  <p className="font-semibold text-gray-800 text-sm group-hover:text-purple-600 transition-colors mb-1">
                    {combo.label}
                  </p>
                  <p className="text-xs text-gray-400 mb-3">
                    {combo.ingredients.join(', ')}
                  </p>
                  <span className="text-xs text-purple-600 font-semibold inline-flex items-center gap-1 group-hover:translate-x-0.5 transition-transform">
                    Dùng combo này →
                  </span>
                </button>
              ))}
            </div>
          </div>
        )}

        {/* Empty state: searched but no results */}
        {!isLoading && hasSearched && recipes.length === 0 && (
          <div className="text-center py-16 bg-white rounded-3xl border border-gray-100 max-w-xl mx-auto p-8 shadow-sm">
            <span className="text-6xl mb-4 block">🍳</span>
            <h3 className="text-lg font-bold text-gray-800 mb-2">Chưa tìm thấy món ăn phù hợp</h3>
            <p className="text-gray-500 text-sm max-w-md mx-auto mb-6">
              Bạn hãy thử thêm các nguyên liệu phổ biến khác như <strong>thịt bò, trứng, cà chua, thịt gà, nấm</strong> nhé!
            </p>
            <div className="flex justify-center gap-3">
              <button
                onClick={() => { setIngredients(['Thịt bò', 'Cà chua', 'Hành tây']); handleSuggest(); }}
                className="btn-primary text-sm"
              >
                Thử combo: Thịt bò + Cà chua + Hành tây
              </button>
            </div>
          </div>
        )}
      </div>

      {/* Modal */}
      {selectedRecipe && (
        <RecipeModal
          recipe={selectedRecipe}
          onClose={() => setSelectedRecipe(null)}
          onFavorite={handleFavorite}
          isFavorite={favorites.has(selectedRecipe.id)}
        />
      )}
    </div>
  );
}
