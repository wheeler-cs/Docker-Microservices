FROM debian:stable

# TODO List
#   - Move calibre process to a non-root user.
#   - Add users to Calibre to avoid anonymous uploading.
#   - Update Calibre on container start.
#   - Create a bind mount to allow host-container ebook sharing.
#   - Setup de-DRM tooling.

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
RUN wget https://download.calibre-ebook.com/linux-installer.sh && \
    chmod 700 linux-installer.sh && \
    ./linux-installer.sh
RUN mkdir library && \
    calibredb list --library-path=./library

# Final OS configuration
RUN echo "export LANG=C.UTF-8 LC_ALL=C.UTF-8" >> ~/.bashrc
EXPOSE 8080

# Set up commands run on startup
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["calibre-server --enable-local-write library"]
