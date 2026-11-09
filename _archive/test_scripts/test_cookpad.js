const https = require('https');

function fetch(q) {
  return new Promise(resolve => {
    const url = 'https://cookpad.com/vn/tim-kiem/' + encodeURIComponent(q);
    https.get(url, {
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36',
        'Accept-Language': 'vi-VN,vi;q=0.9',
      },
      timeout: 5000
    }, res => {
      let html = '';
      res.on('data', chunk => html += chunk);
      res.on('end', () => {
        const regex = /<img[^>]+src=["'](https:\/\/img-global\.cpcdn\.com\/recipes\/[a-zA-Z0-9_-]+\/[^"']+)["'][^>]*>/gi;
        const results = [];
        let m;
        while ((m = regex.exec(html)) !== null) {
          const altMatch = m[0].match(/alt=["']([^"']*)["']/i);
          results.push({
            alt: altMatch ? altMatch[1] : '',
            src: m[1]
          });
        }
        resolve({ query: q, status: res.statusCode, count: results.length, top: results[0] });
      });
    }).on('error', err => resolve({ query: q, error: err.message }))
      .on('timeout', () => resolve({ query: q, error: 'timeout' }));
  });
}

async function run() {
  const tests = [
    'ếch chiên măng cay giòn',
    'ếch chiên',
    'ếch chiên giòn',
    'canh ếch nấu măng cay',
    'ếch nấu măng',
    'canh ếch',
    'cháo sườn ớt chuông hành phi',
    'cháo sườn',
    'salad ớt chuông sườn heo áp chảo',
    'sườn áp chảo',
    'gà chiên giòn sốt ớt xiêm',
    'gà chiên giòn'
  ];
  for (const t of tests) {
    const r = await fetch(t);
    console.log(`${r.query} -> Status: ${r.status}, Found: ${r.count}, Top: ${r.top ? r.top.alt : 'None'}`);
  }
}

run();
