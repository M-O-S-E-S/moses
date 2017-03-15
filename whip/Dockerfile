FROM alpine:3.3

RUN apk add --no-cache cmake g++ make boost-dev git
RUN git clone https://github.com/InWorldz/whip-server.git /whip
RUN mkdir /whip/build
WORKDIR /whip/build
RUN cmake ..
RUN make

RUN mkdir /assets
CMD ["./whip"]
