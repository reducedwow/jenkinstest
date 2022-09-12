#FROM node:latest

#WORKDIR /usr/src/app

#COPY package.json ./

#RUN npm install

#COPY . .

#EXPOSE 3000
#CMD [ "node", "index.js" ]
#FROM nginx:1.14.2-alpine
#COPY ./*.html /usr/share/nginx/html/


FROM node:14
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
RUN npm install express
COPY . .
EXPOSE 3000
CMD [ "node", "index.js" ]
