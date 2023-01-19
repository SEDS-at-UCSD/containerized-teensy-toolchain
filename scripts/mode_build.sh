#!/bin/bash

echo "[MSG] Running MODE=build"
cd ~/project
cp ~/mount/src/*.h ./src
cp ~/mount/src/*.cpp ./src
cp ~/mount/src/*.c ./src
make all
cp ./src/*.hex ~/mount/src