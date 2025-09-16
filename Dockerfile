# Стадия для разработки и тестирования
FROM node:18-alpine as development
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Стадия для тестирования
FROM development as test
RUN npm test

# Продакшн стадия
FROM node:18-alpine as production
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY --from=development /app/src ./src

# Создаём пользователя для безопасности
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001
USER nextjs

EXPOSE 3000
CMD ["npm", "start"]
