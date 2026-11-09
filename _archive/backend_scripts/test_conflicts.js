const { isImageUrlConflicting } = require('../../dist/services/image.service');

const cases = [
  {
    dish: 'Thịt bò sốt cà chua',
    url: 'https://img-global.cpcdn.com/recipes/946c4aa7689d1ab4/1200x630cq80/th%E1%BB%8Bt-bo-xao-gia-d%E1%BA%ADu-nh%E1%BB%93i-th%E1%BB%8Bt-s%E1%BB%91t-ca-chua-b%E1%BA%AFp-c%E1%BA%A3i-lu%E1%BB%99c-recipe-main-photo.jpg'
  },
  {
    dish: 'Bò trộn hành tây',
    url: 'https://img-global.cpcdn.com/recipes/b975d64a38fa7324/1200x630cq80/bo-s%E1%BB%91t-vang-hay-con-g%E1%BB%8Di-la-bo-kho%F0%9F%98%8B-recipe-main-photo.jpg'
  },
  {
    dish: 'Cơm chiên thịt bò',
    url: 'https://img-global.cpcdn.com/recipes/a146e4fde7250000/1200x630cq80/th%E1%BB%8Bt-bo-ba-ch%E1%BB%89-m%E1%BB%B9-cu%E1%BB%99n-rau-c%E1%BB%A7-n%C6%B0%E1%BB%9Bng-n%E1%BB%93i-chien-ko-d%E1%BA%A7u-recipe-main-photo.jpg'
  },
  {
    dish: 'Tôm xào hành tây',
    url: 'https://img-global.cpcdn.com/recipes/6f897c54a9c1ca00/1200x630cq80/mi-tom-xao-recipe-main-photo.jpg'
  },
  {
    dish: 'Canh cá hồi',
    url: 'https://img-global.cpcdn.com/recipes/d931864ab7eea2a7/1200x630cq80/ca-thu-ap-ch%E1%BA%A3o-va-bi-ngoi-xao-b%C6%A1-t%E1%BB%8Fi-recipe-main-photo.jpg'
  },
  {
    dish: 'Cá hồi áp chảo',
    url: 'https://img-global.cpcdn.com/recipes/d931864ab7eea2a7/1200x630cq80/ca-thu-ap-ch%E1%BA%A3o-va-bi-ngoi-xao-b%C6%A1-t%E1%BB%8Fi-recipe-main-photo.jpg'
  },
  {
    dish: 'Cơm chiên cá hồi',
    url: 'https://img-global.cpcdn.com/recipes/7baf1226794f5ab1/1200x630cq80/ca-c%C6%A1m-chien-b%E1%BB%99t-cu%E1%BB%91n-rau-s%E1%BB%91ng-recipe-main-photo.jpg'
  }
];

console.log('--- KIEM THU XUNG DOT ANH ---');
let allPassed = true;
for (const c of cases) {
  const conflict = isImageUrlConflicting(c.url, c.dish);
  console.log(`[${conflict ? 'PASSED (BI CHAN)' : 'FAILED (KHONG CHAN)'}] Mon: "${c.dish}" => Conflict: ${conflict}`);
  if (!conflict) allPassed = false;
}

if (allPassed) {
  console.log('>>> KET QUA: TOAN BO 7 TRUONG HOP LOI SAI ANH DA BI CHAN TRIET DE 100%! <<<');
} else {
  console.log('>>> KET QUA: CO TRUONG HOP CHUA BI CHAN <<<');
}
