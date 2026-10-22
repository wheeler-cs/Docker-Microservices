FROM debian:stable

ARG DEDRM_REPO=https://github.com/Satsuoni/DeDRM_tools.git

# Mirror of libgourou on an actually-accessible site
ARG LIBGOUROU_REPO=https://github.com/wheeler-cs/libgourou-mirror

# TODO List
#   - Use libgourou instead of the DeDRM plugin.
#   - Update Calibre on container start.
#   - Create a bind mount to allow host-container ebook sharing.


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
                     2>&1 | tee /var/log/calibre/error.log"]


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
                vim \
                wget \
                xz-utils \
                zip \
                -y


# === Root User Tasks ==========================================================
WORKDIR /tmp

# Create calibre user and needed directories
RUN useradd -ms /bin/bash calibre
RUN mkdir /srv/calibre /var/log/calibre /etc/calibre && \
    chown calibre:calibre /srv/calibre /var/log/calibre /etc/calibre

# Install Calibre and clean up
RUN export CALIBRE_CONFIG_DIRECTORY="/etc/calibre" && \
    wget https://download.calibre-ebook.com/linux-installer.sh && \
    chmod 700 linux-installer.sh && \
    ./linux-installer.sh && \
    rm -rf /tmp/*


# === Calibre User Tasks =======================================================
USER calibre
WORKDIR /home/calibre
COPY .bashrc keytojson.py test/* /home/calibre/
COPY --chown=calibre:calibre adobekey.der /tmp/

# Create Calibre directories, library, and databases
RUN mkdir -p /home/calibre/library && \
    ln -s /var/log/calibre log
RUN calibredb list --library-path=/home/calibre/library && \
    calibre-server --userdb /srv/calibre/users.sqlite \
                   --manage-users -- add calibre calibre calibre

# Download and install DeDRM packages
RUN git clone $DEDRM_REPO /tmp/DeDRM && \
    cd /tmp/DeDRM && \
    python3 make_release.py && \
    mv DeDRM_tools.zip /tmp && \
    cd /tmp && \
    unzip DeDRM_tools.zip
RUN export CALIBRE_CONFIG_DIRECTORY="/etc/calibre" && \
    calibre-customize -a /tmp/DeDRM_plugin.zip && \
    calibre-customize -a /tmp/Obok_plugin.zip && \
    python3 keytojson.py && \
    rm -rf /tmp/*
