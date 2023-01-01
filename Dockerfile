FROM node:12-alpine3.9

WORKDIR /app

COPY package*.json ./

RUN npm install --production
COPY src ./src

EXPOSE 4200

CMD ["node", "src/index.js"]