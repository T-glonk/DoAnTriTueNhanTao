import { NutritionInfo } from '../../types';
import { Flame, Beef, Wheat, Droplets, Leaf } from 'lucide-react';

interface NutritionBadgeProps {
  nutrition: NutritionInfo;
  compact?: boolean;
}

export function NutritionBadge({ nutrition, compact = false }: NutritionBadgeProps) {
  const items = [
    { icon: Flame, label: 'Calo', value: nutrition.calories, unit: 'kcal', color: 'text-orange-500', bg: 'bg-orange-50' },
    { icon: Beef, label: 'Protein', value: nutrition.protein, unit: 'g', color: 'text-red-500', bg: 'bg-red-50' },
    { icon: Wheat, label: 'Carbs', value: nutrition.carbohydrates, unit: 'g', color: 'text-yellow-500', bg: 'bg-yellow-50' },
    { icon: Droplets, label: 'Chất béo', value: nutrition.fat, unit: 'g', color: 'text-blue-500', bg: 'bg-blue-50' },
    { icon: Leaf, label: 'Chất xơ', value: nutrition.fiber, unit: 'g', color: 'text-green-500', bg: 'bg-green-50' },
  ];

  if (compact) {
    return (
      <div className="flex flex-wrap gap-2">
        {items.map(({ icon: Icon, label, value, unit, color, bg }) => (
          <div key={label} className={`flex items-center gap-1 px-2 py-1 rounded-lg ${bg}`}>
            <Icon size={12} className={color} />
            <span className="text-xs font-medium text-gray-700">{value}{unit}</span>
          </div>
        ))}
      </div>
    );
  }

  return (
    <div className="grid grid-cols-5 gap-3">
      {items.map(({ icon: Icon, label, value, unit, color, bg }) => (
        <div key={label} className={`flex flex-col items-center p-3 rounded-xl ${bg}`}>
          <Icon size={20} className={color} />
          <span className="text-lg font-bold text-gray-800 mt-1">{value}</span>
          <span className="text-xs text-gray-500">{unit}</span>
          <span className="text-xs text-gray-600 font-medium">{label}</span>
        </div>
      ))}
    </div>
  );
}
