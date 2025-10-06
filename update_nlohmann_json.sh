#!/bin/bash

# nlohmann
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "nlohmann" ]; then
    git clone https://github.com/nlohmann/json.git
fi
cd json
git checkout v3.11.2

INSTALL_PATH=../../../out/nlohmann
rm -rf build
mkdir -p build
cd build
cmake .. -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH}
cmake --build . -j20 --target install
cd ../../..
pwd