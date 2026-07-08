FROM node:20-alpine AS base
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --production && mkdir -p node_modules

FROM node:20-alpine
WORKDIR /usr/src/app
COPY --from=base /usr/src/app/node_modules ./node_modules
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]
