# 🚀 Dockerized Node.js App

Simple Express app Dockerized and ready to run anywhere.

## Features
- Express app with 2 routes
- Dockerfile + .env + best practices
- Ready for GitHub & CI/CD

## 🛠️ Run Locally
```bash
docker build -t node-docker-app .
docker run --env-file .env -p 3000:3000 node-docker-app
