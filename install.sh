#!/bin/bash
#IP=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`
IP=192.168.0.27
docker build \
    --build-arg VIVADO_TAR_HOST=$IP:8000 \
    --build-arg VIVADO_TAR_FILE=Xilinx_Vivado_SDK_2017.3_1005_1 \
    --build-arg VIVADO_VERSION=2017.3 \
    -t noah-vivado .
