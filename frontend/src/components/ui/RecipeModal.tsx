import { useState } from 'react';
import { X, Clock, Users, ChefHat, Heart, ExternalLink, CheckCircle2, AlertCircle, Sparkles, Database } from 'lucide-react';
import { Recipe } from '../../types';
import { NutritionBadge } from './NutritionBadge';

interface RecipeModalProps {
  recipe: Recipe;
  onClose: () => void;
  onFavorite?: (recipe: Recipe) => void;
  isFavorite?: boolean;
}

const difficultyColor: Record<string, string> = {
  'Dễ': 'bg-green-100 text-green-700',
  'Trung bình': 'bg-orange-100 text-orange-700',
  'Khó': 'bg-red-100 text-red-700',
};

export function RecipeModal({ recipe, onClose, onFavorite, isFavorite = false }: RecipeModalProps) {
  const [imgError, setImgError] = useState(false);
  const [activeTab, setActiveTab] = useState<'ingredients' | 'instructions' | 'nutrition'>('instructions');

  const matchPct = recipe.match_percentage;
  const isAiSource = recipe.source === 'ai' || Boolean(recipe.ai_reasoning);

  return (
    <div
      className="fixed inset-0 bg-black/60 backdrop-blur-sm flex items-center justify-center z-50 p-3 sm:p-6 animate-fade-in"
      onClick={(e) => e.target === e.currentTarget && onClose()}
    >
      <div className="bg-white rounded-3xl max-w-3xl w-full max-h-[92vh] overflow-y-auto shadow-2xl animate-slide-up flex flex-col relative border border-gray-100 custom-scrollbar">
        {/* Header image */}
        <div className="relative h-56 sm:h-64 shrink-0 bg-gray-900">
          {!imgError && recipe.image_url ? (
            <img
              src={recipe.image_url}
              alt={recipe.name}
              className="w-full h-full object-cover rounded-t-3xl"
              onError={() => setImgError(true)}
            />
          ) : (
            <div className="w-full h-full bg-gradient-to-br from-orange-100 to-amber-100 flex items-center justify-center rounded-t-3xl">
              <span className="text-7xl">🍽️</span>
            </div>
          )}
          <div className="absolute inset-0 bg-gradient-to-t from-black/85 via-black/40 to-transparent rounded-t-3xl" />
          
          {/* Close button */}
          <button
            onClick={onClose}
            className="absolute top-4 right-4 p-2.5 bg-white/90 backdrop-blur-md rounded-full hover:bg-white transition-all text-gray-700 shadow-md z-10 hover:scale-105"
            aria-label="Đóng"
          >
            <X size={20} />
          </button>

          {/* Favorite button */}
          {onFavorite && (
            <button
              onClick={() => onFavorite(recipe)}
              className={`absolute top-4 right-16 p-2.5 rounded-full transition-all z-10 shadow-md ${
                isFavorite ? 'bg-red-500 text-white' : 'bg-white/90 backdrop-blur-md text-gray-600 hover:text-red-500 hover:bg-white hover:scale-105'
              }`}
              aria-label={isFavorite ? 'Xóa khỏi yêu thích' : 'Thêm vào yêu thích'}
            >
              <Heart size={20} fill={isFavorite ? 'currentColor' : 'none'} />
            </button>
          )}

          {/* Title overlay */}
          <div className="absolute bottom-0 left-0 right-0 p-5 sm:p-6 text-white">
            <div className="flex flex-wrap items-center gap-2 mb-2">
              {isAiSource ? (
                <span className="px-3 py-1 text-xs font-bold rounded-full bg-gradient-to-r from-purple-600 to-indigo-600 text-white flex items-center gap-1 shadow-sm border border-purple-300/30">
                  <Sparkles size={13} /> Sáng tạo bởi Google Gemini AI
                </span>
              ) : (
                <span className="px-3 py-1 text-xs font-bold rounded-full bg-slate-800 text-white flex items-center gap-1 shadow-sm">
                  <Database size={13} /> Dữ liệu Cookpad (MySQL)
                </span>
              )}

              {matchPct !== undefined && (
                <span className="px-3 py-1 text-xs font-bold rounded-full bg-emerald-600 shadow-sm">
                  🎯 {matchPct}% Khớp nguyên liệu
                </span>
              )}

              {recipe.source_url && (
                <a
                  href={recipe.source_url}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="px-2.5 py-1 text-xs font-medium rounded-full bg-orange-600/90 text-white flex items-center gap-1 hover:bg-orange-500 transition-colors"
                >
                  <span>Cookpad VN</span>
                  <ExternalLink size={12} />
                </a>
              )}
            </div>

            <h2 className="text-xl sm:text-2xl font-bold mb-1 leading-snug">{recipe.name}</h2>
            {recipe.author_name ? (
              <p className="text-xs sm:text-sm text-gray-200">Đăng bởi: <span className="font-semibold">{recipe.author_name}</span></p>
            ) : isAiSource ? (
              <p className="text-xs sm:text-sm text-purple-200 font-medium flex items-center gap-1">
                <Sparkles size={13} /> Chuyên gia Ẩm thực & Dinh dưỡng AI Chef
              </p>
            ) : null}

            <div className="flex flex-wrap gap-1.5 mt-2">
              <span className={`badge ${difficultyColor[recipe.difficulty]} text-xs`}>{recipe.difficulty}</span>
              <span className="badge badge-blue text-xs">{recipe.category}</span>
              {recipe.tags && recipe.tags.slice(0, 4).map(tag => (
                <span key={tag} className="badge bg-white/20 text-white text-xs">#{tag}</span>
              ))}
            </div>
          </div>
        </div>

        {/* Meta info bar */}
        <div className="grid grid-cols-3 gap-3 p-4 sm:p-5 bg-gray-50 border-b border-gray-100 shrink-0">
          <div className="flex flex-col items-center justify-center p-2 bg-white rounded-xl shadow-xs border border-gray-100">
            <Clock size={18} className="text-primary-500 mb-0.5" />
            <span className="font-bold text-gray-800 text-sm">{recipe.cooking_time} phút</span>
            <span className="text-[11px] text-gray-400">Thời gian</span>
          </div>
          <div className="flex flex-col items-center justify-center p-2 bg-white rounded-xl shadow-xs border border-gray-100">
            <Users size={18} className="text-primary-500 mb-0.5" />
            <span className="font-bold text-gray-800 text-sm">{recipe.servings}</span>
            <span className="text-[11px] text-gray-400">Khẩu phần</span>
          </div>
          <div className="flex flex-col items-center justify-center p-2 bg-white rounded-xl shadow-xs border border-gray-100">
            <ChefHat size={18} className="text-primary-500 mb-0.5" />
            <span className="font-bold text-gray-800 text-sm">{recipe.nutrition.calories} kcal</span>
            <span className="text-[11px] text-gray-400">Hàm lượng Calo</span>
          </div>
        </div>

        {/* AI Chef Insight Box */}
        {recipe.ai_reasoning && (
          <div className="mx-5 sm:mx-6 mt-4 p-4 bg-gradient-to-br from-purple-50 via-indigo-50 to-orange-50 border border-purple-200/80 rounded-2xl shadow-xs">
            <div className="flex items-center gap-2 text-purple-800 font-bold text-sm mb-1.5">
              <Sparkles size={16} className="text-purple-600 shrink-0" />
              <span>Phân tích & Lời khuyên từ Đầu bếp AI (AI Chef Insights):</span>
            </div>
            <p className="text-gray-700 text-sm leading-relaxed">
              {recipe.ai_reasoning}
            </p>
          </div>
        )}

        {/* Navigation Tabs */}
        <div className="flex border-b border-gray-200 px-5 sm:px-6 shrink-0 mt-3 sticky top-0 bg-white z-10">
          {(['instructions', 'ingredients', 'nutrition'] as const).map(tab => (
            <button
              key={tab}
              onClick={() => setActiveTab(tab)}
              className={`py-3 px-3 sm:px-5 text-sm font-semibold border-b-2 transition-all cursor-pointer ${
                activeTab === tab
                  ? 'border-primary-500 text-primary-600 bg-orange-50/40'
                  : 'border-transparent text-gray-500 hover:text-gray-800'
              }`}
            >
              {tab === 'instructions' 
                ? `👨‍🍳 Cách làm (${recipe.instructions?.length || recipe.steps_detail?.length || 0})` 
                : tab === 'ingredients' 
                ? `🥘 Nguyên liệu (${recipe.ingredients?.length || 0})` 
                : '📊 Dinh dưỡng'
              }
            </button>
          ))}
        </div>

        {/* Tab content (Single smooth scrolling without inner cutoffs) */}
        <div className="p-5 sm:p-6 pb-12">
          {/* TAB 1: CÁCH LÀM (INSTRUCTIONS) */}
          {activeTab === 'instructions' && (
            <div className="space-y-4 animate-fade-in">
              <h3 className="font-bold text-gray-800 text-base mb-3 flex items-center gap-2">
                <span>👨‍🍳 Hướng dẫn chi tiết từng bước:</span>
              </h3>

              {recipe.steps_detail && recipe.steps_detail.length > 0 ? (
                <div className="space-y-3.5">
                  {recipe.steps_detail.map((s, i) => (
                    <div key={i} className="p-4 bg-gray-50/80 hover:bg-orange-50/30 rounded-2xl border border-gray-100 transition-colors space-y-2">
                      <div className="flex items-start gap-3">
                        <span className="w-7 h-7 bg-primary-500 text-white rounded-full flex items-center justify-center font-bold text-xs shrink-0 mt-0.5 shadow-sm">
                          {s.step_number || i + 1}
                        </span>
                        <p className="text-gray-800 text-sm leading-relaxed pt-0.5">
                          {s.instruction.replace(/^Bước \d+:\s*/i, '')}
                        </p>
                      </div>
                      {s.step_image_url && (
                        <div className="pl-10 pt-1">
                          <img
                            src={s.step_image_url}
                            alt={`Bước ${s.step_number || i + 1}`}
                            className="rounded-xl max-h-56 object-cover shadow-sm border border-gray-200"
                            loading="lazy"
                          />
                        </div>
                      )}
                    </div>
                  ))}
                </div>
              ) : (
                <ol className="space-y-3">
                  {recipe.instructions.map((step, i) => (
                    <li key={i} className="flex gap-3 p-4 bg-gray-50 rounded-2xl border border-gray-100">
                      <span className="w-7 h-7 bg-primary-500 text-white rounded-full flex items-center justify-center font-bold text-xs shrink-0 shadow-sm">
                        {i + 1}
                      </span>
                      <p className="text-gray-700 text-sm leading-relaxed pt-0.5">
                        {step.replace(/^Bước \d+:\s*/i, '')}
                      </p>
                    </li>
                  ))}
                </ol>
              )}
            </div>
          )}

          {/* TAB 2: NGUYÊN LIỆU (INGREDIENTS) */}
          {activeTab === 'ingredients' && (
            <div className="space-y-4 animate-fade-in">
              <h3 className="font-bold text-gray-800 text-base mb-3 flex items-center gap-2">
                <span>🛒 Danh sách nguyên liệu và định lượng:</span>
              </h3>

              {recipe.ingredients_detail && recipe.ingredients_detail.length > 0 ? (
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5">
                  {recipe.ingredients_detail.map((ing, i) => (
                    <div
                      key={i}
                      className={`flex items-center justify-between p-3.5 rounded-2xl border transition-all ${
                        ing.matched
                          ? 'bg-emerald-50/70 border-emerald-200 text-emerald-950'
                          : 'bg-gray-50 border-gray-100 text-gray-700'
                      }`}
                    >
                      <div className="flex items-center gap-3">
                        {ing.matched ? (
                          <CheckCircle2 size={18} className="text-emerald-600 shrink-0" />
                        ) : (
                          <AlertCircle size={18} className="text-amber-500 shrink-0" />
                        )}
                        <span className="font-medium text-sm">{ing.raw_text || ing.name}</span>
                      </div>
                      <span className={`text-xs px-2.5 py-1 rounded-full font-bold shrink-0 ml-2 ${
                        ing.matched ? 'bg-emerald-200 text-emerald-800' : 'bg-gray-200 text-gray-600'
                      }`}>
                        {ing.matched ? 'Đã có' : 'Cần thêm'}
                      </span>
                    </div>
                  ))}
                </div>
              ) : (
                <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5">
                  {recipe.ingredients.map((ing, i) => (
                    <div key={i} className="flex items-center gap-3 p-3.5 bg-gray-50 rounded-2xl border border-gray-100">
                      <span className="w-6 h-6 bg-primary-100 text-primary-600 rounded-full flex items-center justify-center text-xs font-bold shrink-0">
                        {i + 1}
                      </span>
                      <span className="text-gray-800 text-sm font-medium">{ing}</span>
                    </div>
                  ))}
                </div>
              )}
            </div>
          )}

          {/* TAB 3: DINH DƯỠNG (NUTRITION) */}
          {activeTab === 'nutrition' && (
            <div className="space-y-5 animate-fade-in">
              <div>
                <h3 className="font-bold text-gray-800 text-base mb-1 flex items-center gap-2">
                  <span>📊 Bảng giá trị dinh dưỡng chi tiết</span>
                </h3>
                <p className="text-xs text-gray-400 mb-3">
                  *Tính toán ước tính cho khẩu phần: <strong>{recipe.servings}</strong> (Dữ liệu phân tích từ FoodAI)
                </p>
              </div>

              {/* Single Clean Nutrition Grid (Calo, Protein, Carbs, Fat, Fiber) */}
              <NutritionBadge nutrition={recipe.nutrition} />

              {/* Vi chất dinh dưỡng bổ sung nếu có */}
              {(recipe.nutrition.vitamin_c || recipe.nutrition.calcium || recipe.nutrition.iron) && (
                <div className="pt-2">
                  <h4 className="font-semibold text-gray-700 text-xs uppercase tracking-wider mb-3">
                    Khoáng chất & Vi chất bổ sung
                  </h4>
                  <div className="grid grid-cols-3 gap-3">
                    {recipe.nutrition.vitamin_c !== undefined && (
                      <div className="p-3 bg-yellow-50 rounded-xl text-center border border-yellow-100">
                        <p className="text-base font-bold text-yellow-700">{recipe.nutrition.vitamin_c}mg</p>
                        <p className="text-[11px] text-gray-500">Vitamin C</p>
                      </div>
                    )}
                    {recipe.nutrition.calcium !== undefined && (
                      <div className="p-3 bg-cyan-50 rounded-xl text-center border border-cyan-100">
                        <p className="text-base font-bold text-cyan-700">{recipe.nutrition.calcium}mg</p>
                        <p className="text-[11px] text-gray-500">Canxi (Calcium)</p>
                      </div>
                    )}
                    {recipe.nutrition.iron !== undefined && (
                      <div className="p-3 bg-rose-50 rounded-xl text-center border border-rose-100">
                        <p className="text-base font-bold text-rose-700">{recipe.nutrition.iron}mg</p>
                        <p className="text-[11px] text-gray-500">Sắt (Iron)</p>
                      </div>
                    )}
                  </div>
                </div>
              )}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

