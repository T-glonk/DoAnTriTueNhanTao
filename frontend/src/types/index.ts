export interface User {
  id: string;
  username: string;
  email: string;
  full_name: string;
  role: 'admin' | 'user';
  avatar?: string;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export interface NutritionInfo {
  calories: number;
  protein: number;
  carbohydrates: number;
  fat: number;
  fiber: number;
  vitamin_c?: number;
  calcium?: number;
  iron?: number;
}

export interface IngredientDetail {
  name: string;
  raw_text: string;
  quantity: string;
  matched: boolean;
}

export interface StepDetail {
  step_number: number;
  instruction: string;
  step_image_url?: string;
}

export interface Recipe {
  id: string;
  user_id: string;
  name: string;
  description?: string;
  ingredients: string[];
  instructions: string[];
  nutrition: NutritionInfo;
  image_url: string;
  image_query: string;
  cooking_time: number;
  difficulty: 'Dễ' | 'Trung bình' | 'Khó';
  servings: number | string;
  category: string;
  tags: string[];
  created_at: string;
  source_url?: string;
  author_name?: string;
  match_percentage?: number;
  matched_count?: number;
  total_ingredients?: number;
  matched_ingredients?: string[];
  missing_ingredients?: string[];
  ingredients_detail?: IngredientDetail[];
  steps_detail?: StepDetail[];
  source?: 'database' | 'ai' | 'hybrid' | 'fallback';
  ai_reasoning?: string;
}

export interface FavoriteRecipe {
  id: string;
  recipe: Recipe;
  created_at: string;
}

export interface SearchHistoryItem {
  id: string;
  ingredients: string[];
  created_at: string;
}

export interface AuthState {
  user: User | null;
  token: string | null;
  isLoading: boolean;
}

export interface AdminStats {
  totalUsers: number;
  activeUsers: number;
  inactiveUsers: number;
  totalSearches: number;
  totalFavorites: number;
  totalRecipes?: number;
  newUsersToday: number;
  searchesToday: number;
}

export interface PaginationMeta {
  page: number;
  limit: number;
  total: number;
  totalPages: number;
}
