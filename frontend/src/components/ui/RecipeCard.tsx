import { useState } from 'react';
import { Clock, Users, ChefHat, Heart, Eye, CheckCircle2, AlertCircle, ExternalLink, Sparkles, Database, ChevronDown, ChevronUp } from 'lucide-react';
import { Recipe } from '../../types';
import { NutritionBadge } from './NutritionBadge';

interface RecipeCardProps {
  recipe: Recipe;
  onFavorite?: (recipe: Recipe) => void;
  isFavorite?: boolean;
  onViewDetail?: (recipe: Recipe) => void;
}

const difficultyColor = {
  'Dễ': 'badge-green',
  'Trung bình': 'badge-orange',
  'Khó': 'badge-red',
};

export function RecipeCard({ recipe, onFavorite, isFavorite = false, onViewDetail }: RecipeCardProps) {
  const [expanded, setExpanded] = useState(false);
  const [imgError, setImgError] = useState(false);

  const isAiSource = recipe.source === 'ai' || Boolean(recipe.ai_reasoning);

  return (
    <div className="food-card bg-white rounded-3xl overflow-hidden shadow-xs border border-gray-100 flex flex-col hover:shadow-lg hover:border-orange-100 transition-all duration-300">
      {/* Image Container with Elegant Fallback Background */}
      <div className="relative h-52 overflow-hidden bg-gradient-to-br from-orange-100/60 via-amber-50 to-orange-50 group flex items-center justify-center">
        {/* Placeholder Watermark if image is loading or unavailable */}
        <div className="absolute inset-0 flex flex-col items-center justify-center text-orange-200 pointer-events-none select-none">
          <ChefHat size={48} className="opacity-40 animate-pulse" />
          <span className="text-xs font-semibold text-orange-300/80 mt-1">FoodAI Dish</span>
        </div>

        {!imgError && recipe.image_url ? (
          <img
            src={recipe.image_url}
            alt={recipe.name}
            className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105 relative z-0"
            onError={() => setImgError(true)}
            referrerPolicy="no-referrer"
            loading="lazy"
          />
        ) : (
          <div className="w-full h-full bg-gradient-to-br from-orange-100 to-amber-100 flex flex-col items-center justify-center text-orange-400 relative z-0">
            <span className="text-5xl mb-1">🍽️</span>
            <span className="text-xs font-semibold text-orange-500/80">{recipe.name}</span>
          </div>
        )}

        
        {/* Overlay Badges */}
        <div className="absolute top-3 left-3 flex flex-wrap gap-1.5 items-center max-w-[80%]">
          {isAiSource ? (
            <span className="px-2.5 py-1 text-xs font-bold rounded-full shadow-sm flex items-center gap-1 bg-gradient-to-r from-purple-600 to-indigo-600 text-white border border-purple-400/30">
              <Sparkles size={11} /> Gemini AI
            </span>
          ) : (
            <span className="px-2.5 py-1 text-xs font-bold rounded-full shadow-sm flex items-center gap-1 bg-slate-800 text-white">
              <Database size={11} /> Cookpad
            </span>
          )}

          <span className={`badge ${difficultyColor[recipe.difficulty]} shadow-sm text-[11px]`}>
            {recipe.difficulty}
          </span>
          <span className="badge badge-blue shadow-sm text-[11px]">{recipe.category}</span>
        </div>

        {/* Favorite Button */}
        {onFavorite && (
          <button
            onClick={() => onFavorite(recipe)}
            className={`absolute top-3 right-3 p-2.5 rounded-full shadow-md transition-all duration-200 ${
              isFavorite
                ? 'bg-red-500 text-white'
                : 'bg-white/90 backdrop-blur-sm text-gray-500 hover:text-red-500 hover:bg-white'
            }`}
            aria-label={isFavorite ? 'Xóa khỏi yêu thích' : 'Thêm vào yêu thích'}
          >
            <Heart size={16} fill={isFavorite ? 'currentColor' : 'none'} />
          </button>
        )}

        {/* Source Badge */}
        {recipe.image_url?.includes('pexels.com') ? (
          <div className="absolute bottom-2 right-2">
            <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded text-[10px] font-medium bg-black/60 backdrop-blur-sm text-white">
              📸 Pexels HD
            </span>
          </div>
        ) : recipe.source_url ? (
          <div className="absolute bottom-2 right-2">
            <span className="inline-flex items-center gap-1 px-2 py-0.5 rounded text-[10px] font-medium bg-black/60 backdrop-blur-sm text-white">
              Cookpad VN
            </span>
          </div>
        ) : null}
      </div>

      {/* Content */}
      <div className="p-5 flex flex-col flex-1">
        <div className="flex items-start justify-between gap-2 mb-1">
          <h3 
            onClick={() => onViewDetail && onViewDetail(recipe)}
            className="font-bold text-gray-900 text-lg line-clamp-1 hover:text-primary-600 transition-colors cursor-pointer"
            title={recipe.name}
          >
            {recipe.name}
          </h3>
        </div>

        {recipe.author_name ? (
          <p className="text-xs text-gray-400 mb-2">Đăng bởi: <span className="font-medium text-gray-600">{recipe.author_name}</span></p>
        ) : isAiSource ? (
          <p className="text-xs text-purple-600 font-medium mb-2 flex items-center gap-1">
            <Sparkles size={12} /> Đầu bếp Trí Tuệ Nhân Tạo FoodAI
          </p>
        ) : null}

        {recipe.description && (
          <p className="text-gray-500 text-xs sm:text-sm mb-3 line-clamp-2 leading-relaxed">{recipe.description}</p>
        )}

        {/* Phân tích lời khuyên AI */}
        {recipe.ai_reasoning && (
          <div className="mb-3 p-3 bg-gradient-to-br from-purple-50 via-indigo-50/50 to-orange-50 border border-purple-100 rounded-2xl text-xs space-y-1">
            <div className="flex items-center gap-1.5 text-purple-700 font-semibold">
              <Sparkles size={13} className="shrink-0 text-purple-600" />
              <span>Phân tích từ Đầu bếp AI:</span>
            </div>
            <p className="text-gray-700 text-xs leading-relaxed line-clamp-3">
              {recipe.ai_reasoning}
            </p>
          </div>
        )}

        {/* Nguyên liệu khớp & thiếu */}
        {recipe.ingredients_detail && recipe.ingredients_detail.length > 0 && (
          <div className="mb-3 p-2.5 bg-gray-50 rounded-xl text-xs space-y-1 border border-gray-100">
            <div className="flex items-center gap-1.5 text-emerald-700 font-medium">
              <CheckCircle2 size={13} className="shrink-0" />
              <span className="truncate">
                Có sẵn: {recipe.ingredients_detail.filter(i => i.matched).map(i => i.name).join(', ') || 'Chưa xác định'}
              </span>
            </div>
            {recipe.ingredients_detail.some(i => !i.matched) && (
              <div className="flex items-center gap-1.5 text-amber-700">
                <AlertCircle size={13} className="shrink-0" />
                <span className="truncate">
                  Cần thêm: {recipe.ingredients_detail.filter(i => !i.matched).slice(0, 3).map(i => i.name).join(', ')}
                  {recipe.ingredients_detail.filter(i => !i.matched).length > 3 ? '...' : ''}
                </span>
              </div>
            )}
          </div>
        )}

        {/* Meta info */}
        <div className="flex items-center justify-between text-xs text-gray-500 mb-3 bg-gray-50/80 px-3 py-2 rounded-xl border border-gray-100">
          <span className="flex items-center gap-1 font-medium">
            <Clock size={13} className="text-primary-500" />
            {recipe.cooking_time} phút
          </span>
          <span className="flex items-center gap-1 font-medium">
            <Users size={13} className="text-primary-500" />
            {recipe.servings}
          </span>
          <span className="flex items-center gap-1 font-medium">
            <ChefHat size={13} className="text-primary-500" />
            {recipe.nutrition.calories} kcal
          </span>
        </div>

        {/* Nutrition compact */}
        <div className="mb-3">
          <NutritionBadge nutrition={recipe.nutrition} compact />
        </div>

        {/* Tags */}
        {recipe.tags && recipe.tags.length > 0 && (
          <div className="flex flex-wrap gap-1 mb-4">
            {recipe.tags.slice(0, 3).map(tag => (
              <span key={tag} className="badge badge-gray text-[11px]">#{tag}</span>
            ))}
          </div>
        )}

        {/* Expanded recipe preview */}
        {expanded && (
          <div className="border-t border-gray-100 pt-3 mb-4 text-xs space-y-3 animate-fade-in bg-gray-50/50 p-3 rounded-2xl">
            <div>
              <p className="font-bold text-gray-800 mb-1 flex items-center gap-1">
                🛒 Nguyên liệu ({recipe.ingredients.length}):
              </p>
              <ul className="list-disc list-inside text-gray-600 space-y-1 pl-1">
                {recipe.ingredients.slice(0, 5).map((ing, i) => (
                  <li key={i}>{ing}</li>
                ))}
                {recipe.ingredients.length > 5 && (
                  <li className="text-primary-600 font-medium list-none pl-2">
                    và {recipe.ingredients.length - 5} nguyên liệu khác...
                  </li>
                )}
              </ul>
            </div>
            <div>
              <p className="font-bold text-gray-800 mb-1 flex items-center gap-1">
                👨‍🍳 Các bước nấu chính:
              </p>
              <ol className="list-decimal list-inside text-gray-600 space-y-1 pl-1">
                {recipe.instructions.slice(0, 3).map((step, i) => (
                  <li key={i} className="line-clamp-2">{step.replace(/^Bước \d+:\s*/i, '')}</li>
                ))}
                {recipe.instructions.length > 3 && (
                  <li className="text-primary-600 font-medium list-none pl-2">
                    +{recipe.instructions.length - 3} bước khác (nhấn "Xem đầy đủ" để xem hết)...
                  </li>
                )}
              </ol>
            </div>
          </div>
        )}

        {/* Action buttons */}
        <div className="flex gap-2 mt-auto pt-2">
          <button
            onClick={() => setExpanded(!expanded)}
            className="flex-1 btn-secondary text-xs py-2 flex items-center justify-center gap-1"
          >
            <span>{expanded ? 'Thu gọn' : 'Xem nhanh'}</span>
            {expanded ? <ChevronUp size={14} /> : <ChevronDown size={14} />}
          </button>
          {onViewDetail && (
            <button
              onClick={() => onViewDetail(recipe)}
              className="btn-primary text-xs py-2 px-3.5 flex items-center gap-1.5 shadow-sm"
              title="Xem chi tiết đầy đủ công thức và dinh dưỡng"
            >
              <Eye size={14} />
              <span>Xem đầy đủ</span>
            </button>
          )}
          {recipe.source_url && (
            <a
              href={recipe.source_url}
              target="_blank"
              rel="noopener noreferrer"
              className="p-2 rounded-xl border border-gray-200 text-gray-400 hover:text-orange-500 hover:border-orange-200 transition-colors flex items-center justify-center"
              title="Xem trên Cookpad"
            >
              <ExternalLink size={14} />
            </a>
          )}
        </div>
      </div>
    </div>
  );
}
