#!/bin/bash

# Download URLs
URL_KERNEL="http://dist.gem5.org/dist/v22-1/kernels/x86/static/vmlinux-5.4.49"
URL_PARSEC="https://dist.gem5.org/dist/v20-1/images/x86/ubuntu-18-04/parsec.img.gz"

# Download kernel
echo "Downloading x86 Linux kernel..."
wget -c "$URL_KERNEL" -O "x86-linux-kernel-5.4.49"

# Download parsec image
echo "Downloading Parsec image..."
wget -c "$URL_PARSEC" -O "parsec.img.gz"

# Unzip parsec image
echo "Unzipping Parsec image..."
gunzip -c parsec.img.gz > x86-parsec
rm -f parsec.img.gz

echo "Download complete."