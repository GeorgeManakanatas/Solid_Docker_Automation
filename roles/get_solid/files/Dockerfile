FROM node:10-alpine
RUN apk add --no-cache openssl
EXPOSE 8443
COPY . .
COPY config.json-default config.json
RUN npm install
RUN openssl req \
    -new \
    -newkey rsa:4096 \
    -days 365 \
    -nodes \
    -x509 \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
    -keyout privkey.pem \
    -out fullchain.pem
CMD /usr/src/app/bin/solid-test start
