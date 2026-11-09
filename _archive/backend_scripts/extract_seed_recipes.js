const fs = require('fs');
const path = require('path');

const pyPath = path.resolve(__dirname, '../../../crawler/seed_diverse_recipes.py');
const content = fs.readFileSync(pyPath, 'utf8');

// Find NEW_RECIPES = [ ... ]
const startIdx = content.indexOf('NEW_RECIPES = [');
if (startIdx !== -1) {
  // Simple extraction: convert python dict syntax to JSON
  let pyCode = content.substring(startIdx + 'NEW_RECIPES = '.length);
  const endIdx = pyCode.indexOf('\n\ndef ');
  if (endIdx !== -1) {
    pyCode = pyCode.substring(0, endIdx).trim();
  }
  // Replace Python True/False/None with true/false/null
  const jsonStr = pyCode
    .replace(/#.*$/gm, '') // remove comments
    .replace(/True/g, 'true')
    .replace(/False/g, 'false')
    .replace(/None/g, 'null')
    .trim();

  try {
    const parsed = JSON.parse(jsonStr);
    console.log('Successfully parsed NEW_RECIPES count:', parsed.length);
    console.log('Sample dish:', parsed[0].name, '->', parsed[0].image_url);
    fs.writeFileSync(path.resolve(__dirname, '../../../crawler/seed_recipes.json'), JSON.stringify(parsed, null, 2), 'utf8');
    console.log('Saved to crawler/seed_recipes.json');
  } catch (e) {
    console.error('JSON parse error:', e.message);
  }
}
