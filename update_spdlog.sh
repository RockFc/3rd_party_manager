#!/bin/bash

# git clone 
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "spdlog" ]; then
    git clone --depth 1 https://github.com/gabime/spdlog.git
fi
cd spdlog
git checkout v1.15.0

# compile spdlog
INSTALL_PATH=../../../out/spdlog
rm -rf build
mkdir -p build
cd build
cmake .. -D SPDLOG_BUILD_SHARED=ON -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH}
cmake --build . -j20 --target install
cd ../../..
pwd