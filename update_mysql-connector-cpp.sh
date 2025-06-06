#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "mysql-connector-cpp" ]; then
    git clone --depth 1 https://github.com/mysql/mysql-connector-cpp.git
fi
cd mysql-connector-cpp
git checkout 9.3.0

# compile mysql-connector-cpp
INSTALL_PATH=../../../out/mysql-connector-cpp
rm -rf build
mkdir -p build
cd build
cmake -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH} -D CMAKE_BUILD_TYPE=Release -D WITH_DEVAPI=ON -D WITH_TESTS=OFF -D BUILD_STATIC=ON ..
cmake --build . -j20 --target install

cd ../../..
pwd