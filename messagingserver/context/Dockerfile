FROM frolvlad/alpine-mono

RUN apk update
RUN apk add --no-cache git
RUN git clone https://github.com/m-o-s-e-s/halcyon.git /halcyon
WORKDIR /halcyon
RUN git checkout background
RUN ./runprebuild.sh
RUN xbuild
WORKDIR /halcyon/bin

CMD mono OpenSim.Grid.MessagingServer.exe --background true
