const { getFoodImage } = require('../../dist/services/image.service');

async function testMatch() {
  const imgBoApChao = await getFoodImage('Thịt bò áp chảo');
  console.log('🖼️ Ảnh lấy cho món "Thịt bò áp chảo":', imgBoApChao);

  const imgComBoXao = await getFoodImage('Cơm bò xào');
  console.log('🖼️ Ảnh lấy cho món "Cơm bò xào":', imgComBoXao);
}

testMatch().catch(console.error);
