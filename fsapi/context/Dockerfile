FROM nginx:1.10-alpine

RUN apk add --no-cache nodejs git
RUN git clone https://github.com/M-O-S-E-S/freeswitch-api.git /freeswitch
WORKDIR /freeswitch
RUN npm install
RUN npm run build
WORKDIR /freeswitch/build
CMD ["node", "service.js"]
