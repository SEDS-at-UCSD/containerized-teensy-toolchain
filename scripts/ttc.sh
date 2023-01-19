#!/bin/bash

#!/bin/bash

MODE=$1
INDENT="   "
VERSION="0.0.1"

case ${MODE} in
"init")
    echo "[HOST MSG] Directly run docker container"
    echo "${INDENT}usage: docker run -e MODE=init -v "$(pwd)":/root/mount teensy:[version]"
    ;;
"build")
    docker run --rm -e MODE=build -v "$(pwd)":/root/mount teensy:0.0.1
    ;;
"clean")
    docker run --rm -e MODE=clean -v "$(pwd)":/root/mount teensy:0.0.1
    ;;
*)
    echo '[Invalid] Invalid MODE'
    echo "${INDENT}usage: cd /path/to/project/directory"
    echo "${INDENT}       ./ttc.sh [MODE: build | clean]"
    ;;
esac
