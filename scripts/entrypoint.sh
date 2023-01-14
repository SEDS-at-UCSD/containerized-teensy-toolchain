#!/bin/bash

MODE=$1

echo "Starting Dockerized Teensy Build Tool"

if [ ${MODE} != "init" ] && [ ${MODE} != "build" ]
then
  echo "MODE undefined. init | build"
fi

if [ ${MODE} = "init" ]
then
  echo "running init"
  cd ~/mount
  mkdir -p src core libraries
  cp -r ~/project/src/* ./src/
  cp -r ~/project/core/* ./core/
  cp ~/project/Makefile ./
#  cp -r ~/project/libraries/ ./libraries
  echo "done"
fi

if [ ${MODE} = "build" ]
then
  echo "running build"
  cd ~/project
  cp ~/mount/src/*.h ./src
  cp ~/mount/src/*.cpp ./src
  cp ~/mount/src/*.c ./src
  make
fi