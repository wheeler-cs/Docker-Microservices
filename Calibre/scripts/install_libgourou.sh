#!/bin/bash

REPO_DIR=$(pwd)
LIBGOUROU_REPO="https://github.com/wheeler-cs/libgourou-mirror"

# Clone personal mirror of libgourou
git clone $LIBGOUROU_REPO $REPO_DIR/libgourou

# Build and install shared libraries
cd $REPO_DIR/libgourou/lib/updfparser && make && make libupdfparser.a
cd $REPO_DIR/libgourou && make && make install

# Install executables to PATH
cp $REPO_DIR/libgourou/utils/acsmdownloader \
   $REPO_DIR/libgourou/utils/adept_activate \
   $REPO_DIR/libgourou/utils/adept_loan_mgt \
   $REPO_DIR/libgourou/utils/adept_remove \
   /bin
