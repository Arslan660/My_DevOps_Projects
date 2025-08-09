// src/server.js
require('dotenv').config();
const express = require('express');
const morgan = require('morgan');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(morgan('combined'));
app.get('/health', (req, res) => res.json({ status: 'ok' }));
app.get('/', (req, res) => res.send('Hello from Dockerized Node.js app 🚀'));

const server = app.listen(PORT, () => console.log(`Listening on ${PORT}`));

const shutdown = () => {
  console.log('SIGTERM received: closing HTTP server');
  server.close(() => process.exit(0));
  setTimeout(() => process.exit(1), 10000); // force exit if not closed
};
process.on('SIGINT', shutdown);
process.on('SIGTERM', shutdown);
