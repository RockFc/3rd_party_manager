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
if [ ! -e "lz4" ]; then
    git clone --depth 1 https://github.com/lz4/lz4.git
fi
cd lz4

# compile lz4
INSTALL_PATH=../../../out/lz4
make
make PREFIX=${INSTALL_PATH} install

cd ../..
pwd