import { crawlCookpadImagesLive } from '../services/image.service';
import { getPool } from './db';
import { initializeDatabase } from './init';

const POPULAR_DISHES = [
  // Món Đậu phụ / Đậu hũ
  'đậu hũ nhồi thịt sốt cà chua',
  'đậu phụ sốt cà chua',
  'đậu hũ chiên sả ớt',
  'canh đậu phụ cà chua',
  'đậu hũ non sốt thịt băm',
  'đậu phụ chiên giòn',

  // Món Thịt gà
  'gà sốt cà chua',
  'ức gà xào cà chua',
  'gà kho gừng',
  'gà kho sả ớt',
  'gà rang sả ớt',
  'gà xào sả ớt',
  'canh gà nấu nấm',
  'canh gà lá giang',
  'canh gà đậu hũ',
  'gà chiên nước mắm',
  'gà hấp lá chanh',
  'cháo gà',

  // Món Thịt heo / Sườn
  'thịt ba chỉ kho trứng',
  'thịt heo xào chua ngọt',
  'thịt băm xào cà chua',
  'thịt kho tàu',
  'thịt heo luộc chấm mắm tôm',
  'sườn xào chua ngọt',
  'canh sườn nấu chua',
  'thịt ba chỉ rang cháy cạnh',

  // Món Thịt Bò
  'bò xào hành tây cà chua',
  'bò xào cần tỏi',
  'canh thịt bò cà chua',
  'bò lúc lắc',
  'bò né hành tây',
  'bò sốt vang',
  'gân bò hầm dưa chua',
  'bò cuộn nấm kim châm',
  'bò kho',

  // Món Tôm & Hải sản
  'tôm rim thịt ba chỉ',
  'tôm rang thịt',
  'tôm xào rau củ',
  'canh chua tôm',
  'mực xào cần tỏi',
  'canh ngao nấu chua',
  'cá kho tộ',
  'cá sốt cà chua',
  'canh chua cá lóc',

  // Món Trứng & Canh rau
  'trứng chiên cà chua',
  'trứng đúc thịt',
  'canh cua mồng tơi',
  'rau muống xào tỏi',
  'canh mướp đắng nhồi thịt',
  'canh cải thịt băm'
];

async function seedCookpadImages() {
  console.log('🔄 Bắt đầu dọn dẹp và nạp cơ sở dữ liệu ảnh thực tế chuẩn xác từ Cookpad Việt Nam...');
  await initializeDatabase();
  const pool = getPool();

  // Xóa sạch các ảnh cũ để tránh lưu ảnh rác/bento trước đó
  await pool.query('TRUNCATE TABLE cookpad_dish_images');
  console.log('🧹 Đã làm sạch bảng cookpad_dish_images.');

  let successCount = 0;
  for (const dish of POPULAR_DISHES) {
    try {
      console.log(`📡 Đang cào ảnh Cookpad cho: "${dish}"...`);
      const images = await crawlCookpadImagesLive(dish);
      if (images.length > 0) {
        successCount++;
        console.log(`   ✅ Lấy được ${images.length} ảnh chuẩn cho "${dish}"`);
      }
      // Nghỉ 250ms giữa các request
      await new Promise(r => setTimeout(r, 250));
    } catch (err: any) {
      console.error(`   ❌ Lỗi khi cào món "${dish}":`, err.message);
    }
  }

  const [totalRows]: any = await pool.query('SELECT COUNT(*) as cnt FROM cookpad_dish_images');
  console.log(`\n🎉 Hoàn thành! Cơ sở dữ liệu Cookpad hiện có tổng cộng ${totalRows[0].cnt} hình ảnh món ăn thực tế đã qua lọc thông minh.`);
  process.exit(0);
}

seedCookpadImages().catch(console.error);
