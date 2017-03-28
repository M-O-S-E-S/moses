FROM alpine:3.3

RUN apk add --no-cache nodejs git
RUN git clone https://github.com/M-O-S-E-S/offline-messages.git /offline
WORKDIR /offline
RUN npm install
RUN npm run build
WORKDIR /offline/build
CMD ["node", "service.js"]
