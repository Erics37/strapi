# ---------- Build stage ----------
FROM node:20-bookworm AS build

# 只安装最基础的构建工具（不装 libvips-dev）
RUN apt-get update && apt-get install -y \
  python3 \
  make \
  g++ \
  git \
  pkg-config \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app

# 关键：强制 sharp 使用官方预编译二进制
ENV SHARP_IGNORE_GLOBAL_LIBVIPS=1

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

# ---------- Runtime stage ----------
FROM node:20-bookworm

# 运行时只需要 libvips（不是 libvips-dev）
RUN apt-get update && apt-get install -y \
  libvips \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app
COPY --from=build /opt/app ./

ENV NODE_ENV=production
EXPOSE 1337
CMD ["npm", "run", "start"]
