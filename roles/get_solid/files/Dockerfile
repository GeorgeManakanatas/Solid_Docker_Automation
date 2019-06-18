FROM node:8.11.2-onbuild

WORKDIR /usr/src/app

RUN npm install

COPY . .

EXPOSE 8443
CMD [ "./bin/solid-test", "start" ]
