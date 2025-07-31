#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "libpqxx" ]; then
    git clone https://github.com/jtv/libpqxx.git
fi
cd libpqxx
git checkout 7.10.1

# compile libpqxx
INSTALL_PATH=../../../out/libpqxx
rm -rf build
mkdir -p build
cd build
cmake -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH} -D CMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DSKIP_BUILD_TEST=ON  ..
cmake --build . -j20 --target install

cd ../../..
pwd
