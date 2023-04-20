FROM  nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

SHELL ["/bin/bash", "-ceuxo", "pipefail"]

ENV DEBIAN_FRONTEND=noninteractive PIP_PREFER_BINARY=1 PIP_NO_CACHE_DIR=1

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    build-essential \
    less \
    curl \
    fonts-dejavu-core \
    rsync \
    git \
    jq \
    moreutils \
    fontconfig \
    libgl1-mesa-dev

RUN apt-get install -y --no-install-recommends \
    python3-dev \
    python3-pip \
    python3-distutils \
    python3-setuptools \
    python-is-python3

RUN pip install --upgrade pip
RUN pip install --upgrade xformers==0.0.18
RUN pip install --upgrade numpy==1.23.5
RUN pip install --upgrade torch==2.0.0 torchvision==0.15.1 --index-url https://download.pytorch.org/whl/cu118
RUN pip install opencv-python-headless pyngrok fastapi
RUN pip install git+https://github.com/openai/CLIP.git

ARG USER_NAME=user
RUN apt-get install -y --no-install-recommends sudo \
  && useradd -m -s /bin/bash $USER_NAME \
  && echo "${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers
USER $USER_NAME
WORKDIR /home/$USER_NAME