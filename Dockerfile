FROM node:18-bullseye

WORKDIR /app

COPY package.json package-lock.json* ./

RUN npm install --registry=https://registry.npmmirror.com --no-audit --no-fund --legacy-peer-deps --registry=https://registry.npmmirror.com --no-audit --no-fund --legacy-peer-deps

COPY . .

RUN npm run build

EXPOSE 1337

CMD ["npm", "run", "start"]

