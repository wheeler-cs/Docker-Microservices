FROM debian:stable

# TODO List
#   - Update Calibre on container start.
#   - Create a bind mount to allow host-container ebook sharing.

# IN-PROGRESS
#   - Use libgourou instead of the DeDRM plugin.


# === Container Initialization ==================================================
EXPOSE 8080

# Run Calibre server on startup
ENTRYPOINT ["/bin/bash"]
#ENTRYPOINT ["/bin/bash", "-c"]
#CMD ["source .bashrc && \
#      echo Calibre server running && \
#      calibre-server --log /var/log/calibre/calibre.log \
#                     --userdb /srv/calibre/users.sqlite \
#                     --enable-auth \
#                     /home/calibre/library \
#                     2>&1 | tee /var/log/calibre/error.log"]

RUN useradd -ms /bin/bash calibre
WORKDIR /tmp

# === Root User Tasks ==========================================================
COPY --chmod=777 scripts/install_pkgs.sh .
RUN ./install_pkgs.sh
COPY --chmod=777 scripts/* .
RUN ./init_dirs.sh && ./install_calibre.sh && ./install_libgourou.sh
RUN ./clean_files.sh

# === Calibre User Tasks =======================================================
USER calibre
COPY .bashrc /home/calibre/

RUN ./init_calibre.sh
