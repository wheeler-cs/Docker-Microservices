FROM debian:stable

# TODO List
#   - Update Calibre on container start.
#   - Create a bind mount to allow host-container ebook sharing.
#   - Setup de-DRM tooling.


# === System Level Tasks =======================================================
# Update and install packages
RUN apt update && apt upgrade -y
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


# === Root User Tasks ==========================================================
WORKDIR /root

# Install Calibre
RUN wget https://download.calibre-ebook.com/linux-installer.sh && \
    chmod 700 linux-installer.sh && \
    ./linux-installer.sh

# Create calibre user and needed directories
RUN useradd -ms /bin/bash calibre
RUN mkdir /srv/calibre && chown calibre:calibre /srv/calibre
RUN mkdir /var/log/calibre && chown calibre:calibre /var/log/calibre


# === Calibre User Tasks =======================================================
USER calibre
WORKDIR /home/calibre
COPY .bashrc .bashrc

# Create Calibre library and userdb
RUN mkdir library && \
    calibredb list --library-path=./library
RUN calibre-server --userdb /srv/calibre/users.sqlite \
    --manage-users -- add calibre calibre calibre
RUN ln -s /var/log/calibre log


# === Container Configuration ==================================================
EXPOSE 8080

# Run Calibre server on startup
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["source .bashrc && \
      calibre-server --log /var/log/calibre/calibre.log \
                     --userdb /srv/calibre/users.sqlite \
                     --enable-auth library"]
                     
