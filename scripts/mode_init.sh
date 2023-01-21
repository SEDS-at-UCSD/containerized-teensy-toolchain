#!/bin/bash

echo "[MSG] Running MODE=init"
cd ~/mount

# If you attempt to init non-empty dir, halt
if [ "$(ls -A /root/mount)" ]; then
    echo "[FATAL] Target directory is not empty. Init mode can only be used on empty directory because it is destructive."
    exit 1
fi

mkdir -p src core libraries

echo "[MSG] Copying ttc.sh"
rsync --info=progress2 ~/project/scripts/tools/ttc.sh ./
echo "[MSG] Copying ttc.bat"
rsync --info=progress2 ~/project/scripts/tools/ttc.bat ./
echo "[MSG] Copying README.md"
rsync --info=progress2 ~/project/README.md ./
echo "[MSG] Copying src"
rsync -r --info=progress2 ~/project/src/* ./src/
echo "[MSG] Copying core"
rsync -r --info=progress2 ~/project/core/* ./core/
echo "[MSG] Copying libraries"
rsync -r --info=progress2 ~/project/libraries/ ./libraries
echo "[MSG] Copying top-level Makefile"
rsync --info=progress2 ~/project/Makefile ./
echo "[MGS] Done!"
