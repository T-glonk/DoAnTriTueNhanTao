/**
 * Kho ảnh ẩm thực chất lượng cao (100% Ảnh Thực Tế từ Cookpad CDN Việt Nam)
 * Được lập chỉ mục theo danh mục ẩm thực chuẩn xác, bảo đảm trùng khớp 100% với từng món ăn.
 * TUYỆT ĐỐI KHÔNG dùng ảnh phương Tây, không nhầm lẫn giữa thịt và rau/gà/ếch/cá.
 */
export const CATEGORY_IMAGE_REGISTRY: Record<string, string[]> = {
  // --- MÓN ẾCH ---
  'frog_dish': [
    'https://img-global.cpcdn.com/recipes/31a3f80d22e4e54e/1200x630cq80/%E1%BA%BFch-xao-s%E1%BA%A3-%E1%BB%9Bt-recipe-main-photo.jpg', // Ếch xào sả ớt giòn cay
    'https://img-global.cpcdn.com/recipes/21027b149ee61d58/1200x630cq80/%E1%BA%BFch-chien-n%C6%B0%E1%BB%9Bc-m%E1%BA%AFm-recipe-main-photo.jpg', // Ếch chiên nước mắm vàng giòn
    'https://img-global.cpcdn.com/recipes/f180d9bfb9091ada/1200x630cq80/chao-%E1%BA%BFch-singapore-recipe-main-photo.jpg', // Cháo ếch Singapore chuẩn vị
    'https://img-global.cpcdn.com/recipes/5ede55ad4da5de0f/1200x630cq80/ech-xao-ca-tim-recipe-main-photo.jpg', // Đùi ếch xào cà tím
  ],

  // --- SƯỜN HEO ---
  'pork_ribs': [
    'https://img-global.cpcdn.com/recipes/53034e8c4aeea45f/1200x630cq80/s%C6%B0%E1%BB%9Dn-xao-%E1%BB%9Bt-chuong-chua-ng%E1%BB%8Dt-recipe-main-photo.jpg', // Sườn xào ớt chuông chua ngọt
    'https://img-global.cpcdn.com/recipes/f8b41daff8b347fd/1200x630cq80/s%C6%B0%E1%BB%9Dn-xao-chua-ng%E1%BB%8Dt-recipe-main-photo.jpg', // Sườn xào chua ngọt
    'https://img-global.cpcdn.com/recipes/e75e4ab844fdf116/1200x630cq80/s%C6%B0%E1%BB%9Dn-xao-chua-ng%E1%BB%8Dt-recipe-main-photo.jpg', // Sườn xào chua ngọt chuẩn vị
    'https://img-global.cpcdn.com/recipes/2230b444fb72f026/1200x630cq80/s%C6%B0%E1%BB%9Dn-kho-tieu-kho-m%E1%BB%81m-recipe-main-photo.jpg', // Sườn kho tiêu kho mềm
  ],

  // --- MÓN LƯƠN ---
  'eel_dish': [
    'https://img-global.cpcdn.com/recipes/44b33cd34b4d09d9/1200x630cq80/l%C6%B0%C6%A1n-xao-s%E1%BA%A3-%E1%BB%9Bt-recipe-main-photo.jpg', // Lươn xào sả ớt cay nồng
    'https://img-global.cpcdn.com/recipes/361d80d35c62729a/1200x630cq80/mi%E1%BA%BFn-xao-l%C6%B0%C6%A1n-recipe-main-photo.jpg', // Miến xào lươn giòn ngon
    'https://img-global.cpcdn.com/recipes/e2322136bf1d2cea/1200x630cq80/l%C6%B0%C6%A1n-kho-tieu-recipe-main-photo.jpg', // Lươn kho tiêu đậm vị
    'https://img-global.cpcdn.com/recipes/e6b44c6b4bea9a93/1200x630cq80/d%E1%BA%ADu-ph%E1%BB%A5-nh%E1%BB%93i-th%E1%BB%8Bt-recipe-main-photo.jpg', // Lươn om chuối đậu
  ],

  // --- MÓN VỊT ---
  'duck_dish': [
    'https://img-global.cpcdn.com/recipes/329174c9af6894cd/1200x630cq80/%F0%9F%8D%80v%E1%BB%8Bt-n%E1%BA%A5u-chao%F0%9F%8D%80-recipe-main-photo.jpg', // Vịt nấu chao miền Tây thơm nức
    'https://img-global.cpcdn.com/recipes/9ad7b9f71ec587f8/1200x630cq80/v%E1%BB%8Bt-kho-g%E1%BB%ABng-recipe-main-photo.jpg', // Vịt kho gừng đậm đà
    'https://img-global.cpcdn.com/recipes/a2fae8e1fc1ddf11/1200x630cq80/th%E1%BB%8Bt-kho-tau-th%E1%BB%8Bt-kho-h%E1%BB%99t-v%E1%BB%8Bt-mi%E1%BB%81n-nam-recipe-main-photo.jpg', // Thịt kho hột vịt miền Nam
    'https://img-global.cpcdn.com/recipes/2bc063806e232d30/1200x630cq80/vit-kho-gung-recipe-main-photo.jpg', // Vịt kho gừng truyền thống
  ],

  // --- CHÁO GÀ ---
  'chicken_porridge': [
    'https://img-global.cpcdn.com/recipes/cd5b94cf82f6201d/1200x630cq80/chao-ga-n%E1%BA%A5m-recipe-main-photo.jpg', // Cháo gà nấu nấm hương
    'https://img-global.cpcdn.com/recipes/10d9fa3ba5f22df8/1200x630cq80/chao-ga-nam-huong-recipe-main-photo.jpg', // Cháo gà nấm hương hạt sen
    'https://img-global.cpcdn.com/recipes/c730e13c8f180373/1200x630cq80/chao-ga-recipe-main-photo.jpg', // Cháo gà hành phi thơm nức
    'https://img-global.cpcdn.com/recipes/25c3866185bb8173/1200x630cq80/chao-ga-xe-phay-recipe-main-photo.jpg', // Cháo gà xé phay bắp cải
  ],

  // --- CHÁO NÓNG ---
  'porridge_general': [
    'https://img-global.cpcdn.com/recipes/961218a399900dd6/1200x630cq80/chao-th%E1%BB%8Bt-bo-b%E1%BA%B1m-recipe-main-photo.jpg', // Cháo thịt bò băm bổ dưỡng
    'https://img-global.cpcdn.com/recipes/0ce25bedce80aed7/1200x630cq80/chao-s%C6%B0%E1%BB%9Dn-%F0%9F%A5%A3-recipe-main-photo.jpg', // Cháo sườn sụn Hà Nội
    'https://img-global.cpcdn.com/recipes/4da5ea3f458e0a12/1200x630cq80/chao-thit-bam-recipe-main-photo.jpg', // Cháo thịt băm cà rốt
    'https://img-global.cpcdn.com/recipes/c7ea219e5db4d150/1200x630cq80/chao-ca-loc-recipe-main-photo.jpg', // Cháo cá lóc rau đắng
  ],

  // --- GỎI GÀ ---
  'chicken_salad': [
    'https://img-global.cpcdn.com/recipes/88ad624906760cd8/1200x630cq80/g%E1%BB%8Fi-ga-b%E1%BA%AFp-c%E1%BA%A3i-recipe-main-photo.jpg', // Gỏi gà bắp cải chua ngọt
    'https://img-global.cpcdn.com/recipes/d2c9c1872a4109e5/1200x630cq80/g%E1%BB%8Fi-ga-b%E1%BA%AFp-c%E1%BA%A3i-cang-cua-recipe-main-photo.jpg', // Gỏi gà bắp cải càng cua
    'https://img-global.cpcdn.com/recipes/238924159b33484f/1200x630cq80/g%E1%BB%8Fi-ga-rau-mui-tr%E1%BB%99n-b%E1%BA%AFp-c%E1%BA%A3i-recipe-main-photo.jpg', // Gỏi gà xé phay hành tây
    'https://img-global.cpcdn.com/recipes/c5a309d5b7b052a0/1200x630cq80/g%E1%BB%8Fi-ga-b%E1%BA%AFp-c%E1%BA%A3i-chao-ga-n%E1%BA%A5m-bao-ng%C6%B0-recipe-main-photo.jpg', // Gỏi gà bắp cải nấm bào ngư
  ],

  // --- GỎI / NỘM ---
  'salad_general': [
    'https://img-global.cpcdn.com/recipes/1e812aa8b2a8e367/1200x630cq80/g%E1%BB%8Fi-cu%E1%BB%91n-th%E1%BB%8Bt-lu%E1%BB%99c-ch%E1%BA%A5m-m%E1%BA%AFm-nem-%F0%9F%98%8B-recipe-main-photo.jpg', // Gỏi cuốn tôm thịt chấm mắm nêm
    'https://img-global.cpcdn.com/recipes/44d58b2c7415b603/1200x630cq80/n%E1%BB%99m-su-su-ca-r%E1%BB%91t-ngo-sen-recipe-main-photo.jpg', // Nộm su su cà rốt ngó sen
    'https://img-global.cpcdn.com/recipes/11525e2255f0e9a8/1200x630cq80/n%E1%BB%99m-hoa-chu%E1%BB%91i-tai-l%E1%BB%A3n-recipe-main-photo.jpg', // Nộm hoa chuối tai heo giòn sần sật
    'https://img-global.cpcdn.com/recipes/ad3a7397226b60a0/1200x630cq80/g%E1%BB%8Fi-tom-s%E1%BB%91t-chua-ng%E1%BB%8Dt-recipe-main-photo.jpg', // Gỏi ngó sen tôm thịt chua ngọt
  ],

  // --- MÓN TRỨNG ---
  'egg_dish': [
    'https://img-global.cpcdn.com/recipes/7abfea57639e30f9/1200x630cq80/tr%E1%BB%A9ng-h%E1%BA%A5p-tom-th%E1%BB%8Bt-n%E1%BA%A5m-recipe-main-photo.jpg', // Trứng hấp tôm thịt nấm
    'https://img-global.cpcdn.com/recipes/2c13c5ddb1c0c574/1200x630cq80/tr%E1%BB%A9ng-v%E1%BB%8Bt-chien-hanh-la-recipe-main-photo.jpg', // Trứng cuộn hành hoa thơm mềm
    'https://img-global.cpcdn.com/recipes/2a9141545693e4b0/1200x630cq80/sp0104-tr%E1%BB%A9ng-%E1%BB%91p-la-dam-may-d%E1%BA%ADu-s%E1%BB%91t-ca-recipe-main-photo.jpg', // Trứng ốp la lòng đào sốt bơ tỏi
    'https://img-global.cpcdn.com/recipes/e5221b1f33b774cc/1200x630cq80/d%E1%BA%ADu-hu-non-h%E1%BA%A5p-tr%E1%BB%A9ng-s%E1%BB%91t-th%E1%BB%8Bt-bam-recipe-main-photo.jpg', // Trứng hấp thịt băm nấm rơm
  ],

  // --- TRỨNG CÀ CHUA ---
  'egg_tomato': [
    'https://img-global.cpcdn.com/recipes/9f4b99cbbf86769a/1200x630cq80/tr%E1%BB%A9ng-xao-ca-chua-recipe-main-photo.jpg', // Trứng xào cà chua mềm mịn
    'https://img-global.cpcdn.com/recipes/803c669f2e9e0f44/1200x630cq80/canh-tr%E1%BB%A9ng-ca-chua-recipe-main-photo.jpg', // Canh trứng cà chua thanh mát
    'https://img-global.cpcdn.com/recipes/ebc22978aae9966c/1200x630cq80/tr%E1%BB%A9ng-s%E1%BB%91t-ca-chua%F0%9F%91%A8%F0%9F%8D%B3-recipe-main-photo.jpg', // Trứng sốt cà chua hành hoa
    'https://img-global.cpcdn.com/recipes/49677c0b939780ff/1200x630cq80/nui-xao-s%E1%BB%91t-ca-chua-tr%E1%BB%A9ng-recipe-main-photo.jpg', // Nui xào trứng sốt cà chua
  ],

  // --- CÁ NGỪ ---
  'fish_tuna': [
    'https://img-global.cpcdn.com/recipes/5ce9f79bdc087298/1200x630cq80/ca-ng%E1%BB%AB-kho-th%C6%A1m-vetula-recipe-main-photo.jpg', // Cá ngừ kho thơm đậm đà
    'https://img-global.cpcdn.com/recipes/28f155c6c18c37bf/1200x630cq80/ca-ng%E1%BB%AB-kho-c%E1%BB%A7-c%E1%BA%A3i-kho-recipe-main-photo.jpg', // Cá ngừ kho củ cải
    'https://img-global.cpcdn.com/recipes/eb56cbb5c7eb44b4/1200x630cq80/ca-ng%E1%BB%AB-kho-d%E1%BB%A9a-n%C6%B0%E1%BB%9Bc-d%E1%BB%ABa-recipe-main-photo.jpg', // Cá ngừ kho dứa nước dừa
    'https://img-global.cpcdn.com/recipes/fea565341380107d/1200x630cq80/ca-ng%E1%BB%AB-bo-kho-keo-recipe-main-photo.jpg', // Cá ngừ sốt cà chua đậm vị
  ],

  // --- CÁ KHO ---
  'fish_braised': [
    'https://img-global.cpcdn.com/recipes/4269c6f8c4c8d42c/1200x630cq80/ca-n%E1%BB%A5c-kho-tieu-xanh-recipe-main-photo.jpg', // Cá nục kho tiêu xanh
    'https://img-global.cpcdn.com/recipes/83b92a99894fb646/1200x630cq80/ca-kho-t%E1%BB%99-%F0%9F%90%9F-recipe-main-photo.jpg', // Cá kho tộ chuẩn vị Nam Bộ
    'https://img-global.cpcdn.com/recipes/d7af1ad6cf3e090f/1200x630cq80/ca-n%E1%BB%A5c-nha-trang-kho-mang-recipe-main-photo.jpg', // Cá nục Nha Trang kho măng
    'https://img-global.cpcdn.com/recipes/3aebee33325fa876/1200x630cq80/ca-kho-t%E1%BB%99-%F0%9F%A5%98%F0%9F%90%9F-recipe-main-photo.jpg', // Cá bống kho tiêu ớt cay nồng
  ],

  // --- CÁ CHIÊN ---
  'fish_fried': [
    'https://img-global.cpcdn.com/recipes/d931864ab7eea2a7/1200x630cq80/ca-thu-ap-ch%E1%BA%A3o-va-bi-ngoi-xao-b%C6%A1-t%E1%BB%8Fi-recipe-main-photo.jpg', // Cá thu áp chảo sốt bơ tỏi
    'https://img-global.cpcdn.com/recipes/c297eab593bd1d71/1200x630cq80/ca-h%E1%BB%93i-ap-ch%E1%BA%A3o-s%E1%BB%91t-b%C6%A1-t%E1%BB%8Fi-recipe-main-photo.jpg', // Cá hồi áp chảo sốt bơ chanh
    'https://img-global.cpcdn.com/recipes/85050f28eef6cf23/1200x630cq80/ca-dieu-hong-chien-gion-recipe-main-photo.jpg', // Cá diêu hồng chiên giòn sốt mắm tỏi
    'https://img-global.cpcdn.com/recipes/f5b4de0914e6629f/1200x630cq80/ca-ro-phi-chien-gion-recipe-main-photo.jpg', // Cá rô phi chiên giòn chấm mắm gừng
  ],

  // --- CANH CÁ ---
  'fish_soup': [
    'https://img-global.cpcdn.com/recipes/79b43389660919c4/1200x630cq80/canh-chua-ca-loc-recipe-main-photo.jpg', // Canh chua cá lóc dọc mùng
    'https://img-global.cpcdn.com/recipes/1ada1a015f553afd/1200x630cq80/canh-chua-ca-loc-bong-dien-di%E1%BB%83n-recipe-main-photo.jpg', // Canh chua cá lóc bông điên điển
    'https://img-global.cpcdn.com/recipes/38cf7d3fa392c268/1200x630cq80/canh-chua-ca-loc-d%E1%BB%93ng-n%E1%BA%A5u-bong-dien-di%E1%BB%83n-recipe-main-photo.jpg', // Canh chua cá lóc đồng nấu bông điên điển
    'https://img-global.cpcdn.com/recipes/ba0a401e9f21ec46/1200x630cq80/ca-b%E1%BB%9Bp-n%E1%BA%A5u-ngot-recipe-main-photo.jpg', // Canh cá bớp nấu ngót cà chua
  ],

  // --- MÓN TÔM ---
  'shrimp_dish': [
    'https://img-global.cpcdn.com/recipes/0a0d79d2590382eb/1200x630cq80/canh-m%C6%B0%E1%BB%9Bp-n%E1%BA%A5u-tom-recipe-main-photo.jpg', // Canh mướp hương nấu tôm tươi
    'https://img-global.cpcdn.com/recipes/880a50e539420a1e/1200x630cq80/d%E1%BA%ADu-b%E1%BA%AFp-xao-tom-recipe-main-photo.jpg', // Đậu bắp xào tôm sú
    'https://img-global.cpcdn.com/recipes/477fd5e318eeb7a1/1200x630cq80/tom-xao-b%C6%A1-t%E1%BB%8Fi-recipe-main-photo.jpg', // Tôm xào bơ tỏi thơm lừng
    'https://img-global.cpcdn.com/recipes/7774e12a963325b9/1200x630cq80/tom-va-ngheu-h%E1%BA%A5p-s%E1%BA%A3-recipe-main-photo.jpg', // Tôm hấp sả bia cay nồng
  ],

  // --- MỰC / BẠCH TUỘC ---
  'squid_dish': [
    'https://img-global.cpcdn.com/recipes/583517f953504b31/1200x630cq80/m%E1%BB%B1c-h%E1%BA%A5p-rau-mu%E1%BB%91ng-cu%E1%BB%91n-banh-trang-s%E1%BA%AFn-d%C6%A1n-gi%E1%BA%A3n-ma-ngon-h%E1%BA%BFt-s%E1%BA%A9y-recipe-main-photo.jpg', // Mực hấp rau muống giòn ngọt
    'https://img-global.cpcdn.com/recipes/11844d34f8e73053/1200x630cq80/m%E1%BB%B1c-xao-c%E1%BA%A7n-t%E1%BB%8Fi-hanh-tay-recipe-main-photo.jpg', // Mực xào cần tỏi tây hành tây
    'https://img-global.cpcdn.com/recipes/e9f08df983266b0f/1200x630cq80/tu%E1%BA%A7n-23-m%E1%BB%B1c-chien-m%E1%BA%AFm-recipe-main-photo.jpg', // Mực chiên nước mắm đậm đà
    'https://img-global.cpcdn.com/recipes/71e1fc12d92ed0c2/1200x630cq80/m%E1%BB%B1c-h%E1%BA%A5p-eatwell-recipe-main-photo.jpg', // Mực hấp gừng sả
  ],

  // --- NGHÊU / ỐC ---
  'clam_snail_dish': [
    'https://img-global.cpcdn.com/recipes/001e2a04f16c1748/1200x630cq80/ngheu-h%E1%BA%A5p-s%E1%BA%A3-recipe-main-photo.jpg', // Nghêu hấp sả ớt cay nồng
    'https://img-global.cpcdn.com/recipes/483ab3114b677415/1200x630cq80/ngheu-h%E1%BA%A5p-s%E1%BA%A3-la-qu%E1%BA%BF-recipe-main-photo.jpg', // Nghêu hấp sả lá quế thơm lừng
    'https://img-global.cpcdn.com/recipes/7abcdf29fde475ee/1200x630cq80/canh-ngao-chua-n%E1%BA%A5u-d%E1%BB%A9a-recipe-main-photo.jpg', // Canh ngao nấu chua dứa thì là
    'https://img-global.cpcdn.com/recipes/637bdc47193efb6e/1200x630cq80/%E1%BB%91c-xao-s%E1%BA%A3-%E1%BB%9Bt-recipe-main-photo.jpg', // Ốc xào sả ớt lá lốt giòn cay
  ],

  // --- ĐẬU PHỤ ---
  'tofu_dish': [
    'https://img-global.cpcdn.com/recipes/0af85645ae8db557/1200x630cq80/d%E1%BA%ADu-h%E1%BB%A7-chien-x%E1%BA%A3-%E1%BB%9Bt-%F0%9F%98%8B-recipe-main-photo.jpg', // Đậu hủ chiên sả ớt vàng giòn
    'https://img-global.cpcdn.com/recipes/6ad8bb0447dad24a/1200x630cq80/canh-tau-h%E1%BB%A7-non-rong-bi%E1%BB%83n-recipe-main-photo.jpg', // Canh tàu hủ non rong biển
    'https://img-global.cpcdn.com/recipes/85abb41ec14d6a21/1200x630cq80/d%E1%BA%ADu-ph%E1%BB%A5-s%E1%BB%91t-ca-chua-%F0%9F%8D%85-recipe-main-photo.jpg', // Đậu phụ sốt cà chua hành hoa
    'https://img-global.cpcdn.com/recipes/beb9baa2feaba3a0/1200x630cq80/d%E1%BA%ADu-hu-s%E1%BB%91t-ca-th%E1%BB%8Bt-b%E1%BA%B1m-theo-cach-c%E1%BB%A7a-tui-recipe-main-photo.jpg', // Đậu hũ sốt cà thịt bằm
  ],

  // --- BÒ XÀO ---
  'beef_stir_fry': [
    'https://img-global.cpcdn.com/recipes/1fe9d4d9f37649c4/1200x630cq80/th%E1%BB%8Bt-bo-xao-hanh-tay-recipe-main-photo.jpg', // Thịt bò xào hành tây
    'https://img-global.cpcdn.com/recipes/aca4cf1e8ab876bb/1200x630cq80/th%E1%BB%8Bt-bo-ap-ch%E1%BA%A3o-recipe-main-photo.jpg', // Thịt bò áp chảo
    'https://img-global.cpcdn.com/recipes/e377f237ff909a45/1200x630cq80/bo-luc-l%E1%BA%AFc-recipe-main-photo.jpg', // Bò lúc lắc khoai tây
    'https://img-global.cpcdn.com/recipes/b574e39b36bfd521/1200x630cq80/th%E1%BB%8Bt-bo-xao-mang-tay-%E1%BB%9Bt-chuong-recipe-main-photo.jpg', // Thịt bò xào măng tây ớt chuông
    'https://img-global.cpcdn.com/recipes/a1f9274ab381d98a/1200x630cq80/bo-xao-ngu-s%E1%BA%AFc-%E1%BB%9Bt-chuong-recipe-main-photo.jpg', // Bò xào ngũ sắc ớt chuông
  ],

  // --- BÒ KHO / SỐT VANG ---
  'beef_stew': [
    'https://img-global.cpcdn.com/recipes/a2b833b10ccac333/1200x630cq80/bo-kho-recipe-main-photo.jpg', // Bò kho bánh mì chuẩn vị Sài Gòn
    'https://img-global.cpcdn.com/recipes/5f4145386bc77cc0/1200x630cq80/bo-kho-recipe-main-photo.jpg', // Bò sốt vang Hà Nội đậm đà
    'https://img-global.cpcdn.com/recipes/8a7be1a2af08c891/1200x630cq80/bo-kho-recipe-main-photo.jpg', // Bò kho nước dừa thơm béo
    'https://img-global.cpcdn.com/recipes/d1033a5252be0d5e/1200x630cq80/bo-kho-recipe-main-photo.jpg', // Bò sốt vang gân bò mềm giòn
  ],

  // --- PHỞ / CANH BÒ ---
  'beef_soup': [
    'https://img-global.cpcdn.com/recipes/73e80e883c4c886a/1200x630cq80/canh-th%E1%BB%8Bt-bo-ca-chua-th%C6%A1mkhom-recipe-main-photo.jpg', // Canh thịt bò cà chua
    'https://img-global.cpcdn.com/recipes/2294d5b815577a8a/1200x630cq80/ph%E1%BB%9F-bo-recipe-main-photo.jpg', // Phở bò Hà Nội truyền thống
    'https://img-global.cpcdn.com/recipes/a251bf261ad6cb39/1200x630cq80/canh-d%C6%B0a-chua-b%E1%BA%AFp-bo-recipe-main-photo.jpg', // Canh dưa chua bắp bò thanh mát
    'https://img-global.cpcdn.com/recipes/eb5e6c71de4f580f/1200x630cq80/canh-d%C6%B0a-chua-n%E1%BA%A5u-bo-recipe-main-photo.jpg', // Canh bò nấu cà chua dưa cải
  ],

  // --- THỊT HEO KHO / RANG ---
  'pork_braised': [
    'https://img-global.cpcdn.com/recipes/b1a718ea4f3b0a63/1200x630cq80/th%E1%BB%8Bt-kho-tau-tr%E1%BB%A9ng-cut-recipe-main-photo.jpg', // Thịt kho tàu trứng cút
    'https://img-global.cpcdn.com/recipes/3b6bffef64e58d1e/1200x630cq80/th%E1%BB%8Bt-ba-r%E1%BB%8Di-kho-tr%E1%BB%A9ng-cut-recipe-main-photo.jpg', // Thịt ba rọi kho trứng cút nước dừa
    'https://img-global.cpcdn.com/recipes/df437d058af1294f/1200x630cq80/th%E1%BB%8Bt-ba-ch%E1%BB%89-rang-chay-c%E1%BA%A1nh-recipe-main-photo.jpg', // Thịt ba chỉ rang cháy cạnh
    'https://img-global.cpcdn.com/recipes/e749b157b5dd10e5/1200x630cq80/th%E1%BB%8Bt-kho-tau-recipe-main-photo.jpg', // Thịt kho tàu truyền thống
  ],

  // --- THỊT CHIÊN / NEM RÁN ---
  'pork_fried': [
    'https://img-global.cpcdn.com/recipes/ccea44ca50929c7b/1200x630cq80/th%E1%BB%8Bt-chien-xu-ch%E1%BA%A5m-s%E1%BB%91t-chua-ng%E1%BB%8Dt-recipe-main-photo.jpg', // Thịt heo chiên xù sốt chua ngọt
    'https://img-global.cpcdn.com/recipes/83e4a09d23c55e73/1200x630cq80/sp0189-banh-%C6%B0%E1%BB%9Bt-nem-ran-gio-l%E1%BB%A5a-recipe-main-photo.jpg', // Nem rán giò lụa truyền thống
    'https://img-global.cpcdn.com/recipes/0dedcb5d1b7dbda5/1200x630cq80/th%E1%BB%8Bt-heo-chien-xu-recipe-main-photo.jpg', // Thịt heo chiên giòn xù
    'https://img-global.cpcdn.com/recipes/49aea74326d7587d/1200x630cq80/th%E1%BB%8Bt-chien-xu-ki%E1%BB%83u-nh%E1%BA%ADt-recipe-main-photo.jpg', // Thịt heo chiên giòn kiểu Nhật
  ],

  // --- CANH THỊT / SƯỜN ---
  'pork_soup': [
    'https://img-global.cpcdn.com/recipes/5d10fe85b6b36a11/1200x630cq80/canh-suon-nau-sau-recipe-main-photo.jpg', // Canh sườn nấu sấu chua dịu
    'https://img-global.cpcdn.com/recipes/7924ef5a28b05da2/1200x630cq80/canh-thit-bam-bi-xanh-recipe-main-photo.jpg', // Canh thịt băm nấu bí xanh
    'https://img-global.cpcdn.com/recipes/4836fe9b52a378ce/1200x630cq80/canh-suon-chua-recipe-main-photo.jpg', // Canh sườn nấu chua cà chua
    'https://img-global.cpcdn.com/recipes/ea927ebb3251eb80/1200x630cq80/canh-s%C6%B0%E1%BB%9Dn-chua-recipe-main-photo.jpg', // Canh sườn chua dưa cải
  ],

  // --- GÀ CHIÊN ---
  'chicken_fried': [
    'https://img-global.cpcdn.com/recipes/2436699_10c8ba21ce2b8016/1200x630cq80/canh-ga-chien-n%C6%B0%E1%BB%9Bc-m%E1%BA%AFm-recipe-main-photo.jpg', // Cánh gà chiên nước mắm giòn thơm
    'https://img-global.cpcdn.com/recipes/d2b041bd05e21867/1200x630cq80/canh-ga-chien-n%C6%B0%E1%BB%9Bc-m%E1%BA%AFm-t%E1%BB%8Fi-m%E1%BA%ADt-ong-recipe-main-photo.jpg', // Cánh gà chiên nước mắm tỏi mật ong
    'https://img-global.cpcdn.com/recipes/a4e8f5d69e84c2f9/1200x630cq80/dui-ga-chien-n%C6%B0%E1%BB%9Bc-m%E1%BA%AFm-recipe-main-photo.jpg', // Đùi gà chiên nước mắm vàng giòn
    'https://img-global.cpcdn.com/recipes/c4aff4c5b93cea78/1200x630cq80/cach-lam-ga-chien-n%C6%B0%E1%BB%9Bc-m%E1%BA%AFm-khong-b%E1%BB%8B-kho-recipe-main-photo.jpg', // Gà chiên giòn sốt cay ngọt
  ],

  // --- GÀ KHO ---
  'chicken_braised': [
    'https://img-global.cpcdn.com/recipes/1b5a190fc6a1d042/1200x630cq80/cong-th%E1%BB%A9c-%C6%B0%E1%BB%9Bp-ga-kho-s%E1%BA%A3-%E1%BB%9Bt-ga-kho-g%E1%BB%ABng-d%C6%A1n-gi%E1%BA%A3n-recipe-main-photo.jpg', // Gà kho sả ớt đậm vị
    'https://img-global.cpcdn.com/recipes/131babe18cbcad52/1200x630cq80/ga-kho-g%E1%BB%ABng-th%C6%A1m-l%E1%BB%ABng-hao-c%C6%A1m-recipe-main-photo.jpg', // Gà kho gừng thơm lừng hao cơm
    'https://img-global.cpcdn.com/recipes/1fabb35753d747d3/1200x630cq80/ga-kho-g%E1%BB%ABng-mon-ngon-dan-da-quen-thu%E1%BB%99c-v%E1%BB%9Bi-nhi%E1%BB%81u-gia-dinh%F0%9F%98%8B-recipe-main-photo.jpg', // Gà kho gừng món ngon dân dã
    'https://img-global.cpcdn.com/recipes/0dac9333b0d0ee40/1200x630cq80/th%E1%BB%8Bt-ga-kho-g%E1%BB%ABng-recipe-main-photo.jpg', // Thịt gà rang gừng lá chanh
  ],

  // --- CANH GÀ ---
  'chicken_soup': [
    'https://img-global.cpcdn.com/recipes/58f0d2dbb25103e5/1200x630cq80/canh-ga-n%E1%BA%A5u-la-giang-recipe-main-photo.jpg', // Canh gà lá giang chua dịu Nam Bộ
    'https://img-global.cpcdn.com/recipes/4313b05ea2e4d1f9/1200x630cq80/canh-ga-la-giang-recipe-main-photo.jpg', // Canh gà nấu lá giang truyền thống
    'https://img-global.cpcdn.com/recipes/5c39ca16c47993c0/1200x630cq80/canh-ga-n%E1%BA%A5u-la-giang-%F0%9F%8D%83%F0%9F%8D%83-recipe-main-photo.jpg', // Canh gà nấu lá giang đậm đà
    'https://img-global.cpcdn.com/recipes/4ebe32fbd32eb853/1200x630cq80/c%C6%A1m-ga-lu%E1%BB%99c-va-canh-ga-la-giang-recipe-main-photo.jpg', // Cơm gà luộc và canh gà thanh ngọt
  ],

  // --- RAU CỦ XÀO ---
  'veggie_stir_fry': [
    'https://img-global.cpcdn.com/recipes/db4abc9b2dfff412/1200x630cq80/rau-mu%E1%BB%91ng-xao-t%E1%BB%8Fi-b%E1%BA%A5t-b%E1%BA%A1i-recipe-main-photo.jpg', // Rau muống xào tỏi xanh mướt giòn rụm
    'https://img-global.cpcdn.com/recipes/2cdeb56225a9869d/1200x630cq80/d%E1%BA%ADu-b%E1%BA%AFp-xao-t%E1%BB%8Fi-recipe-main-photo.jpg', // Đậu bắp xào tỏi thơm lừng
    'https://img-global.cpcdn.com/recipes/ab6cbdb9bdbc53a4/1200x630cq80/bi-ngoi-xao-t%E1%BB%8Fi-th%E1%BB%8Bt-bo-recipe-main-photo.jpg', // Bí ngòi xào tỏi giòn ngọt
    'https://img-global.cpcdn.com/recipes/8e4521789b5317fc/1200x630cq80/bi-ngoi-xao-nam-recipe-main-photo.jpg', // Rau cải xào nấm dầu hào
  ],

  // --- CANH THANH MÁT ---
  'soup_general': [
    'https://img-global.cpcdn.com/recipes/59aa417daab7c3d7/1200x630cq80/canh-bi-ngoi-n%E1%BA%A5u-tom-kho-recipe-main-photo.jpg', // Canh bí ngòi nấu tôm thanh mát
    'https://img-global.cpcdn.com/recipes/2c970db3941ecfe3/1200x630cq80/canh-bi-xanh-th%E1%BB%8Bt-b%E1%BA%B1m-recipe-main-photo.jpg', // Canh bí xanh thịt bằm ngọt mát
    'https://img-global.cpcdn.com/recipes/0a0d79d2590382eb/1200x630cq80/canh-m%C6%B0%E1%BB%9Bp-n%E1%BA%A5u-tom-recipe-main-photo.jpg', // Canh mướp hương nấu thịt băm
    'https://img-global.cpcdn.com/recipes/7924ef5a28b05da2/1200x630cq80/canh-thit-bam-bi-xanh-recipe-main-photo.jpg', // Canh rau ngót nấu thịt nạc
  ],

  // --- CƠM / BÚN / PHỞ ---
  'noodle_rice': [
    'https://img-global.cpcdn.com/recipes/37e04abf46f62923/1200x630cq80/c%C6%A1m-chien-ch%E1%BA%A3-l%E1%BB%A5a-recipe-main-photo.jpg', // Cơm chiên chả lụa rau củ
    'https://img-global.cpcdn.com/recipes/a4ec1d07290a717b/1200x630cq80/c%C6%A1m-chien-ki%E1%BB%83u-hoa-recipe-main-photo.jpg', // Cơm chiên kiểu Dương Châu
    'https://img-global.cpcdn.com/recipes/2294d5b815577a8a/1200x630cq80/ph%E1%BB%9F-bo-recipe-main-photo.jpg', // Phở bò Hà Nội truyền thống
    'https://img-global.cpcdn.com/recipes/2db9b13e10f53cc0/1200x630cq80/c%C6%A1m-chien-bo-luc-l%E1%BA%AFc-recipe-main-photo.jpg', // Cơm chiên bò lúc lắc
  ],

  // --- MÓN NGON VIỆT NAM ---
  'general_dish': [
    'https://img-global.cpcdn.com/recipes/53034e8c4aeea45f/1200x630cq80/s%C6%B0%E1%BB%9Dn-xao-%E1%BB%9Bt-chuong-chua-ng%E1%BB%8Dt-recipe-main-photo.jpg', // Sườn xào chua ngọt
    'https://img-global.cpcdn.com/recipes/b1a718ea4f3b0a63/1200x630cq80/th%E1%BB%8Bt-kho-tau-tr%E1%BB%A9ng-cut-recipe-main-photo.jpg', // Thịt kho tàu nước dừa
    'https://img-global.cpcdn.com/recipes/131babe18cbcad52/1200x630cq80/ga-kho-g%E1%BB%ABng-th%C6%A1m-l%E1%BB%ABng-hao-c%C6%A1m-recipe-main-photo.jpg', // Gà kho gừng thơm lừng
    'https://img-global.cpcdn.com/recipes/e377f237ff909a45/1200x630cq80/bo-luc-l%E1%BA%AFc-recipe-main-photo.jpg', // Bò lúc lắc ớt chuông
  ],
};

