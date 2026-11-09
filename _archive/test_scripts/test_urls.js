const { getPool } = require('./dist/database/db');
const https = require('https');
const http = require('http');

function checkUrl(url) {
  return new Promise((resolve) => {
    if (!url || !url.startsWith('http')) return resolve({ ok: false, status: 0 });
    const client = url.startsWith('https') ? https : http;
    try {
      const req = client.get(url, {
        headers: {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
          'Referer': 'https://cookpad.com/'
        },
        timeout: 5000
      }, res => {
        resolve({ ok: res.statusCode === 200 || res.statusCode === 304, status: res.statusCode });
      });
      req.on('error', e => resolve({ ok: false, status: 500, error: e.message }));
      req.on('timeout', () => { req.destroy(); resolve({ ok: false, status: 408 }); });
    } catch (e) {
      resolve({ ok: false, status: 500 });
    }
  });
}

async function testAll() {
  const pool = getPool();
  const [rows] = await pool.query('SELECT id, name, image_url FROM recipes');
  console.log('Testing', rows.length, 'images...');
  
  let valid = 0;
  let broken = 0;
  const brokenList = [];

  for (const r of rows) {
    const res = await checkUrl(r.image_url);
    if (res.ok) {
      valid++;
    } else {
      broken++;
      brokenList.push({ name: r.name, url: r.image_url, status: res.status });
    }
  }

  console.log(`Results: ${valid} VALID images, ${broken} BROKEN images.`);
  if (brokenList.length > 0) {
    console.log('First 10 broken:');
    brokenList.slice(0, 10).forEach(b => console.log(`[${b.status}] ${b.name} -> ${b.url}`));
  }
}

testAll().catch(console.error);
