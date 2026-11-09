const { CATEGORY_IMAGE_REGISTRY } = require('../../dist/services/category_images');
const { isImageUrlConflicting } = require('../../dist/services/image.service');

// We test with sample dish names for each category
const sampleDishes = {
  frog_dish: 'Ếch xào sả ớt',
  pork_ribs: 'Sườn xào chua ngọt',
  eel_dish: 'Lươn kho tiêu',
  duck_dish: 'Vịt nấu chao',
  chicken_porridge: 'Cháo gà nấm hương',
  porridge_general: 'Cháo thịt bò băm',
  chicken_salad: 'Gỏi gà bắp cải',
  salad_general: 'Nộm hoa chuối tai lợn',
  egg_dish: 'Trứng cuộn hành hoa',
  egg_tomato: 'Trứng xào cà chua',
  fish_tuna: 'Cá ngừ kho thơm',
  fish_braised: 'Cá kho tộ',
  fish_fried: 'Cá chiên giòn',
  fish_soup: 'Canh chua cá lóc',
  shrimp_dish: 'Tôm xào bơ tỏi',
  squid_dish: 'Mực xào cần tỏi',
  clam_snail_dish: 'Nghêu hấp sả',
  tofu_dish: 'Đậu hũ chiên sả ớt',
  beef_stir_fry: 'Bò lúc lắc',
  beef_stew: 'Bò sốt vang',
  beef_soup: 'Phở bò',
  pork_braised: 'Thịt kho tàu',
  pork_fried: 'Thịt heo chiên xù',
  pork_soup: 'Canh sườn nấu sấu',
  chicken_fried: 'Cánh gà chiên nước mắm',
  chicken_braised: 'Gà kho sả ớt',
  chicken_soup: 'Canh gà lá giang',
  veggie_stir_fry: 'Rau muống xào tỏi',
  soup_general: 'Canh bí nấu tôm',
  noodle_rice: 'Cơm chiên chả lụa',
  general_dish: 'Thịt xào chua ngọt'
};

let conflicts = 0;
let total = 0;

for (const [cat, sampleDish] of Object.entries(sampleDishes)) {
  const urls = CATEGORY_IMAGE_REGISTRY[cat] || [];
  for (const url of urls) {
    total++;
    const isConflict = isImageUrlConflicting(url, sampleDish);
    if (isConflict) {
      conflicts++;
      console.log(`❌ Conflict in [${cat}] for "${sampleDish}": ${url}`);
    }
  }
}

console.log(`\nRegistry Validation Result: ${total - conflicts} / ${total} images passed. Conflicts: ${conflicts}`);
