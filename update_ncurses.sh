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
if [ ! -e "ncurses-6.4" ]; then
    wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.4.tar.gz
    tar -xzf ncurses-6.4.tar.gz
fi
cd ncurses-6.4

# compile libmodbus
rm -rf build
mkdir -p build
# 仅当 configure 不存在时运行 autogen.sh
if [ ! -f configure ]; then
    ./autogen.sh  # 可能需要 autoconf/automake 工具链
fi
./configure --prefix=$PWD/build  --enable-static --enable-shared
make install -j20
cd ../..
pwd

mkdir -p ./out/ncurses-6.4

# cp ncurses-6.4
cp -rf ./src/ncurses-6.4/build/include ./out/ncurses-6.4
cp -rf ./src/ncurses-6.4/build/lib ./out/ncurses-6.4