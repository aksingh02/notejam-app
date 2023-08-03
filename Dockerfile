FROM node:18

WORKDIR /home/app

COPY package.json /home/app/

COPY . .

RUN npm install

RUN node db.js

EXPOSE 9000

CMD [ "npm", "start"]