#!/bin/bash
docker build --build-arg VIVADO_TAR_HOST=localhost:8000 --build-arg VIVADO_TAR_FILE=Xilinx_Vivado_SDK_2017.2_0616_1 --build-arg VIVADO_VERSION=2017.2 -t vivado .