#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "protobuf" ]; then
    git clone https://github.com/protocolbuffers/protobuf.git
fi
cd protobuf
git submodule update --init --recursive
git checkout v25.3

# compile protobuf
INSTALL_PATH=../../../out/protobuf
rm -rf build
mkdir -p build
cd build
cmake -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH} -D CMAKE_CXX_STANDARD=17 -D protobuf_BUILD_TESTS=OFF -D BUILD_SHARED_LIBS=ON -D CMAKE_BUILD_TYPE=Release .. 
cmake --build . -j20 --target install

cd ../../..
pwd