#!/usr/bin/env bash
set -e
. ./scripts/build_common.sh
[ -d /data/data/com.termux/files/usr/glibc/bin ] && export PATH=/data/data/com.termux/files/usr/glibc/bin:$PATH
export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-

JOBS=${JOBS:-1}
build -j${JOBS} -s -n 0 -a AARCH64 -t GCC5 -p MSM8909Pkg/Devices/santoni.dsc -b DEBUG

bash ./scripts/build_bootshim.sh
cat BootShim/BootShim64.bin workspace/Build/MSM8909Pkg/DEBUG_GCC5/FV/MSM8909PKG_UEFI.fd > workspace/bootpayload.bin
gzip -c < workspace/bootpayload.bin > workspace/Image.gz
cat workspace/Image.gz device_specific/santoni.dtb > workspace/Image.gz-dtb
python3 ./scripts/mkbootimg --kernel ./workspace/Image.gz-dtb --ramdisk ./device_specific/ramdisk --base 0x80000000 --kernel_offset 0x00080000 --ramdisk_offset 0x01000000 --tags_offset 0x00000100 --pagesize 2048 --header_version 0 --cmdline "" -o boot-santoni.img
echo "Build complete: boot-santoni.img"
