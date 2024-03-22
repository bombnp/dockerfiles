FROM python:3.11-bullseye
WORKDIR /app

# Update package list
# Install wget, xz-utils, and perl (required for TeXLive)
RUN apt-get update && apt-get -y install wget xz-utils perl

# # Download and extract TeXLive installation script
RUN wget https://ctan.mirror.twds.com.tw/tex-archive/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && \
    rm install-tl-unx.tar.gz && \
    cd install-tl-* && \
    echo "selected_scheme scheme-basic" > texlive.profile && \
    ./install-tl --profile ./texlive.profile -repository https://ctan.mirror.twds.com.tw/tex-archive/systems/texlive/tlnet && \
    cd .. && \
    rm -rf install-tl-*

# Add TeXLive to PATH
ENV PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
# For images built in ARM64
ENV PATH="/usr/local/texlive/2024/bin/aarch64-linux:$PATH"

ENTRYPOINT [ "/bin/bash" ]