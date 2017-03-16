FROM alpine:3.3

RUN apk add --no-cache cmake g++ make git boost-dev curl-dev protobuf-dev
RUN git clone https://github.com/M-O-S-E-S/aperture.git /aperture
#RUN git clone https://github.com/InWorldz/aperture.git /aperture
RUN mkdir /aperture/build
WORKDIR /aperture/build
RUN cmake ..
RUN make

RUN mkdir /assets
CMD ["./aperture"]
