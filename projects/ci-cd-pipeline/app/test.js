// Minimal smoke test - no external test framework required
const http = require('http');
const assert = require('assert');

const PORT = 3999;
process.env.PORT = PORT;

require('./index.js'); // starts the server on PORT

setTimeout(() => {
  http.get(`http://localhost:${PORT}`, (res) => {
    assert.strictEqual(res.statusCode, 200, 'Expected status code 200');
    console.log('✅ Smoke test passed: server responded with 200');
    process.exit(0);
  }).on('error', (err) => {
    console.error('❌ Test failed:', err.message);
    process.exit(1);
  });
}, 500);
