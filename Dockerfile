# This docker image is responsible for containerizing build tools for Teensy 4.1
#
# Source: https://github.com/knickish/teensy_docker/blob/master/Dockerfile

FROM ubuntu:20.04

# 1.8.19 is the latest supported arduino version for teensyduino
# Source: https://www.pjrc.com/teensy/td_download.html
ENV DOCKER_ARDUINO_VERSION=arduino-1.8.19
# Teensyduino 1.57 began supporting arduino 2.0.x; We are using 1.56 for reliability purposes
ENV DOCKER_TEENSY_TD_VERSION=td_156


# Install all tool dependencies
ENV DEBIAN_FRONTEND=noninteractive
RUN apt -y update && \
    apt -y install \
    avr-libc \
    binutils-avr \
    g++ \
    gcc \
    gcc-avr \
    git \
    libfontconfig1 \
    libusb-dev \
    libxft-dev \
    make \
    python3.8 \
    unzip \
    vim \
    wget \
    xz-utils \
    && apt clean && rm -rf /var/lib/apt/lists


# Add Linux udev rule
# udev rule source: https://www.pjrc.com/teensy/00-teensy.rules
RUN mkdir -p /etc/udev/rules.d/  && \
    echo    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", ENV{ID_MM_DEVICE_IGNORE}="1", ENV{ID_MM_PORT_IGNORE}="1" \
            ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789a]*", ENV{MTP_NO_PROBE}="1" \
            KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", MODE:="0666", RUN:="/bin/stty -F /dev/%k raw -echo" \
            KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", MODE:="0666" \
            SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04*", MODE:="0666" >> /etc/udev/rules.d/00-teensy.rules

# Installing Teensyduino at WORKDIR
WORKDIR /root/teensyduino
RUN wget -q https://downloads.arduino.cc/${DOCKER_ARDUINO_VERSION}-linux64.tar.xz && \
    wget -q https://www.pjrc.com/teensy/${DOCKER_TEENSY_TD_VERSION}/TeensyduinoInstall.linux64

RUN tar -xf ${DOCKER_ARDUINO_VERSION}-linux64.tar.xz && \
    rm ${DOCKER_ARDUINO_VERSION}-linux64.tar.xz && \
    chmod 755 TeensyduinoInstall.linux64 && \
    ./TeensyduinoInstall.linux64 --dir=/root/teensyduino/${DOCKER_ARDUINO_VERSION}


# Extracting necessary tools (compilers, etc.) and libraries
WORKDIR /root/project
RUN mkdir -p tools && \
    cp -r /root/teensyduino/arduino-1.8.19/hardware/tools/arm ./tools && \
    mkdir -p core && \
    cp -r /root/teensyduino/arduino-1.8.19/hardware/teensy/avr/cores/teensy4 ./core && \
    mkdir -p libraries && \
    cp -r /root/teensyduino/arduino-1.8.19/hardware/teensy/avr/libraries ./libraries && \
    mkdir -p scripts && \
    mkdir -p src \


RUN mkdir -p /root/mount

COPY Makefile ./
COPY core/teensy4/Makefile core/teensy4/Makefile
COPY src/Makefile src/Makefile

COPY scripts/ scripts/

# undefined | init | build
ENV MODE undefined

RUN chmod 755 /root/project/scripts/*
CMD ["sh", "-c", "/root/project/scripts/entrypoint.sh ${MODE}"]
