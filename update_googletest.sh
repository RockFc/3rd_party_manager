#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "googletest" ]; then
    git clone --depth 1 https://github.com/google/googletest.git
fi
cd googletest

# compile googletest
INSTALL_PATH=../../../out/googletest
rm -rf build
mkdir -p build
cd build
cmake .. -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH}
cmake --build . -j20 --target install
cd ../../..
pwd