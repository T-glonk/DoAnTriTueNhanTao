import { suggestRecipes } from '../services/recipe.service';

async function testSuggest() {
  const result = await suggestRecipes(['Thịt bò', 'Hành tây'], undefined, 6, 'ai');
  console.log('Result source:', result.source);
  console.log('Món gợi ý:');
  result.recipes.forEach((r: any) => {
    console.log(` - Tên: "${r.name}" | Ảnh: ${r.image_url}`);
  });
  process.exit(0);
}

testSuggest().catch(console.error);
