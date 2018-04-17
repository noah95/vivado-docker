#!/bin/bash
#IP=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`
IP=10.207.8.130
docker build \
    --no-cache \
    --build-arg VIVADO_TAR_HOST=$IP:8000 \
    --build-arg VIVADO_TAR_FILE=Xilinx_Vivado_SDK_2017.3_1005_1 \
    --build-arg VIVADO_VERSION=2017.3 \
    -t docker-vivado:2017.3 .
