#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "librdkafka" ]; then
    git clone --depth 1 https://github.com/confluentinc/librdkafka.git
fi
cd librdkafka
git checkout v2.8.0

# compile librdkafka
INSTALL_PATH=../../../out/librdkafka
rm -rf build
mkdir -p build
cd build
cmake -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH} ..
cmake --build . -j20 --target install

cd ../../..
pwd