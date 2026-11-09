const http = require('http');

function postJson(path, payload, headers = {}) {
  return new Promise((resolve, reject) => {
    const data = JSON.stringify(payload);
    const req = http.request(
      `http://localhost:5001${path}`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Content-Length': Buffer.byteLength(data),
          ...headers,
        },
      },
      (res) => {
        let body = '';
        res.on('data', (chunk) => (body += chunk));
        res.on('end', () => {
          try {
            const parsed = JSON.parse(body);
            resolve({ statusCode: res.statusCode, body: parsed });
          } catch (e) {
            resolve({ statusCode: res.statusCode, raw: body });
          }
        });
      }
    );
    req.on('error', reject);
    req.write(data);
    req.end();
  });
}

(async () => {
  try {
    console.log('🔑 Đang đăng nhập tài khoản user@foodsystem.com...');
    const loginRes = await postJson('/api/auth/login', {
      email: 'user@foodsystem.com',
      password: 'User@123456',
    });

    const token = loginRes.body?.data?.token;
    if (!token) {
      console.error('Đăng nhập thất bại:', loginRes);
      return;
    }
    console.log('✅ Đăng nhập thành công! Đã lấy JWT Token.');

    const authHeaders = { Authorization: `Bearer ${token}` };

    console.log('\n==================================================');
    console.log('🧪 TEST 1: [Trứng, Cà chua, Hành lá]');
    console.log('==================================================');
    const res1 = await postJson('/api/recipes/suggest', { ingredients: ['Trứng', 'Cà chua', 'Hành lá'] }, authHeaders);
    console.log('HTTP Status:', res1.statusCode, '| Source:', res1.body?.data?.source);
    const recipes1 = res1.body?.data?.recipes || [];
    console.log(`Total Suggestions: ${recipes1.length}`);

    const images1 = [];
    recipes1.forEach((r, idx) => {
      console.log(`\n🍲 Món ${idx + 1}: ${r.name} [${r.category}]`);
      console.log(`   - Điểm khớp: ${r.match_percentage}%`);
      console.log(`   - AI Chef Lý do: ${r.ai_reasoning?.substring(0, 90)}...`);
      console.log(`   - Nguyên liệu: ${r.ingredients?.slice(0, 4).join(' | ')}`);
      console.log(`   - Image URL: ${r.image_url}`);
      images1.push(r.image_url);
    });

    const unique1 = new Set(images1);
    console.log(`\n📊 Ảnh độc nhất: ${unique1.size}/${images1.length} (${unique1.size === images1.length ? '✅ HOÀN HẢO 100% KHÔNG TRÙNG LẶP' : '⚠️ CÓ ẢNH TRÙNG'})`);

    console.log('\n==================================================');
    console.log('🧪 TEST 2: [Tôm, Lá lốt, Bí ngòi, Tía tô, Đậu bắp]');
    console.log('==================================================');
    const res2 = await postJson('/api/recipes/suggest', { ingredients: ['Tôm', 'Lá lốt', 'Bí ngòi', 'Tía tô', 'Đậu bắp'] }, authHeaders);
    console.log('HTTP Status:', res2.statusCode, '| Source:', res2.body?.data?.source);
    const recipes2 = res2.body?.data?.recipes || [];
    console.log(`Total Suggestions: ${recipes2.length}`);

    const images2 = [];
    let hasForbiddenMeat = false;
    const forbidden = ['thịt heo', 'thịt bò', 'thịt gà', 'thịt lợn', 'mắm tôm', 'thịt vịt', 'sườn', 'ba chỉ'];

    recipes2.forEach((r, idx) => {
      console.log(`\n🍤 Món ${idx + 1}: ${r.name} [${r.category}]`);
      console.log(`   - Điểm khớp: ${r.match_percentage}%`);
      console.log(`   - AI Chef Lý do: ${r.ai_reasoning?.substring(0, 90)}...`);
      console.log(`   - Nguyên liệu: ${r.ingredients?.slice(0, 4).join(' | ')}`);
      console.log(`   - Image URL: ${r.image_url}`);
      images2.push(r.image_url);

      const allText = (r.name + ' ' + (r.ingredients || []).join(' ')).toLowerCase();
      for (const f of forbidden) {
        if (allText.includes(f)) {
          hasForbiddenMeat = true;
          console.warn(`   ⚠️ CẢNH BÁO: Phát hiện nguyên liệu không hợp lệ: "${f}"`);
        }
      }
    });

    const unique2 = new Set(images2);
    console.log(`\n📊 Ảnh độc nhất: ${unique2.size}/${images2.length} (${unique2.size === images2.length ? '✅ HOÀN HẢO 100% KHÔNG TRÙNG LẶP' : '⚠️ CÓ ẢNH TRÙNG'})`);
    console.log(`🥩 Kiểm tra nguyên liệu: ${!hasForbiddenMeat ? '✅ 100% CHUẨN XÁC CHỈ DÙNG TÔM & RAU (KHÔNG BỊA THỊT/MẮM TÔM)' : '❌ CÓ NGUYÊN LIỆU LẠ'}`);
  } catch (err) {
    console.error('Test failed:', err);
  }
})();
