FROM debian:stable


# === Container Configuration ==================================================
ENTRYPOINT [ "/bin/bash" ]


# === System Level Tasks =======================================================
# Update and install packages
RUN apt update && apt upgrade -y
RUN apt install build-essential \
                binutils-arm-none-eabi \
                git \
                libpng-dev \
                pkg-config \
                -y

# === Root User Tasks ==========================================================
RUN useradd -ms /bin/bash poke


# === Poke User Tasks ==========================================================
USER poke
WORKDIR /home/poke
COPY --chown=poke:poke .bashrc /home/poke/

# Clone GitHub repos
RUN git clone https://github.com/pret/agbcc && \
    git clone https://github.com/pret/pokeemerald

# Build and install AGBCC
RUN cd /home/poke/agbcc && \
    ./build.sh && \
    ./install.sh /home/poke/pokeemerald

# Build game ROM
RUN . /home/poke/.bashrc && \
    cd /home/poke/pokeemerald && \
    make
