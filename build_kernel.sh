#!/usr/bin/env bash
KERNEL_DIR=$(pwd)
PATH="${PWD}/clang/bin:$PATH"
export ARCH=arm64
export KBUILD_BUILD_HOST=Eblan
export KBUILD_BUILD_USER="Pizda"

# Compile
make O=out ARCH=arm64 a71_defconfig
export PATH=${PWD}/clang/bin/:/usr/bin/:${PATH}
export CROSS_COMPILE=aarch64-linux-gnu-
export CROSS_COMPILE_ARM32=arm-linux-gnueabi-
export LLVM=1
export LLVM_TAS=1
export CONFIG_DEBUG_SECTION_MISMATCH=y
make -j$(nproc --all) O=out ARCH=arm64 LTO=thin CC=clang LD=ld.lld AR=llvm-ar AS=llvm-as NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip
