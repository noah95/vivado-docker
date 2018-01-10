FROM ubuntu:16.04

MAINTAINER Noah Huetter <noahhuetter@gmail.com>

# build with sudo docker build --build-arg VIVADO_TAR_HOST=$IP:8000 --build-arg VIVADO_TAR_FILE=Xilinx_Vivado_SDK_2017.2_0616_1 --build-arg VIVADO_VERSION=2017.2 -t vivado .

#install dependences for:
# * downloading Vivado (wget)
# * xsim (gcc build-essential to also get make)
# * MIG tool (libglib2.0-0 libsm6 libxi6 libxrender1 libxrandr2 libfreetype6 libfontconfig)
# * CI (git)
RUN apt-get update && apt-get install -y \
  wget \
  build-essential \
  libglib2.0-0 \
  libsm6 \
  libxi6 \
  libxrender1 \
  libxrandr2 \
  libfreetype6 \
  libfontconfig \
  git \
  libjpeg62

# Get sudo
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

# Fix for libtiff.so.3
RUN ln -s /usr/lib/x86_64-linux-gnu/libtiff.so.5 /usr/lib/x86_64-linux-gnu/libtiff.so.3

# copy in config file
COPY install_config.txt /

# download and run the install
ARG VIVADO_TAR_HOST
ARG VIVADO_TAR_FILE
ARG VIVADO_VERSION
RUN echo "Downloading ${VIVADO_TAR_FILE} from ${VIVADO_TAR_HOST}" && \
  wget ${VIVADO_TAR_HOST}/${VIVADO_TAR_FILE}.tar.gz -q --show-progress && \
  echo "Extracting Vivado tar file" && \
  tar xzf ${VIVADO_TAR_FILE}.tar.gz && \
  /${VIVADO_TAR_FILE}/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA --batch Install --config install_config.txt && \
  rm -rf ${VIVADO_TAR_FILE}*
#make a Vivado user
RUN adduser --disabled-password --gecos '' vivado
RUN usermod -aG root vivado
USER vivado
WORKDIR /home/vivado
#add vivado tools to path
RUN echo "source /opt/Xilinx/Vivado/${VIVADO_VERSION}/settings64.sh" >> /home/vivado/.bashrc

#copy in the license file
RUN mkdir /home/vivado/.Xilinx
COPY Xilinx.lic /home/vivado/.Xilinx/
