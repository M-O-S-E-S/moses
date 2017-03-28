FROM nginx:1.10-alpine

RUN apk add --no-cache nodejs git openssl
RUN git clone https://github.com/M-O-S-E-S/mgm.git /mgm
WORKDIR /mgm
RUN npm install
RUN npm run build
RUN npm run build-scripts
WORKDIR /mgm/build
CMD ["node", "server.js"]
