#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "librdkafka" ]; then
    git clone https://github.com/confluentinc/librdkafka.git
fi
cd librdkafka
git checkout v2.4.0

# compile librdkafka
INSTALL_PATH=../../../out/librdkafka
rm -rf build
mkdir -p build
cd build
cmake   -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH} \
        -D RDKAFKA_BUILD_STATIC=ON \
        -D RDKAFKA_BUILD_EXAMPLES=OFF \
        -D RDKAFKA_BUILD_TESTS=OFF \
        -D WITH_SSL=OFF \
        -D WITH_SASL=OFF \
        -D WITH_ZLIB=OFF \
        -D WITH_CURL=OFF \
        -D WITH_ZSTD=OFF \
        -D ENABLE_LZ4_EXT=OFF \
        ..
cmake --build . -j20 --target install

cd ../../..
pwd