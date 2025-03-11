#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "libevent" ]; then
    git clone --depth 1 https://github.com/libevent/libevent.git
fi
cd libevent
git checkout release-2.1.12-stable

# compile libevent
INSTALL_PATH=../../../out/libevent
rm -rf build
mkdir -p build
cd build
cmake -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH} ..
cmake --build . -j20 --target install

cd ../../..
pwd