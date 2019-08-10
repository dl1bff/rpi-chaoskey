
FROM debian:10

WORKDIR /app

COPY make_module.sh /app


RUN apt-get update && apt-get -y install git bison flex libssl-dev make bc jq curl

RUN git clone --depth=1 https://github.com/raspberrypi/tools


ENV PATH="${PATH}:/app/tools/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin"




