FROM debian:stable

# Update repos and install packages
RUN apt update
RUN apt install wget \
                python3 \
                libegl1 \
                libopengl0 \
                libxcb-cursor0 \
                libfreetype6-dev \
                tar \
                xz-utils \
                qt6-base-dev \
                -y

# Install Calibre
RUN wget https://download.calibre-ebook.com/linux-installer.sh && chmod 700 linux-installer.sh
RUN ./linux-installer.sh

# Setup Calibre database
RUN mkdir library && calibredb list --library-path=./library

# Configure update on launch
ENTRYPOINT ["/bin/bash", "-c"]
# TODO: Update server on startup
CMD ["calibre-server library"]
