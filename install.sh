#!/bin/bash
IP=`ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/'`
docker build --build-arg VIVADO_TAR_HOST=$IP:8000 --build-arg VIVADO_TAR_FILE=Xilinx_Vivado_SDK_2017.2_0616_1 --build-arg VIVADO_VERSION=2017.2 -t vivado .