FROM node:16.8

WORKDIR /app

COPY . .

RUN npm install --production

CMD [ "node", "app.js" ]