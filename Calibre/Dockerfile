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
                -y

# Install Calibre
RUN wget https://download.calibre-ebook.com/linux-installer.sh && chmod 700 linux-installer.sh
RUN ./linux-installer.sh

# Configure update on launch
ENTRYPOINT ["/bin/bash", "-c"]
# BUG: Not all of these commands are running
CMD ["wget https://download.calibre-ebook.com/linux-installer.sh -O linux-installer.sh", \
     "chmod 700 linux-installer.sh", \
     "./linux-installer.sh", \
     "calibre-server"]
