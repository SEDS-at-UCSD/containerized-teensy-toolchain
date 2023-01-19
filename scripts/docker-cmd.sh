docker run -e MODE=init -v "$(pwd)":/root/mount teensy:0.0.1

# with automatic container cleanup
docker run --rm -e MODE=init -v "$(pwd)":/root/mount teensy:0.0.1