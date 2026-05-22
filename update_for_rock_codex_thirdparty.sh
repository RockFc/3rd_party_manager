#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#------------------------------------src--------------------------------------------------

# iguana + frozen
SOURCE_PATH=$SCRIPT_DIR/src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "iguana" ]; then
    git clone https://github.com/qicosmos/iguana.git
fi
cd iguana
git checkout 1.0.9

INSTALL_PATH=$SCRIPT_DIR/../rock_codex/thirdparty/src
mkdir -p ${INSTALL_PATH}
cp -r iguana ${INSTALL_PATH}
cp -r frozen ${INSTALL_PATH}

cd $SCRIPT_DIR
pwd

# modern-cpp-kafka
SOURCE_PATH=$SCRIPT_DIR/src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "modern-cpp-kafka" ]; then
    git clone https://github.com/morganstanley/modern-cpp-kafka.git
fi
cd modern-cpp-kafka
git checkout v2024.07.03

INSTALL_PATH=$SCRIPT_DIR/../rock_codex/thirdparty/src
mkdir -p ${INSTALL_PATH}
cp -r include/kafka ${INSTALL_PATH}

cd $SCRIPT_DIR
pwd

# prometheus-cpp-lite
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "prometheus-cpp-lite" ]; then
    git clone https://github.com/biaks/prometheus-cpp-lite.git
fi
cd prometheus-cpp-lite
git checkout v1.0

INSTALL_PATH=$SCRIPT_DIR/../rock_codex/thirdparty/src/prometheus-cpp-lite
mkdir -p ${INSTALL_PATH}
cp -r * ${INSTALL_PATH}

cd $SCRIPT_DIR
pwd

# spdlog
SOURCE_PATH=$SCRIPT_DIR/src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "spdlog" ]; then
    git clone https://github.com/gabime/spdlog.git
fi
cd spdlog
git checkout v1.15.0

INSTALL_PATH=$SCRIPT_DIR/../rock_codex/thirdparty/src
mkdir -p ${INSTALL_PATH}
cp -r include/spdlog ${INSTALL_PATH}

cd $SCRIPT_DIR
pwd

#------------------------------------lib--------------------------------------------------

# googletest
SOURCE_PATH=$SCRIPT_DIR/src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "googletest" ]; then
    git clone --depth 1 https://github.com/google/googletest.git
fi
cd googletest

INSTALL_PATH=$SCRIPT_DIR/../rock_codex/thirdparty/lib/UNIX/googletest
rm -rf build
mkdir -p build
cd build
cmake .. -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH}
cmake --build . -j20 --target install
cd $SCRIPT_DIR
pwd

# libhv
SOURCE_PATH=$SCRIPT_DIR/src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "libhv" ]; then
    git clone https://github.com/ithewei/libhv.git
fi
cd libhv
git checkout v1.3.3

INSTALL_PATH=$SCRIPT_DIR/../rock_codex/thirdparty/lib/UNIX/libhv
rm -rf build
mkdir -p build
cd build
cmake .. -D BUILD_EXAMPLES=OFF -D WITH_OPENSSL=OFF -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH}
cmake --build . -j20 --target install
cd $SCRIPT_DIR
pwd

# libmodbus
# 检查 autoreconf 是否存在以及 autoconf 软件包是否安装
if ! dpkg -l | grep -q "^ii  autoconf "; then
    echo "autoreconf 未安装，正在安装所需的依赖项..."

    # 更新软件包列表
    sudo apt update

    # 安装 autoconf 和其他依赖工具
    sudo apt install -y autoconf automake libtool pkg-config

    echo "autoreconf 安装完成。"
else
    echo "autoreconf 已安装，无需操作。"
fi

SOURCE_PATH=$SCRIPT_DIR/src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "libmodbus" ]; then
    git clone https://github.com/stephane/libmodbus.git
fi
cd libmodbus
git checkout v3.1.10

rm -rf build
mkdir -p build
./autogen.sh
./configure --prefix=$PWD/build  --enable-static --enable-shared
make install -j20
cd $SCRIPT_DIR
pwd

INSTALL_PATH=$SCRIPT_DIR/../rock_codex/thirdparty/lib/UNIX/libmodbus
mkdir -p $INSTALL_PATH
cp -rf ./src/libmodbus/build/include $INSTALL_PATH
cp -rf ./src/libmodbus/build/lib $INSTALL_PATH

# libpqxx
SOURCE_PATH=$SCRIPT_DIR/src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "libpqxx" ]; then
    git clone https://github.com/jtv/libpqxx.git
fi
cd libpqxx
git checkout 7.10.1

INSTALL_PATH=$SCRIPT_DIR/../rock_codex/thirdparty/lib/UNIX/libpqxx
rm -rf build
mkdir -p build
cd build
cmake -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH} -D CMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DSKIP_BUILD_TEST=ON  ..
cmake --build . -j20 --target install

cd $SCRIPT_DIR
pwd

# librdkafka
SOURCE_PATH=$SCRIPT_DIR/src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "librdkafka" ]; then
    git clone https://github.com/confluentinc/librdkafka.git
fi
cd librdkafka
git checkout v2.4.0

INSTALL_PATH=$SCRIPT_DIR/../rock_codex/thirdparty/lib/UNIX/librdkafka
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

cd $SCRIPT_DIR
pwd

# mysql-connector-cpp
SOURCE_PATH=$SCRIPT_DIR/src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "mysql-connector-cpp" ]; then
    git clone --depth 1 https://github.com/mysql/mysql-connector-cpp.git
fi
cd mysql-connector-cpp
git checkout 9.3.0

# compile mysql-connector-cpp
INSTALL_PATH=$SCRIPT_DIR/../rock_codex/thirdparty/lib/UNIX/mysql-connector-cpp
rm -rf build
mkdir -p build
cd build
cmake -D CMAKE_INSTALL_PREFIX=${INSTALL_PATH} -D CMAKE_BUILD_TYPE=Release -D WITH_DEVAPI=ON -D WITH_JDBC=ON -D WITH_TESTS=OFF -D BUILD_STATIC=ON ..
cmake --build . -j20 --target install

cd $SCRIPT_DIR
pwd

# arrow
SOURCE_PATH=$SCRIPT_DIR/src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}

ARROW_VERSION=apache-arrow-18.1.0

if [ ! -e "arrow" ]; then
    git clone --depth 1 --branch ${ARROW_VERSION} https://github.com/apache/arrow.git
fi

# compile arrow
INSTALL_PATH=$SCRIPT_DIR/../rock_codex/thirdparty/lib/UNIX/arrow
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
cd $SCRIPT_DIR
pwd