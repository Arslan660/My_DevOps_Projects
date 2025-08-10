# Use official Node image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy files
COPY package*.json ./
RUN npm install
COPY app/ app/


# Expose port
EXPOSE 3000

# Start app
CMD ["node", "app/index.js"]
