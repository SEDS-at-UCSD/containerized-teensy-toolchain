# Containerized Teensy Toolchain

## 1. Installation
### Prerequisites 
```shell
1) docker (https://www.docker.com/)
```

### Install
```shell
docker pull hyun04p/containerized-teensy-toolchain:latest

# To install a specific version, 
docker pull hyun04p/containerized-teensy-toolchain:[version]
```

## 2. Creating a Project
```shell
# Navigate into the directory to initialize.
cd /path/to/your project 

# This initializes the project in current directory. Current directory must be empty.
# This is the only time you will directly interact with Docker CLI
# For WINDOWS: "$(pwd)", the directory, is in format //c/folder/folder
docker run -e MODE=init -v "$(pwd)":/root/mount hyun04p/containerized-teensy-toolchain

# Grant execute permission to ttc.sh 
chmod ou+x ttc.sh

# Start coding in src/main.cpp

# Build your project with
./ttc.sh build

# Use teensy loader to load main.hex binary into Teensy
# Teensy Loader: https://www.pjrc.com/teensy/loader.html
```

## 3. Using ttc.sh (Unix)
```shell
./ttc.sh build

./ttc.sh clean (coming soon)

./ttc.sh clean-lib (coming soon)

./ttc.sh clean-makefiles (coming soon)

./ttc.sh load (maybe coming soon)
```

## 4. Using ttc.bat (Windows)
```shell
./ttc.bat build

./ttc.bat clean (coming soon)

./ttc.bat clean-lib (coming soon)

./ttc.bat clean-makefiles (coming soon)

./ttc.bat load (maybe coming soon)
```


## Windows Tips
For docker in windows, directories are in the format of `//c/folder/folder`

Where c is the drive letter, and `//` specify that its a directory
