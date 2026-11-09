function generateCleanQueries(dishName) {
  const norm = dishName.toLowerCase();
  const queries = [dishName];

  // Danh sách từ phụ loại bỏ
  const fluffWords = ['cay', 'gion', 'chuan vi', 'sieu ngon', 'dam da', 'thanh mat', 'hanh phi', 'ot xiem', 'ot xiem xanh', 'ot chuong'];

  let simplified = dishName;
  for (const f of ['cay', 'giòn', 'chuẩn vị', 'siêu ngon', 'đậm đà', 'thanh mát', 'hành phi', 'ớt xiêm xanh', 'ớt xiêm', 'ớt chuông', 'nóng hổi']) {
    const reg = new RegExp('\\b' + f + '\\b', 'gi');
    simplified = simplified.replace(reg, '').replace(/\s+/g, ' ').trim();
  }
  if (simplified && simplified !== dishName) {
    queries.push(simplified);
  }

  // Phân tích protein + method
  const hasEch = norm.includes('ếch') || norm.includes('ech');
  const hasSuon = norm.includes('sườn') || norm.includes('suon');
  const hasGa = norm.includes('gà') || norm.includes('ga');
  const hasBo = norm.includes('bò') || norm.includes('bo');

  const hasXao = norm.includes('xào') || norm.includes('xao');
  const hasChien = norm.includes('chiên') || norm.includes('chien') || norm.includes('rán') || norm.includes('ran');
  const hasCanh = norm.includes('canh') || norm.includes('súp') || norm.includes('sup');
  const hasChao = norm.includes('cháo') || norm.includes('chao');
  const hasKho = norm.includes('kho') || norm.includes('rim');
  const hasApChao = norm.includes('áp chảo') || norm.includes('ap chao');

  if (hasEch) {
    if (hasXao) queries.push('ếch xào măng', 'ếch xào sả ớt', 'ếch xào lăn', 'ếch xào');
    if (hasChien) queries.push('ếch chiên giòn', 'ếch chiên nước mắm', 'ếch chiên');
    if (hasCanh) queries.push('ếch nấu măng', 'canh ếch', 'lẩu ếch');
    if (hasKho) queries.push('ếch kho sả ớt', 'ếch kho tộ');
    queries.push('món ếch', 'thịt ếch');
  }

  if (hasSuon) {
    if (hasChao) queries.push('cháo sườn', 'cháo sườn ngô');
    if (hasApChao || norm.includes('salad')) queries.push('sườn áp chảo', 'sườn nướng', 'sườn chiên');
    if (hasXao) queries.push('sườn xào chua ngọt', 'sườn xào');
    if (hasKho) queries.push('sườn kho', 'sườn kho mặn ngọt');
    if (hasCanh) queries.push('canh sườn', 'canh sườn chua');
  }

  if (hasGa) {
    if (hasChien) queries.push('gà chiên giòn', 'cánh gà chiên giòn', 'gà chiên');
    if (hasCanh) queries.push('canh gà lá giang', 'canh gà nấm', 'canh gà');
    if (hasKho) queries.push('gà kho sả ớt', 'gà kho gừng');
    if (hasXao) queries.push('gà xào sả ớt', 'gà xào');
  }

  return [...new Set(queries)];
}

console.log('1. "Ếch xào măng cay" ->', generateCleanQueries('Ếch xào măng cay'));
console.log('2. "Ếch chiên măng cay giòn" ->', generateCleanQueries('Ếch chiên măng cay giòn'));
console.log('3. "Canh ếch nấu măng cay" ->', generateCleanQueries('Canh ếch nấu măng cay'));
console.log('4. "Cháo sườn ớt chuông hành phi" ->', generateCleanQueries('Cháo sườn ớt chuông hành phi'));
console.log('5. "Salad ớt chuông sườn heo áp chảo" ->', generateCleanQueries('Salad ớt chuông sườn heo áp chảo'));
console.log('6. "Gà chiên giòn sốt ớt xiêm" ->', generateCleanQueries('Gà chiên giòn sốt ớt xiêm'));
