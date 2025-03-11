#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "oneTBB" ]; then
    git clone --depth 1 https://github.com/uxlfoundation/oneTBB.git
fi
cd oneTBB
git checkout v2022.0.0

# compile curl
INSTALL_PATH=../../../out/oneTBB
rm -rf build
mkdir -p build
cd build
cmake -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH}  -D TBB_TEST=OFF   ..
cmake --build . -j20 --target install

cd ../../..
pwd