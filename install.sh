#!/bin/bash

# From where to download
HOST_FILE=192.168.1.155:8000/Xilinx_Vivado_SDK_2018.2_0614_1954.tar.gz
# Name of the tar file without extension
VIVADO_TAR_FILE=Xilinx_Vivado_SDK_2018.2_0614_1954

docker build \
    --build-arg VIVADO_HOST_FILE=$HOST_FILE \
    --build-arg VIVADO_TAR_FILE=$VIVADO_TAR_FILE \
    --build-arg VIVADO_VERSION=2018.2 \
    -t docker-vivado:2018.2 .
