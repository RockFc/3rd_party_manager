#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "slow5lib" ]; then
    git clone --depth 1 https://github.com/hasindu2008/slow5lib.git
fi
cd slow5lib
git checkout v1.3.0

# compile curl
INSTALL_PATH=../../../out/slow5lib
rm -rf build
mkdir -p build
cd build
cmake -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH}  ..
cmake --build . -j20

# 手动安装 (拷贝库文件和头文件)
# 拷贝库文件
if [ -f libslow5.a ]; then
    mkdir -p ${INSTALL_PATH}/lib
    cp libslow5.a ${INSTALL_PATH}/lib/
    mkdir -p ${INSTALL_PATH}/include
    cp -r ../include/* ${INSTALL_PATH}/include/
    echo "slow5lib installed to ${INSTALL_PATH}"
fi
if [ -f libslow5.so ]; then
    mkdir -p ${INSTALL_PATH}/lib
    cp libslow5.so ${INSTALL_PATH}/lib/
    mkdir -p ${INSTALL_PATH}/include
    cp -r ../include/* ${INSTALL_PATH}/include/
    echo "slow5lib installed to ${INSTALL_PATH}"
fi

cd ../../..
pwd