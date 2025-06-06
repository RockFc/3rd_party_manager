#!/bin/bash

# iguana
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "iguana" ]; then
    git clone --depth 1 https://github.com/qicosmos/iguana.git
fi
cd iguana
git checkout 1.0.9

INSTALL_PATH=../../out
mkdir -p ${INSTALL_PATH}
cp -r iguana ${INSTALL_PATH}

cd ../..
pwd


SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "iguana" ]; then
    git clone --depth 1 https://github.com/qicosmos/iguana.git
fi
cd iguana
git checkout 1.0.9

INSTALL_PATH=../../out
mkdir -p ${INSTALL_PATH}
cp -r iguana ${INSTALL_PATH}

cd ../..
pwd