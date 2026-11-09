const fs = require('fs');
const path = require('path');

const origPath = path.resolve(__dirname, '../../../crawler/cookpad_recipes.json');
const rarePath = path.resolve(__dirname, '../../../crawler/cookpad_rare_recipes.json');

const orig = fs.existsSync(origPath) ? JSON.parse(fs.readFileSync(origPath, 'utf8')) : [];
const rare = fs.existsSync(rarePath) ? JSON.parse(fs.readFileSync(rarePath, 'utf8')) : [];

console.log('Original recipes count:', orig.length);
console.log('Rare recipes count:', rare.length);

const all = [...orig, ...rare];
const map = new Map();
for (const r of all) {
  const norm = r.name.toLowerCase().trim();
  if (!map.has(norm)) {
    map.set(norm, r);
  }
}
console.log('Total unique recipes available from Cookpad JSON:', map.size);

// Sample check for ech, suon, bo, ga, ca
const ech = Array.from(map.values()).filter(r => r.name.toLowerCase().includes('ếch'));
const suon = Array.from(map.values()).filter(r => r.name.toLowerCase().includes('sườn'));
const bo = Array.from(map.values()).filter(r => r.name.toLowerCase().includes('bò'));
const ga = Array.from(map.values()).filter(r => r.name.toLowerCase().includes('gà'));
const tom = Array.from(map.values()).filter(r => r.name.toLowerCase().includes('tôm'));

console.log(`- Ếch: ${ech.length} dishes`);
console.log(`- Sườn: ${suon.length} dishes`);
console.log(`- Bò: ${bo.length} dishes`);
console.log(`- Gà: ${ga.length} dishes`);
console.log(`- Tôm: ${tom.length} dishes`);