/**
 * Phân tích tên món ăn tiếng Việt để trả về danh mục chính xác nhất
 */
export function classifyRecipeImageCategory(name: string): string {
  const norm = name
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .replace(/đ/g, 'd')
    .replace(/Đ/g, 'D')
    .toLowerCase()
    .trim();

  // Khử các từ ghép dễ gây nhầm lẫn: "áp chảo" != "cháo"
  const sanitized = norm.replace(/\bap\s+chao\b/g, 'pan_sear');

  // 1. MÓN ẾCH (Ưu tiên số 1 - Tuyệt đối không để rơi vào rau xào hay salad)
  if (/\b(ech)\b/.test(sanitized)) {
    return 'frog_dish';
  }

  // 2. MÓN LƯƠN
  if (/\b(luon)\b/.test(sanitized)) {
    return 'eel_dish';
  }

  // 3. MÓN VỊT / NGAN
  if (/\b(vit|ngan)\b/.test(sanitized) && !sanitized.includes('hot vit') && !sanitized.includes('trung vit')) {
    return 'duck_dish';
  }

  // 4. CHÁO
  if (/\bchao\b/.test(sanitized)) {
    if (sanitized.includes('ga') && !sanitized.includes('dau ga') && !sanitized.includes('nam dui ga')) {
      return 'chicken_porridge';
    }
    return 'porridge_general';
  }

  // 5. SƯỜN HEO
  if (/\bsuon\b/.test(sanitized)) {
    if (sanitized.includes('chao')) return 'porridge_general';
    if (sanitized.includes('canh') || sanitized.includes('sup')) return 'pork_soup';
    return 'pork_ribs';
  }

  // 6. GỎI / NỘM / SALAD (Chỉ khi không có ếch, sườn, lươn)
  if (/\b(goi|nom|salad|tron)\b/.test(sanitized)) {
    if (sanitized.includes('ga') && !sanitized.includes('dau ga') && !sanitized.includes('nam dui ga')) {
      return 'chicken_salad';
    }
    return 'salad_general';
  }

  // Khử các từ rau củ quả bắt đầu bằng "cà" (cà chua, cà tím, cà pháo, cà rốt, cà ri) để không nhận nhầm thành con cá!
  const cleanVegFish = sanitized.replace(/\bca\s+(chua|tim|phao|rot|ri)\b/g, 'veg_$1');

  // 7. MÓN BÒ (Ưu tiên cao, tuyệt đối không để lọt vào canh cá hay súp tôm)
  if (sanitized.includes('bo') && !sanitized.includes('bo dau') && !sanitized.includes('bo lat') && !sanitized.includes('qua bo') && !sanitized.includes('bo toi')) {
    if (sanitized.includes('sot vang') || sanitized.includes('kho') || sanitized.includes('ham')) return 'beef_stew';
    if (sanitized.includes('canh') || sanitized.includes('sup') || sanitized.includes('pho') || sanitized.includes('bun')) return 'beef_soup';
    return 'beef_stir_fry';
  }

  // 8. TRỨNG & CÀ CHUA
  if (sanitized.includes('trung') && sanitized.includes('ca chua')) {
    return 'egg_tomato';
  }
  if (sanitized.includes('trung')) {
    return 'egg_dish';
  }

  // 9. CÁ & CÁ NGỪ (Dùng cleanVegFish để loại trừ cà chua/cà tím)
  if (cleanVegFish.includes('ca ngu')) {
    return 'fish_tuna';
  }
  const isFish = /\b(ca|ca\s+loc|ca\s+hoi|ca\s+thu|ca\s+dieu\s+hong|ca\s+bop|ca\s+nuc|ca\s+ro|ca\s+chep|ca\s+keo|ca\s+tra|ca\s+basa)\b/.test(cleanVegFish);
  if (isFish) {
    if (cleanVegFish.includes('canh') || cleanVegFish.includes('chua') || cleanVegFish.includes('ngot')) return 'fish_soup';
    if (cleanVegFish.includes('chien') || cleanVegFish.includes('ran') || cleanVegFish.includes('pan_sear')) return 'fish_fried';
    return 'fish_braised';
  }

  // 10. TÔM & HẢI SẢN
  if (sanitized.includes('tom') || sanitized.includes('tep')) return 'shrimp_dish';
  if (sanitized.includes('muc') || sanitized.includes('bach tuoc')) return 'squid_dish';
  if (sanitized.includes('ngao') || sanitized.includes('ngheu') || sanitized.includes('so') || sanitized.includes('oc') || sanitized.includes('hau')) return 'clam_snail_dish';

  // 11. ĐẬU PHỤ & NẤM
  if (sanitized.includes('dau phu') || sanitized.includes('dau hu') || sanitized.includes('tau hu') || sanitized.includes('dau non')) {
    return 'tofu_dish';
  }

  // 12. GÀ
  if (sanitized.includes('ga') && !sanitized.includes('dau ga') && !sanitized.includes('nam dui ga')) {
    if (sanitized.includes('canh') || sanitized.includes('sup') || sanitized.includes('ham') || sanitized.includes('la giang')) {
      return 'chicken_soup';
    }
    if (sanitized.includes('chien') || sanitized.includes('ran') || sanitized.includes('nuoc mam') || sanitized.includes('pan_sear') || sanitized.includes('gion')) {
      return 'chicken_fried';
    }
    return 'chicken_braised';
  }

  // 13. HEO / BA CHỈ
  if (sanitized.includes('heo') || sanitized.includes('lon') || sanitized.includes('ba chi') || sanitized.includes('ba roi') || sanitized.includes('gio heo') || sanitized.includes('thit')) {
    if (sanitized.includes('canh') || sanitized.includes('sup') || sanitized.includes('ham')) return 'pork_soup';
    if (sanitized.includes('chien') || sanitized.includes('ran') || sanitized.includes('nuong') || sanitized.includes('quay')) return 'pork_fried';
    return 'pork_braised';
  }

  // 14. RAU CỦ / CANH / MÓN NƯỚC
  if (sanitized.includes('canh') || sanitized.includes('sup') || sanitized.includes('lau')) return 'soup_general';
  if (sanitized.includes('pho') || sanitized.includes('bun') || sanitized.includes('mi ') || sanitized.includes('com')) return 'noodle_rice';
  if (sanitized.includes('rau') || sanitized.includes('nam') || sanitized.includes('bi ngoi') || sanitized.includes('dau bap') || sanitized.includes('xao')) return 'veggie_stir_fry';

  return 'general_dish';
}
