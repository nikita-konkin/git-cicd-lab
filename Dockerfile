# Используем официальный Node.js образ
FROM node:18-alpine

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install --only=production

# Копируем исходный код
COPY src/ ./src/
COPY tests/ ./tests/

# Создаём пользователя для безопасности
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nextjs -u 1001

USER nextjs

# Открываем порт
EXPOSE 3000

# Команда по умолчанию
CMD ["npm", "start"]
