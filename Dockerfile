FROM node:latest

WORKDIR /usr/db

COPY package.json /home/app/

COPY . .

RUN npm install

RUN node db.js

EXPOSE 3000

CMD [ "npm", "start"]
