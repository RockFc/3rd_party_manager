#!/bin/bash

# 检查 autoreconf 是否存在
#!/bin/bash

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

# git clone
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "libmodbus" ]; then
    git clone --depth 1 https://github.com/stephane/libmodbus.git
fi
cd libmodbus
git checkout v3.1.10

# compile libmodbus
rm -rf build
mkdir -p build
./autogen.sh
./configure --prefix=$PWD/build  --enable-static --enable-shared
make install -j20
cd ../..
pwd

mkdir -p ./out/libmodbus

# cp libmodbus
cp -rf ./src/libmodbus/build/include ./out/libmodbus
cp -rf ./src/libmodbus/build/lib ./out/libmodbus