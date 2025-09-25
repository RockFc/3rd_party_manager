#!/bin/bash

# iguana + frozen
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "iguana" ]; then
    git clone https://github.com/qicosmos/iguana.git
fi
cd iguana
git checkout 1.0.9

INSTALL_PATH=../../out
mkdir -p ${INSTALL_PATH}
cp -r iguana ${INSTALL_PATH}
cp -r frozen ${INSTALL_PATH}
cd ../..
pwd

# modern-cpp-kafka
SOURCE_PATH=./src
mkdir -p ${SOURCE_PATH}
cd ${SOURCE_PATH}
if [ ! -e "modern-cpp-kafka" ]; then
    git clone https://github.com/morganstanley/modern-cpp-kafka.git
fi
cd modern-cpp-kafka
git checkout v2024.07.03

INSTALL_PATH=../../out
mkdir -p ${INSTALL_PATH}
cp -r include/kafka ${INSTALL_PATH}

cd ../..
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

INSTALL_PATH=../../out/prometheus-cpp-lite
mkdir -p ${INSTALL_PATH}

cp -r * ${INSTALL_PATH}

cd ../..
pwd
