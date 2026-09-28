import { useState, useEffect } from 'react';
import { Heart, Trash2 } from 'lucide-react';
import toast from 'react-hot-toast';
import api from '../../lib/api';
import { FavoriteRecipe, Recipe } from '../../types';
import { RecipeCard } from '../../components/ui/RecipeCard';
import { RecipeModal } from '../../components/ui/RecipeModal';
import { LoadingSpinner } from '../../components/ui/LoadingSpinner';
import { AxiosError } from 'axios';

export function FavoritesPage() {
  const [favorites, setFavorites] = useState<FavoriteRecipe[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [selectedRecipe, setSelectedRecipe] = useState<Recipe | null>(null);

  const loadFavorites = async () => {
    try {
      const res = await api.get<{ data: { favorites: FavoriteRecipe[] } }>('/recipes/favorites');
      setFavorites(res.data.data.favorites);
    } catch {
      toast.error('Không thể tải danh sách yêu thích');
    } finally {
      setIsLoading(false);
    }
  };

  useEffect(() => { loadFavorites(); }, []);

  const handleRemove = async (favoriteId: string) => {
    try {
      await api.delete(`/recipes/favorites/${favoriteId}`);
      setFavorites(prev => prev.filter(f => f.id !== favoriteId));
      toast.success('Đã xóa khỏi yêu thích');
    } catch (error) {
      const err = error as AxiosError<{ error: string }>;
      toast.error(err.response?.data?.error || 'Không thể xóa');
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
    <div className="p-6 max-w-7xl mx-auto">
      {/* Header */}
      <div className="flex items-center gap-3 mb-6">
        <div className="w-10 h-10 bg-red-100 rounded-xl flex items-center justify-center">
          <Heart size={20} className="text-red-500" />
        </div>
        <div>
          <h1 className="text-xl font-bold text-gray-900">Món ăn yêu thích</h1>
          <p className="text-sm text-gray-500">{favorites.length} món đã lưu</p>
        </div>
      </div>

      {favorites.length === 0 ? (
        <div className="text-center py-20">
          <div className="text-6xl mb-4">💔</div>
          <h3 className="text-lg font-semibold text-gray-800">Chưa có món ăn yêu thích</h3>
          <p className="text-gray-500 mt-2">Thêm món ăn vào yêu thích để xem lại sau</p>
        </div>
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
          {favorites.map(fav => (
            <div key={fav.id} className="relative">
              <RecipeCard
                recipe={fav.recipe}
                isFavorite={true}
                onViewDetail={setSelectedRecipe}
              />
              <button
                onClick={() => handleRemove(fav.id)}
                className="absolute top-3 right-3 p-2 bg-red-500 text-white rounded-full hover:bg-red-600 shadow-md transition-colors"
                aria-label="Xóa khỏi yêu thích"
              >
                <Trash2 size={14} />
              </button>
            </div>
          ))}
        </div>
      )}

      {selectedRecipe && (
        <RecipeModal
          recipe={selectedRecipe}
          onClose={() => setSelectedRecipe(null)}
        />
      )}
    </div>
  );
}
