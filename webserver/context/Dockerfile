FROM nginx:1.10-alpine

RUN apk add --no-cache nodejs git
RUN git clone https://github.com/M-O-S-E-S/mgm-webclient.git /mgm
WORKDIR /mgm
RUN npm install
RUN npm run build-production


