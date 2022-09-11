#FROM nginx:1.15.8-alpine
#copy ./*.html /usr/share/nginx/html/
FROM node:latest

WORKDIR /usr/src/app

COPY package.json ./

RUN npm install

COPY . .

EXPOSE 3000
CMD [ "node", "index.js" ]
