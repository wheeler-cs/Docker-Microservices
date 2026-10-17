FROM debian:stable

ARG DEDRM_REPO=https://github.com/Satsuoni/DeDRM_tools.git

# TODO List
#   - Setup de-DRM tooling.
#   - Update Calibre on container start.
#   - Create a bind mount to allow host-container ebook sharing.

# BUG List
#   - DeDRM tool currently throws an exception when attempting to import a new
#     eBook.


# === System Level Tasks =======================================================
# Update and install packages
RUN apt update && apt upgrade -y
RUN apt install git \
                libegl1 \
                libfreetype6-dev \
                libopengl0 \
                libxcb-cursor0 \
                python3 \
                qt6-base-dev \
                tar \
                wget \
                xz-utils \
                zip \
                -y


# === Root User Tasks ==========================================================
WORKDIR /root

# Install Calibre
RUN wget https://download.calibre-ebook.com/linux-installer.sh && \
    chmod 700 linux-installer.sh && \
    ./linux-installer.sh

# Create calibre user and needed directories
RUN useradd -ms /bin/bash calibre
RUN mkdir /srv/calibre && \
    chown calibre:calibre /srv/calibre
RUN mkdir /var/log/calibre && \
    chown calibre:calibre /var/log/calibre


# === Calibre User Tasks =======================================================
USER calibre
WORKDIR /home/calibre
COPY .bashrc .bashrc

# Create Calibre directories, library, and databases
RUN mkdir /home/calibre/library /home/calibre/plugins && \
    ln -s /var/log/calibre log
RUN calibredb list --library-path=/home/calibre/library && \
    calibre-server --userdb /srv/calibre/users.sqlite \
                   --manage-users -- add calibre calibre calibre

# Download and install DeDRM packages
RUN git clone $DEDRM_REPO DeDRM
RUN calibre-customize -b /home/calibre/DeDRM/DeDRM_plugin && \
    calibre-customize -b /home/calibre/DeDRM/Obok_plugin


# === Container Configuration ==================================================
EXPOSE 8080

# Run Calibre server on startup
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["source .bashrc && \
      echo Calibre server running && \
      calibre-server --log /var/log/calibre/calibre.log \
                     --userdb /srv/calibre/users.sqlite \
                     --enable-auth \
                     /home/calibre/library \
                     2> /var/log/calibre/error.log"]
