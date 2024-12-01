#!/usr/bin/env bash
echo "Cloning dependencies"
git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_aarch64_aarch64-linux-android-4.9 los-4.9-64
git clone --depth=1 https://github.com/LineageOS/android_prebuilts_gcc_linux-x86_arm_arm-linux-androideabi-4.9 los-4.9-32
echo "Done"
KERNEL_DIR=$(pwd)
PATH="${PWD}/clang/bin:$PATH"
export KBUILD_COMPILER_STRING="$(${KERNEL_DIR}/clang/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g')"
export ARCH=arm64
export KBUILD_BUILD_HOST=Eblan
export KBUILD_BUILD_USER="Pizda"
# Compile plox
function compile() {

    make O=out ARCH=arm64 a71_defconfig
    make -j$(nproc --all) O=out \
                          ARCH=arm64 \
			  LTO=thin \
			  CC=clang \
			  CROSS_COMPILE=aarch64-linux-gnu- \
			  CROSS_COMPILE_ARM32=arm-linux-gnueabi-
}
compile
