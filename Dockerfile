FROM node:22-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git curl python3 build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g pnpm

COPY apps/api/package.json apps/api/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile --ignore-scripts

COPY apps/api/ .

RUN pnpm run build --if-present || true

EXPOSE 3000
ENV PORT=3000
ENV HOST=0.0.0.0

CMD ["node", "dist/src/index.js"]
