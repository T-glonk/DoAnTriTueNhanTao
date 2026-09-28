import { NutritionInfo } from '../types';

export interface RecipeData {
  name: string;
  description: string;
  keywords: string[];   // nguyên liệu chính để matching
  ingredients: string[];
  instructions: string[];
  nutrition: NutritionInfo;
  cooking_time: number;
  difficulty: 'Dễ' | 'Trung bình' | 'Khó';
  servings: number;
  category: string;
  tags: string[];
  image_query: string;
}

export const VIETNAMESE_RECIPES: RecipeData[] = [
  // ====== THỊT BÒ ======
  {
    name: 'Bò kho cà rốt khoai tây',
    description: 'Món bò kho đậm đà, thịt mềm tan, nước sốt sệt thơm ngon, ăn kèm bánh mì hoặc cơm trắng.',
    keywords: ['thịt bò', 'bò', 'cà rốt', 'khoai tây'],
    ingredients: ['500g thịt bò (bắp hoặc nạm)', '2 củ cà rốt', '2 củ khoai tây', '2 cây sả', '3 tép tỏi', '1 củ hành tây', '2 thìa cà phê bột ngũ vị hương', '2 thìa canh dầu hào', '1 thìa canh nước mắm', 'Muối, đường, tiêu', 'Dầu ăn'],
    instructions: [
      'Bước 1: Thịt bò rửa sạch, cắt khúc 4-5cm. Ướp với tỏi băm, bột ngũ vị hương, dầu hào, nước mắm, chút muối tiêu trong 30 phút.',
      'Bước 2: Cà rốt, khoai tây gọt vỏ cắt khúc vừa ăn. Sả đập dập cắt khúc. Hành tây thái múi cau.',
      'Bước 3: Phi thơm tỏi với dầu ăn, cho thịt bò vào xào săn trên lửa lớn.',
      'Bước 4: Thêm sả, hành tây vào xào cùng 2 phút. Đổ nước ngập thịt, đậy nắp nấu sôi rồi hạ lửa nhỏ.',
      'Bước 5: Sau 30 phút, cho cà rốt và khoai tây vào nấu thêm 20 phút đến khi mềm.',
      'Bước 6: Nêm nếm lại gia vị cho vừa miệng. Thêm ít tiêu và hành lá thái nhỏ trước khi dọn.',
    ],
    nutrition: { calories: 420, protein: 32, carbohydrates: 28, fat: 18, fiber: 4, vitamin_c: 12, calcium: 45, iron: 4 },
    cooking_time: 60,
    difficulty: 'Trung bình',
    servings: 4,
    category: 'Món chính',
    tags: ['bò kho', 'nước sốt', 'ăn với bánh mì', 'đậm đà'],
    image_query: 'vietnamese beef stew carrot potato',
  },
  {
    name: 'Thịt bò xào rau cải',
    description: 'Món xào nhanh, thịt bò mềm ngọt kết hợp rau cải xanh giòn, đậm vị oyster sauce.',
    keywords: ['thịt bò', 'bò', 'rau cải', 'cải'],
    ingredients: ['300g thịt bò thái lát mỏng', '300g rau cải xanh', '3 tép tỏi', '1 thìa canh dầu hào', '1 thìa canh nước tương', '1 thìa cà phê dầu mè', '½ thìa cà phê tinh bột bắp', 'Muối, tiêu, dầu ăn'],
    instructions: [
      'Bước 1: Thịt bò thái lát mỏng ngang thớ. Ướp với dầu hào, nước tương, tinh bột bắp, chút tiêu trong 15 phút.',
      'Bước 2: Rau cải nhặt sạch, cắt khúc 5cm. Tỏi băm nhỏ.',
      'Bước 3: Làm nóng chảo dầu ăn lửa lớn, phi thơm tỏi.',
      'Bước 4: Cho thịt bò vào xào nhanh tay trên lửa lớn 2-3 phút đến khi bò vừa chín, vớt ra.',
      'Bước 5: Thêm dầu vào chảo, cho rau cải vào xào 2 phút đến khi vừa chín tới, còn xanh.',
      'Bước 6: Cho thịt bò lại vào, thêm dầu mè, xào đều 1 phút rồi tắt bếp. Dọn nóng với cơm trắng.',
    ],
    nutrition: { calories: 280, protein: 28, carbohydrates: 8, fat: 14, fiber: 3, vitamin_c: 35, calcium: 80, iron: 5 },
    cooking_time: 25,
    difficulty: 'Dễ',
    servings: 2,
    category: 'Món chính',
    tags: ['xào', 'nhanh', 'dinh dưỡng', 'rau xanh'],
    image_query: 'vietnamese beef stir fry vegetables',
  },
  {
    name: 'Phở bò',
    description: 'Món phở truyền thống Hà Nội với nước dùng trong vắt, ngọt thơm từ xương, thịt bò tươi mềm.',
    keywords: ['thịt bò', 'bò', 'bún', 'phở', 'xương'],
    ingredients: ['500g xương ống bò', '300g thịt bò tái', '200g bánh phở', '1 củ hành tây', '1 mẩu gừng 5cm', '2 cây hồi', '1 thanh quế', '3 nụ đinh hương', 'Hành lá, ngò gai, giá đỗ', 'Nước mắm, muối, đường phèn', 'Chanh, ớt tươi'],
    instructions: [
      'Bước 1: Xương bò trụng qua nước sôi 5 phút, rửa sạch để loại bỏ tạp chất.',
      'Bước 2: Nướng hành tây và gừng trên bếp đến khi cháy xém ngoài. Rang thơm hồi, quế, đinh hương.',
      'Bước 3: Nấu xương với 3 lít nước, cho hành tây, gừng, gia vị đã rang vào. Hầm lửa nhỏ 3-4 tiếng.',
      'Bước 4: Vớt bọt thường xuyên để nước dùng trong. Nêm nước mắm, muối, đường phèn cho vừa miệng.',
      'Bước 5: Thịt bò thái lát mỏng. Bánh phở trụng qua nước sôi, cho vào tô.',
      'Bước 6: Xếp thịt bò lên bánh phở, chan nước dùng thật nóng. Ăn kèm hành lá, giá, chanh, ớt.',
    ],
    nutrition: { calories: 380, protein: 30, carbohydrates: 42, fat: 10, fiber: 2, vitamin_c: 8, calcium: 60, iron: 4 },
    cooking_time: 240,
    difficulty: 'Khó',
    servings: 4,
    category: 'Món chính',
    tags: ['phở', 'truyền thống', 'nước dùng', 'Hà Nội'],
    image_query: 'vietnamese pho bo beef noodle soup',
  },

  // ====== THỊT GÀ ======
  {
    name: 'Gà kho gừng',
    description: 'Gà kho đậm đà với gừng tươi cay nồng, nước sốt sánh vàng ăn kèm cơm trắng rất ngon.',
    keywords: ['thịt gà', 'gà', 'gừng'],
    ingredients: ['500g thịt gà (đùi hoặc cánh)', '1 củ gừng tươi', '3 tép tỏi', '2 thìa canh nước mắm', '1 thìa canh đường', '1 thìa canh dầu ăn', 'Tiêu, hành lá'],
    instructions: [
      'Bước 1: Thịt gà chặt miếng vừa ăn, rửa sạch với nước muối loãng, để ráo.',
      'Bước 2: Gừng cạo vỏ, thái sợi hoặc đập dập. Tỏi băm nhỏ.',
      'Bước 3: Ướp gà với tỏi, gừng, nước mắm, đường, tiêu trong 20 phút.',
      'Bước 4: Phi thơm tỏi với dầu ăn trên lửa vừa. Cho gà vào xào vàng đều các mặt.',
      'Bước 5: Thêm ½ chén nước, đậy nắp kho lửa nhỏ 20 phút.',
      'Bước 6: Mở nắp, tăng lửa kho cho cạn nước, nước sốt sệt lại. Rắc hành lá thái nhỏ.',
    ],
    nutrition: { calories: 320, protein: 35, carbohydrates: 6, fat: 16, fiber: 0, vitamin_c: 2, calcium: 25, iron: 2 },
    cooking_time: 40,
    difficulty: 'Dễ',
    servings: 3,
    category: 'Món chính',
    tags: ['kho', 'gừng', 'cay', 'ăn với cơm'],
    image_query: 'vietnamese braised chicken ginger',
  },
  {
    name: 'Canh gà nấu nấm',
    description: 'Canh gà ngọt thanh, nấm hương bùi béo, bổ dưỡng cho cả gia đình.',
    keywords: ['thịt gà', 'gà', 'nấm'],
    ingredients: ['400g thịt gà', '200g nấm hương (hoặc nấm rơm)', '2 tép tỏi', 'Hành lá, ngò rí', '1 thìa canh nước mắm', 'Muối, tiêu, đường'],
    instructions: [
      'Bước 1: Gà chặt miếng, trụng qua nước sôi rồi rửa sạch.',
      'Bước 2: Nấm hương ngâm nở (nếu khô), rửa sạch, cắt bỏ chân.',
      'Bước 3: Phi thơm tỏi, cho gà vào xào sơ 3 phút.',
      'Bước 4: Đổ 1 lít nước vào, nấu sôi rồi hạ lửa nhỏ hầm 25 phút.',
      'Bước 5: Cho nấm vào nấu thêm 10 phút. Nêm nước mắm, muối, đường cho vừa.',
      'Bước 6: Tắt bếp, cho hành lá và ngò rí vào. Dọn nóng.',
    ],
    nutrition: { calories: 220, protein: 28, carbohydrates: 5, fat: 9, fiber: 2, vitamin_c: 4, calcium: 30, iron: 2 },
    cooking_time: 45,
    difficulty: 'Dễ',
    servings: 3,
    category: 'Súp/Canh',
    tags: ['canh', 'nấm', 'bổ dưỡng', 'thanh mát'],
    image_query: 'vietnamese chicken mushroom soup',
  },
  {
    name: 'Gà rang muối',
    description: 'Gà rang giòn bì, vị mặn thơm đặc trưng, cực kỳ đưa cơm.',
    keywords: ['thịt gà', 'gà'],
    ingredients: ['1 con gà nhỏ hoặc 500g cánh/đùi gà', '1 thìa canh muối hạt', '1 thìa cà phê tiêu xay', '½ thìa cà phê bột tỏi', '2 thìa canh dầu ăn', 'Lá chanh thái sợi'],
    instructions: [
      'Bước 1: Gà chặt miếng vừa ăn, rửa sạch, để ráo nước thật khô.',
      'Bước 2: Rang muối hạt với tiêu trên chảo khô đến khi thơm vàng.',
      'Bước 3: Trộn gà với muối rang, bột tỏi, để thấm 15 phút.',
      'Bước 4: Làm nóng chảo với 2 thìa dầu, cho gà vào rang lửa vừa.',
      'Bước 5: Đảo đều tay, rang khoảng 20-25 phút đến khi gà vàng giòn đều.',
      'Bước 6: Cho lá chanh thái sợi vào đảo đều 1 phút rồi tắt bếp.',
    ],
    nutrition: { calories: 350, protein: 38, carbohydrates: 1, fat: 20, fiber: 0, vitamin_c: 3, calcium: 20, iron: 2 },
    cooking_time: 35,
    difficulty: 'Dễ',
    servings: 3,
    category: 'Món chính',
    tags: ['rang', 'giòn', 'mặn thơm', 'đưa cơm'],
    image_query: 'vietnamese salt roasted chicken crispy',
  },

  // ====== THỊT HEO ======
  {
    name: 'Thịt kho trứng',
    description: 'Thịt heo ba chỉ kho nước dừa, trứng vịt thấm gia vị, màu vàng đẹp, đậm đà truyền thống miền Nam.',
    keywords: ['thịt heo', 'heo', 'thịt', 'trứng', 'trứng vịt'],
    ingredients: ['500g thịt heo ba chỉ', '4 quả trứng vịt (hoặc trứng gà)', '300ml nước dừa tươi', '3 thìa canh nước mắm', '2 thìa canh đường', '3 tép tỏi', '2 thìa canh nước màu', 'Tiêu, hành lá'],
    instructions: [
      'Bước 1: Thịt heo cắt miếng 4x4cm. Ướp với nước mắm, đường, tỏi băm, tiêu 30 phút.',
      'Bước 2: Luộc trứng chín, bóc vỏ. Chiên vàng trứng với ít dầu cho không bị vỡ khi kho.',
      'Bước 3: Phi thơm tỏi, cho thịt vào xào vàng đều, thêm nước màu đảo đều.',
      'Bước 4: Đổ nước dừa vào, thêm ít nước lọc nếu cần, cho trứng vào kho cùng.',
      'Bước 5: Đun sôi rồi hạ lửa nhỏ, kho 40-50 phút đến khi thịt mềm, nước sốt hơi sệt.',
      'Bước 6: Nêm nếm lại, rắc tiêu và hành lá thái nhỏ. Dọn với cơm trắng.',
    ],
    nutrition: { calories: 480, protein: 30, carbohydrates: 12, fat: 35, fiber: 0, vitamin_c: 1, calcium: 40, iron: 3 },
    cooking_time: 70,
    difficulty: 'Trung bình',
    servings: 4,
    category: 'Món chính',
    tags: ['kho', 'nước dừa', 'truyền thống', 'miền Nam'],
    image_query: 'vietnamese pork egg braised caramel',
  },
  {
    name: 'Sườn xào chua ngọt',
    description: 'Sườn non chiên vàng giòn, sốt chua ngọt đỏ đẹp, hấp dẫn từ màu sắc đến hương vị.',
    keywords: ['thịt heo', 'heo', 'sườn'],
    ingredients: ['500g sườn non heo', '1 quả ớt chuông đỏ', '1 quả ớt chuông xanh', '1 củ hành tây', '3 thìa canh tương cà', '2 thìa canh giấm', '2 thìa canh đường', '1 thìa canh nước tương', 'Bột chiên giòn, dầu ăn'],
    instructions: [
      'Bước 1: Sườn chặt miếng vừa, ướp muối tiêu 15 phút rồi lăn qua bột chiên giòn.',
      'Bước 2: Chiên sườn trong dầu nóng đến vàng giòn, vớt ra để ráo.',
      'Bước 3: Ớt chuông thái miếng vừa, hành tây thái múi cau.',
      'Bước 4: Trộn sốt: tương cà + giấm + đường + nước tương + 3 thìa nước.',
      'Bước 5: Phi thơm tỏi, xào hành tây và ớt chuông 2 phút.',
      'Bước 6: Đổ sốt vào đun sôi, cho sườn vào đảo đều cho thấm sốt 3 phút rồi dọn.',
    ],
    nutrition: { calories: 440, protein: 25, carbohydrates: 22, fat: 28, fiber: 2, vitamin_c: 45, calcium: 35, iron: 2 },
    cooking_time: 40,
    difficulty: 'Trung bình',
    servings: 3,
    category: 'Món chính',
    tags: ['chua ngọt', 'chiên', 'giòn', 'hấp dẫn'],
    image_query: 'vietnamese sweet sour pork ribs',
  },

  // ====== TÔM ======
  {
    name: 'Tôm xào bơ tỏi',
    description: 'Tôm tươi xào bơ tỏi thơm béo, màu đỏ hấp dẫn, nhanh và dễ làm.',
    keywords: ['tôm'],
    ingredients: ['400g tôm tươi', '4 tép tỏi', '30g bơ lạt', '1 thìa canh nước mắm', 'Tiêu, hành lá, ngò rí', 'Ớt tươi (tùy chọn)'],
    instructions: [
      'Bước 1: Tôm rửa sạch, bóc vỏ, chừa đuôi, rút chỉ đen ở lưng.',
      'Bước 2: Tỏi băm nhỏ. Hành lá thái khúc.',
      'Bước 3: Làm tan chảy bơ trên chảo lửa vừa, phi thơm tỏi.',
      'Bước 4: Cho tôm vào xào lửa lớn, đảo liên tục 3-4 phút đến khi tôm chín đỏ.',
      'Bước 5: Nêm nước mắm, tiêu theo khẩu vị.',
      'Bước 6: Thêm hành lá và ngò rí, đảo đều 30 giây rồi tắt bếp. Dọn ngay khi còn nóng.',
    ],
    nutrition: { calories: 220, protein: 30, carbohydrates: 3, fat: 10, fiber: 0, vitamin_c: 5, calcium: 80, iron: 3 },
    cooking_time: 15,
    difficulty: 'Dễ',
    servings: 2,
    category: 'Món chính',
    tags: ['xào', 'bơ', 'tỏi', 'nhanh', 'hải sản'],
    image_query: 'garlic butter shrimp vietnamese',
  },
  {
    name: 'Canh chua tôm',
    description: 'Canh chua miền Nam thanh mát, tôm ngọt kết hợp rau chua đặc trưng, giải nhiệt ngày hè.',
    keywords: ['tôm', 'cà chua', 'cà'],
    ingredients: ['300g tôm tươi', '2 quả cà chua', '200g dứa (thơm)', '100g đậu bắp', 'Giá đỗ', '2 thìa canh mẻ chua (hoặc nước cốt me)', '2 thìa canh nước mắm', 'Đường, muối', 'Rau ngò om, hành lá'],
    instructions: [
      'Bước 1: Tôm rửa sạch, bóc vỏ. Cà chua cắt múi. Dứa thái miếng. Đậu bắp cắt khúc.',
      'Bước 2: Phi thơm hành với dầu, xào cà chua đến khi mềm.',
      'Bước 3: Đổ 1 lít nước vào, đun sôi. Cho dứa vào nấu 5 phút.',
      'Bước 4: Cho mẻ chua (hoặc nước cốt me) vào, nêm nước mắm, đường cho vừa miệng chua ngọt.',
      'Bước 5: Cho tôm và đậu bắp vào nấu đến khi tôm chín (3-4 phút).',
      'Bước 6: Cho giá đỗ, ngò om, hành lá vào. Tắt bếp, dọn ngay.',
    ],
    nutrition: { calories: 180, protein: 22, carbohydrates: 18, fat: 3, fiber: 4, vitamin_c: 30, calcium: 70, iron: 2 },
    cooking_time: 25,
    difficulty: 'Dễ',
    servings: 3,
    category: 'Súp/Canh',
    tags: ['canh chua', 'hải sản', 'miền Nam', 'thanh mát'],
    image_query: 'vietnamese sour soup shrimp canh chua',
  },

  // ====== TRỨNG ======
  {
    name: 'Trứng chiên cà chua',
    description: 'Món ăn quen thuộc của mọi gia đình, đơn giản nhưng đậm đà, ăn với cơm cực ngon.',
    keywords: ['trứng', 'cà chua', 'cà'],
    ingredients: ['4 quả trứng gà', '2 quả cà chua', '1 củ hành tây nhỏ', '2 tép tỏi', '1 thìa canh nước mắm', 'Đường, muối, tiêu', 'Hành lá, dầu ăn'],
    instructions: [
      'Bước 1: Đập trứng vào tô, thêm chút muối và đánh đều.',
      'Bước 2: Cà chua cắt múi. Hành tây thái múi cau. Tỏi băm.',
      'Bước 3: Cho dầu vào chảo nóng, đổ trứng vào chiên vàng 2 mặt, cắt miếng vừa ăn.',
      'Bước 4: Phi thơm tỏi và hành tây, cho cà chua vào xào đến khi mềm nhừ.',
      'Bước 5: Nêm nước mắm, đường, tiêu cho vừa miệng.',
      'Bước 6: Cho trứng vào đảo nhẹ, thêm hành lá, tắt bếp và dọn ngay.',
    ],
    nutrition: { calories: 220, protein: 14, carbohydrates: 8, fat: 15, fiber: 1, vitamin_c: 15, calcium: 60, iron: 2 },
    cooking_time: 15,
    difficulty: 'Dễ',
    servings: 2,
    category: 'Món chính',
    tags: ['trứng', 'cà chua', 'nhanh', 'đơn giản', 'gia đình'],
    image_query: 'vietnamese tomato egg stir fry',
  },
  {
    name: 'Trứng hấp thịt bằm',
    description: 'Trứng hấp mịn mượt, thịt bằm thấm đều gia vị, món ngon dễ ăn cho cả trẻ em và người lớn.',
    keywords: ['trứng', 'thịt heo', 'heo', 'thịt'],
    ingredients: ['4 quả trứng gà', '150g thịt heo xay', '50g miến', '30g mộc nhĩ', '1 thìa canh nước mắm', 'Hành lá, tiêu', 'Dầu mè'],
    instructions: [
      'Bước 1: Miến ngâm nước ấm 10 phút, cắt ngắn. Mộc nhĩ ngâm nở, thái sợi.',
      'Bước 2: Trộn thịt xay với miến, mộc nhĩ, hành lá, nước mắm, tiêu đều tay.',
      'Bước 3: Đập trứng vào tô lớn, đánh tan. Cho hỗn hợp thịt vào trộn đều.',
      'Bước 4: Đổ hỗn hợp vào tô hấp, dàn đều.',
      'Bước 5: Hấp cách thủy lửa vừa 20-25 phút đến khi trứng đông cứng.',
      'Bước 6: Nhỏ vài giọt dầu mè lên, rắc tiêu và hành lá thái nhỏ rồi dọn.',
    ],
    nutrition: { calories: 260, protein: 22, carbohydrates: 10, fat: 15, fiber: 1, vitamin_c: 2, calcium: 55, iron: 3 },
    cooking_time: 35,
    difficulty: 'Dễ',
    servings: 3,
    category: 'Món chính',
    tags: ['hấp', 'trứng', 'thịt bằm', 'dễ ăn'],
    image_query: 'vietnamese steamed egg pork mince',
  },

  // ====== CÁ ======
  {
    name: 'Cá kho tộ',
    description: 'Cá kho nước dừa đậm đà, ngọt béo truyền thống miền Nam, ăn với cơm trắng không thể cưỡng.',
    keywords: ['cá'],
    ingredients: ['500g cá (cá basa, cá thu, hoặc cá lóc)', '200ml nước dừa tươi', '3 thìa canh nước mắm', '2 thìa canh đường', '2 thìa canh nước màu', '3 tép tỏi', '2 củ sả', 'Tiêu, ớt, hành lá'],
    instructions: [
      'Bước 1: Cá rửa sạch với nước muối và gừng, cắt khúc vừa ăn, để ráo.',
      'Bước 2: Sả đập dập cắt khúc. Tỏi băm.',
      'Bước 3: Ướp cá với tỏi, nước mắm, đường, nước màu, tiêu 20 phút.',
      'Bước 4: Xếp sả dưới đáy nồi đất (hoặc nồi thường), xếp cá lên trên.',
      'Bước 5: Đổ nước dừa vào, đun sôi rồi hạ lửa nhỏ kho 30-40 phút.',
      'Bước 6: Kho đến khi nước cạn sệt, cá thấm gia vị. Rắc tiêu, ớt, hành lá.',
    ],
    nutrition: { calories: 280, protein: 32, carbohydrates: 10, fat: 12, fiber: 0, vitamin_c: 2, calcium: 40, iron: 2 },
    cooking_time: 55,
    difficulty: 'Trung bình',
    servings: 3,
    category: 'Món chính',
    tags: ['kho', 'nước dừa', 'truyền thống', 'miền Nam'],
    image_query: 'vietnamese braised fish clay pot ca kho to',
  },

  // ====== ĐẬU PHỤ ======
  {
    name: 'Đậu phụ sốt cà chua',
    description: 'Đậu phụ chiên vàng giòn, sốt cà chua chua ngọt thơm, món chay đơn giản mà ngon.',
    keywords: ['đậu phụ', 'đậu', 'cà chua', 'cà'],
    ingredients: ['300g đậu phụ', '2 quả cà chua', '2 tép tỏi', '1 thìa canh nước tương', 'Đường, muối', 'Hành lá, dầu ăn'],
    instructions: [
      'Bước 1: Đậu phụ cắt miếng vuông, thấm khô bằng giấy. Chiên vàng giòn đều các mặt.',
      'Bước 2: Cà chua cắt múi. Tỏi băm nhỏ.',
      'Bước 3: Phi thơm tỏi với 1 thìa dầu, cho cà chua vào xào đến khi mềm nhừ.',
      'Bước 4: Nêm nước tương, đường, muối cho vừa miệng chua ngọt.',
      'Bước 5: Cho đậu phụ chiên vào, đảo nhẹ cho thấm sốt 2 phút.',
      'Bước 6: Thêm hành lá thái nhỏ, tắt bếp và dọn ngay.',
    ],
    nutrition: { calories: 190, protein: 12, carbohydrates: 12, fat: 10, fiber: 2, vitamin_c: 18, calcium: 120, iron: 2 },
    cooking_time: 20,
    difficulty: 'Dễ',
    servings: 2,
    category: 'Món chính',
    tags: ['chay', 'đậu phụ', 'cà chua', 'đơn giản'],
    image_query: 'tofu tomato sauce vietnamese vegan',
  },

  // ====== RAU CỦ ======
  {
    name: 'Canh rau cải thịt bằm',
    description: 'Canh ngọt thanh từ rau cải và thịt bằm, nấu nhanh, bổ dưỡng cho bữa cơm hằng ngày.',
    keywords: ['rau cải', 'cải', 'thịt heo', 'heo', 'thịt'],
    ingredients: ['300g rau cải xanh', '150g thịt heo xay', '2 tép tỏi', '1 thìa canh nước mắm', 'Muối, tiêu, đường', 'Hành lá'],
    instructions: [
      'Bước 1: Rau cải nhặt sạch, cắt khúc 5cm. Tỏi băm nhỏ.',
      'Bước 2: Thịt xay ướp nhẹ với muối, tiêu, nước mắm.',
      'Bước 3: Phi thơm tỏi với dầu, cho thịt xay vào xào đến khi chín tơi.',
      'Bước 4: Đổ 700ml nước vào, đun sôi và hớt bọt.',
      'Bước 5: Cho rau cải vào nấu 3-4 phút đến khi vừa chín tới.',
      'Bước 6: Nêm nước mắm, muối, đường cho vừa. Thêm hành lá rồi tắt bếp.',
    ],
    nutrition: { calories: 180, protein: 18, carbohydrates: 6, fat: 8, fiber: 3, vitamin_c: 40, calcium: 90, iron: 3 },
    cooking_time: 20,
    difficulty: 'Dễ',
    servings: 3,
    category: 'Súp/Canh',
    tags: ['canh', 'rau xanh', 'thịt bằm', 'nhanh'],
    image_query: 'vietnamese pork mince vegetable soup',
  },
  {
    name: 'Rau muống xào tỏi',
    description: 'Món rau xào giòn ngọt, tỏi phi thơm nức, đơn giản nhất mà đậm đà nhất.',
    keywords: ['rau muống', 'rau', 'tỏi'],
    ingredients: ['500g rau muống', '5 tép tỏi', '1 thìa canh nước mắm', 'Muối, dầu ăn'],
    instructions: [
      'Bước 1: Rau muống ngắt bỏ phần già, rửa sạch, để ráo. Tỏi đập dập hoặc thái lát.',
      'Bước 2: Làm nóng chảo với 2 thìa dầu lửa lớn.',
      'Bước 3: Phi thơm tỏi vàng.',
      'Bước 4: Cho rau muống vào xào lửa thật lớn, đảo liên tục.',
      'Bước 5: Nêm nước mắm, muối, xào thêm 1-2 phút đến khi rau vừa chín tới.',
      'Bước 6: Dọn ra đĩa ngay, ăn nóng với cơm trắng.',
    ],
    nutrition: { calories: 80, protein: 4, carbohydrates: 8, fat: 4, fiber: 3, vitamin_c: 55, calcium: 70, iron: 2 },
    cooking_time: 10,
    difficulty: 'Dễ',
    servings: 2,
    category: 'Món phụ',
    tags: ['chay', 'rau xanh', 'xào', 'nhanh', 'thanh đạm'],
    image_query: 'stir fried morning glory garlic vietnamese',
  },
  {
    name: 'Canh chua cà chua trứng',
    description: 'Canh chua cà chua và trứng đơn giản, thơm ngon, giải nhiệt tốt, dễ nấu cho ngày bận.',
    keywords: ['trứng', 'cà chua', 'cà'],
    ingredients: ['3 quả trứng gà', '3 quả cà chua', '1 thìa canh nước mắm', 'Muối, đường', 'Hành lá, ngò rí', 'Dầu ăn'],
    instructions: [
      'Bước 1: Cà chua cắt múi vừa. Đập trứng vào tô, đánh đều với chút muối.',
      'Bước 2: Phi thơm hành với dầu, cho cà chua vào xào mềm.',
      'Bước 3: Đổ 600ml nước vào đun sôi.',
      'Bước 4: Nêm nước mắm, đường, muối cho vừa vị.',
      'Bước 5: Đổ trứng vào theo vòng tròn, khuấy nhẹ.',
      'Bước 6: Đun sôi lại, cho hành lá và ngò rí, tắt bếp.',
    ],
    nutrition: { calories: 150, protein: 10, carbohydrates: 8, fat: 8, fiber: 1, vitamin_c: 20, calcium: 50, iron: 2 },
    cooking_time: 15,
    difficulty: 'Dễ',
    servings: 2,
    category: 'Súp/Canh',
    tags: ['canh', 'cà chua', 'trứng', 'nhanh', 'đơn giản'],
    image_query: 'vietnamese tomato egg drop soup',
  },
  {
    name: 'Khoai tây xào bơ',
    description: 'Khoai tây xào bơ thơm béo, mềm bên trong, vàng giòn bên ngoài, món ăn vặt hay ăn kèm tuyệt vời.',
    keywords: ['khoai tây', 'khoai'],
    ingredients: ['400g khoai tây', '30g bơ lạt', '2 tép tỏi', 'Muối, tiêu', 'Rau mùi tây (parsley)'],
    instructions: [
      'Bước 1: Khoai tây gọt vỏ, cắt hạt lựu hoặc thanh que. Ngâm nước muối 10 phút, để ráo.',
      'Bước 2: Luộc khoai tây trong nước muối 5 phút, vớt ra để ráo.',
      'Bước 3: Tan chảy bơ trong chảo lớn, phi thơm tỏi thái lát.',
      'Bước 4: Cho khoai tây vào xào lửa vừa đến khi vàng đều.',
      'Bước 5: Nêm muối, tiêu cho vừa miệng.',
      'Bước 6: Rắc rau mùi tây thái nhỏ, dọn nóng.',
    ],
    nutrition: { calories: 220, protein: 4, carbohydrates: 38, fat: 7, fiber: 4, vitamin_c: 20, calcium: 20, iron: 1 },
    cooking_time: 25,
    difficulty: 'Dễ',
    servings: 2,
    category: 'Món phụ',
    tags: ['khoai tây', 'bơ', 'đơn giản', 'ăn vặt'],
    image_query: 'butter sauteed potatoes golden crispy',
  },
  {
    name: 'Súp bí đỏ kem',
    description: 'Súp bí đỏ sánh mịn, béo thơm, màu vàng đẹp mắt, bổ dưỡng cho cả gia đình.',
    keywords: ['bí đỏ', 'bí'],
    ingredients: ['500g bí đỏ', '1 củ hành tây', '200ml kem tươi (hoặc nước cốt dừa)', '500ml nước dùng gà', '2 thìa canh bơ', 'Muối, tiêu, nhục đậu khấu'],
    instructions: [
      'Bước 1: Bí đỏ gọt vỏ, bỏ ruột, cắt miếng. Hành tây thái hạt lựu.',
      'Bước 2: Tan chảy bơ trong nồi, phi thơm hành tây.',
      'Bước 3: Cho bí đỏ vào xào 3 phút.',
      'Bước 4: Đổ nước dùng gà vào, đun sôi rồi hạ lửa nấu 20 phút đến khi bí mềm.',
      'Bước 5: Xay nhuyễn bằng máy xay sinh tố hoặc máy xay cầm tay.',
      'Bước 6: Đổ kem tươi vào, nêm muối tiêu nhục đậu khấu. Đun nóng lại và dọn.',
    ],
    nutrition: { calories: 200, protein: 4, carbohydrates: 22, fat: 12, fiber: 3, vitamin_c: 18, calcium: 55, iron: 1 },
    cooking_time: 35,
    difficulty: 'Dễ',
    servings: 4,
    category: 'Súp/Canh',
    tags: ['súp', 'bí đỏ', 'kem', 'mịn', 'bổ dưỡng'],
    image_query: 'pumpkin cream soup golden Vietnamese',
  },

  // ====== MÌ/BÚN ======
  {
    name: 'Mì xào hải sản',
    description: 'Mì xào hải sản đậm đà kiểu Việt, tôm mực giòn ngọt, mì dai vừa.',
    keywords: ['mì', 'tôm', 'hải sản'],
    ingredients: ['200g mì trứng', '150g tôm', '100g mực', '1 củ hành tây', '1 quả ớt chuông', '2 thìa canh dầu hào', '1 thìa canh nước tương', 'Tỏi, dầu ăn, hành lá'],
    instructions: [
      'Bước 1: Luộc mì chín tới, trụng qua nước lạnh, để ráo.',
      'Bước 2: Tôm bóc vỏ, mực cắt khoanh. Hành tây và ớt chuông thái sợi.',
      'Bước 3: Phi thơm tỏi, xào tôm mực lửa lớn đến khi chín, vớt ra.',
      'Bước 4: Xào hành tây và ớt chuông 2 phút.',
      'Bước 5: Cho mì vào xào cùng, thêm dầu hào và nước tương, đảo đều.',
      'Bước 6: Cho hải sản lại vào, thêm hành lá, đảo đều 1 phút rồi dọn.',
    ],
    nutrition: { calories: 380, protein: 28, carbohydrates: 42, fat: 10, fiber: 2, vitamin_c: 25, calcium: 60, iron: 3 },
    cooking_time: 25,
    difficulty: 'Trung bình',
    servings: 2,
    category: 'Món chính',
    tags: ['mì xào', 'hải sản', 'nhanh'],
    image_query: 'Vietnamese stir fried noodles seafood',
  },
  {
    name: 'Bún bò Huế',
    description: 'Bún bò Huế cay đậm đà đặc trưng miền Trung, nước dùng thơm sả, thịt bò mềm.',
    keywords: ['bún', 'thịt bò', 'bò', 'sả'],
    ingredients: ['300g bún tươi', '300g thịt bò bắp', '100g giò heo', '2 cây sả', '1 thìa canh ruốc Huế', '2 thìa canh ớt bột', 'Hành tím, tỏi', 'Rau sống: bắp chuối, rau muống'],
    instructions: [
      'Bước 1: Ninh xương bò với sả đập dập lấy 1.5 lít nước dùng.',
      'Bước 2: Thịt bò bắp và giò heo luộc chín, thái lát.',
      'Bước 3: Phi thơm tỏi và hành tím với ít dầu. Cho ruốc Huế và ớt bột vào xào thơm.',
      'Bước 4: Đổ hỗn hợp gia vị vào nước dùng, đun sôi 10 phút.',
      'Bước 5: Nêm muối, nước mắm, đường cho vừa vị cay mặn đặc trưng.',
      'Bước 6: Bún trụng nước sôi, xếp vào tô, thêm thịt, chan nước dùng nóng. Ăn kèm rau sống.',
    ],
    nutrition: { calories: 420, protein: 28, carbohydrates: 45, fat: 14, fiber: 3, vitamin_c: 10, calcium: 50, iron: 4 },
    cooking_time: 90,
    difficulty: 'Khó',
    servings: 4,
    category: 'Món chính',
    tags: ['bún bò', 'Huế', 'cay', 'truyền thống'],
    image_query: 'Vietnamese bun bo Hue spicy beef noodle soup',
  },
];

