#!/bin/bash
# 环境要求：1.g++支持C++20; 2.较新版本的flatc; 3.zlib; 4.zstd; 5.Apache Arrow
# 1. g++ --version   g++ (Ubuntu 11.4.0-2ubuntu1~20.04) 11.4.0
# 2. flatc --version  flatc version 25.12.19
# 3. pkg-config --modversion zlib  1.2.11
# 4. pkg-config --modversion libzstd 1.6.0
# 5. dpkg -l | grep libarrow  ii  libarrow-dev:amd64  12.0.0-1

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "pod5-file-format" ]; then
    git clone https://github.com/nanoporetech/pod5-file-format.git
fi
cd pod5-file-format
git checkout 0.3.28
python3 -m setuptools_scm
python3 ./pod5_make_version.py

# compile libhv
INSTALL_PATH=../../../out/pod5-file-format
rm -rf build
mkdir -p build
cd build
cmake .. -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH}
cmake --build . -j20 --target install
#还需要拷贝版本文件
cp -rf  ./c++/pod5_format/* ${INSTALL_PATH}/include/pod5_format
cd ../../..
pwd