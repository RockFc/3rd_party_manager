#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "libhv" ]; then
    git clone --depth 1 https://github.com/ithewei/libhv.git
fi
cd libhv
git checkout v1.3.3

# compile libhv
INSTALL_PATH=../../../out/libhv
rm -rf build
mkdir -p build
cd build
cmake .. -D BUILD_EXAMPLES=OFF -D WITH_OPENSSL=ON -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH}
cmake --build . -j20 --target install
cd ../../..
pwd