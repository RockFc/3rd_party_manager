#!/bin/bash

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}

ARROW_VERSION=apache-arrow-18.1.0

if [ ! -e "arrow" ]; then
    git clone --depth 1 --branch ${ARROW_VERSION} https://github.com/apache/arrow.git
fi

# compile arrow
INSTALL_PATH=../../../../out/arrow
cd arrow/cpp
rm -rf build
mkdir -p build
cd build
cmake .. \
    -DARROW_BUILD_STATIC=ON \
    -DARROW_BUILD_SHARED=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} \
    -DARROW_DEPENDENCY_SOURCE=BUNDLED \
    -DThrift_SOURCE=SYSTEM \
    -DARROW_BUILD_TESTS=OFF \
    -DARROW_BUILD_BENCHMARKS=OFF \
    -DARROW_BUILD_EXAMPLES=OFF \
    -DARROW_GANDIVA=OFF \
    -DARROW_FLIGHT=OFF \
    -DARROW_PARQUET=ON \
    -DARROW_CSV=ON \
    -DARROW_JSON=ON \
    -DARROW_IPC=ON \
    -DARROW_WITH_ZSTD=ON \
    -DARROW_WITH_LZ4=ON \
    -DARROW_WITH_SNAPPY=ON

cmake --build . -j$(nproc) --target install
cd ../../..
pwd