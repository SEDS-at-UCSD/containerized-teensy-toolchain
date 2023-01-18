#!/bin/bash

MODE=$1
INDENT="   "

echo "==Dockerized Teensy Build Toolchain by SEDS=="

if [ ${MODE} != "init" ] && [ ${MODE} != "build" ]
then
  echo '[Invalid] MODE undefined'
  echo "${INDENT}usage: docker run -e MODE=init -v "$(pwd)":/root/mount teensy:0.0.1"
  echo "${INDENT}usage: MODE: init | build"
fi

if [ ${MODE} = "init" ]
then
  echo "[MSG] Running MODE=init"
  cd ~/mount

  if [ "$(ls -A /root/mount)" ]
  then
    echo "[FATAL] Target directory is not empty. Init mode can only be used on empty directory because it is destructive."
    exit 1
  fi
  mkdir -p src core libraries
  echo "[MSG] Copying src"
  rsync -r --info=progress2 ~/project/src/* ./src/
  echo "[MSG] Copying core"
  rsync -r --info=progress2 ~/project/core/* ./core/
  echo "[MSG] Copying libraries"
  rsync -r --info=progress2 ~/project/libraries/ ./libraries
  echo "[MSG] Copying top-level Makefile"
    rsync --info=progress2 ~/project/Makefile ./
  echo "[MGS] Done!"
fi

if [ ${MODE} = "build" ]
then
  echo "[MSG] Running MODE=build"
  cd ~/project
  cp ~/mount/src/*.h ./src
  cp ~/mount/src/*.cpp ./src
  cp ~/mount/src/*.c ./src
  make all
fi