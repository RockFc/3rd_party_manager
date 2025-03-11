#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "curl" ]; then
    git clone --depth 1 https://github.com/curl/curl.git
fi
cd curl
git checkout curl-8_11_1

# compile curl
INSTALL_PATH=../../../out/curl
rm -rf build
mkdir -p build
cd build
cmake -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH} ..
cmake --build . -j20 --target install

cd ../../..
pwd