FROM ubuntu:16.04

MAINTAINER Noah Huetter <noahhuetter@gmail.com>

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
  curl \
  libjpeg62 libtiff5 libgtk-3-dev libgtk2.0-0 \
  xvfb lib32ncurses5 lib32z1 lib32stdc++6 \
  lsb-release


# HLS specific
RUN ln -s /usr/lib/x86_64-linux-gnu/libtiff.so.5 /usr/lib/x86_64-linux-gnu/libtiff.so.3

# Get sudo
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

# copy in config file
COPY install_config.txt /

# download and run the install
ARG VIVADO_HOST_FILE
ARG VIVADO_TAR_FILE
ARG VIVADO_VERSION

RUN echo "Download and untar vivado" && \
  curl -L ${VIVADO_HOST_FILE} \
  | tar -xz

# Delete old releases
RUN rm -rf /opt/Xilinx
RUN echo "Installing Vivado" && \
  ${VIVADO_TAR_FILE}/xsetup --agree XilinxEULA,3rdPartyEULA,WebTalkTerms --batch Install --config install_config.txt && \
  rm -rf ${VIVADO_TAR_FILE}*

#make a Vivado user
RUN useradd -m vivado && echo "vivado:vivado" | chpasswd && adduser vivado sudo
# Enable passwordless sudo for users under the "sudo" group
RUN sed -i.bkp -e \
      's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' \
      /etc/sudoers

USER vivado
WORKDIR /home/vivado
#add vivado tools to path
RUN echo "source /opt/Xilinx/Vivado/${VIVADO_VERSION}/settings64.sh" >> /home/vivado/.bashrc

#copy in the license file
RUN mkdir /home/vivado/.Xilinx
#COPY Xilinx.lic /home/vivado/.Xilinx/
