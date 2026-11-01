#!/bin/bash

apt update
apt upgrade -y
apt install g++ \
    git \
    libcurl4-gnutls-dev \
    libegl1 \
    libfreetype6-dev \
    libopengl0 \
    libpugixml-dev \
    libxcb-cursor0 \
    libzip-dev \
    make \
    openssl \
    python3 \
    qt6-base-dev \
    tar \
    vim \
    wget \
    xz-utils \
    zip \
    -y