/**
 * Tìm món ăn phù hợp dựa trên nguyên liệu - thuật toán matching
 */
export function findMatchingRecipes(
  userIngredients: string[],
  count: number = 4
): RecipeData[] {
  const normalizedUser = userIngredients.map(i => i.toLowerCase().trim());

  // Tính điểm match cho từng công thức
  const scored = VIETNAMESE_RECIPES.map(recipe => {
    let score = 0;
    let matchedKeywords = 0;

    for (const keyword of recipe.keywords) {
      const kwLower = keyword.toLowerCase();
      for (const userIng of normalizedUser) {
        // Exact or partial match
        if (
          userIng.includes(kwLower) ||
          kwLower.includes(userIng) ||
          levenshteinSimilar(userIng, kwLower)
        ) {
          matchedKeywords++;
          score += 10;
          break;
        }
      }
    }

    // Bonus nếu match nhiều keyword chính
    if (matchedKeywords >= recipe.keywords.length) score += 20;
    if (matchedKeywords >= 2) score += 10;

    return { recipe, score };
  });

  // Sắp xếp theo điểm giảm dần, lấy top N
  const sorted = scored
    .filter(s => s.score > 0)
    .sort((a, b) => b.score - a.score);

  // Nếu không đủ, lấy thêm ngẫu nhiên
  const result = sorted.slice(0, count).map(s => s.recipe);

  if (result.length < count) {
    const remaining = VIETNAMESE_RECIPES.filter(r => !result.includes(r));
    const shuffled = remaining.sort(() => Math.random() - 0.5);
    result.push(...shuffled.slice(0, count - result.length));
  }

  return result.slice(0, count);
}

function levenshteinSimilar(a: string, b: string): boolean {
  if (Math.abs(a.length - b.length) > 3) return false;
  // Simple: check if one contains significant portion of other
  if (a.length >= 3 && b.includes(a.slice(0, 3))) return true;
  if (b.length >= 3 && a.includes(b.slice(0, 3))) return true;
  return false;
}
