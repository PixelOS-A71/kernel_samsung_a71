#!/usr/bin/env bash
echo "Cloning dependencies"
sudo apt install bc flex ccache -y
mkdir clang
cd clang
wget https://github.com/ZyCromerZ/Clang/releases/download/20.0.0git-20241201-release/Clang-20.0.0git-20241201.tar.gz
tar -xvzf Clang-20.0.0git-20241201.tar.gz
cd ..
git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 los-4.9-64
git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9 los-4.9-32
echo "Done"
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
