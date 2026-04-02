FROM node:20-slim

WORKDIR /app

COPY apps/api/package*.json ./
RUN npm install --legacy-peer-deps

COPY apps/api/ .

RUN npm run build

ENV PORT=3000
EXPOSE 3000

CMD ["node", "dist/src/index.js"]
