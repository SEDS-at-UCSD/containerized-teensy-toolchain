#!/bin/bash

MODE=$1
INDENT="   "
BASE_PATH="/root/project"

echo "== Dockerized Teensy Build Toolchain by SEDS =="

case ${MODE} in
"init")
    /bin/bash ${BASE_PATH}/scripts/mode_init.sh
    ;;
"build")
    /bin/bash ${BASE_PATH}/scripts/mode_build.sh
    ;;
"clean")
    /bin/bash ${BASE_PATH}/scripts/mode_clean.sh
    ;;
*)
    echo '[Invalid] MODE undefined'
    echo "${INDENT}usage: docker run -e MODE=init -v "$(pwd)":/root/mount teensy:0.0.1"
    echo "${INDENT}usage: MODE: init | build"
    ;;
esac
