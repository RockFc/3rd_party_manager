#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "hiredis" ]; then
    git clone --depth 1 https://github.com/redis/hiredis.git
fi
cd hiredis
git checkout v1.2.0

# compile hiredis
INSTALL_PATH=../../../out/hiredis
rm -rf build
mkdir -p build
cd build
cmake -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH} ..
cmake --build . -j20 --target install

cd ../../..
pwd