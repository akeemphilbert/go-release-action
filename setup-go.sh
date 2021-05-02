#!/bin/bash -eux

GO_LINUX_PACKAGE_URL="https://golang.org/dl/go1.16.2.linux-amd64.tar.gz"
if [[ ${INPUT_GOVERSION} == "1.15" ]]; then
    GO_LINUX_PACKAGE_URL="https://golang.org/dl/go1.15.10.linux-amd64.tar.gz"
elif [[ ${INPUT_GOVERSION} == "1.14" ]]; then
    GO_LINUX_PACKAGE_URL="https://golang.org/dl/go1.14.15.linux-amd64.tar.gz"
elif [[ ${INPUT_GOVERSION} == "1.13" ]]; then
    GO_LINUX_PACKAGE_URL="https://dl.google.com/go/go1.13.8.linux-amd64.tar.gz"
elif [[ ${INPUT_GOVERSION} == http* ]]; then
    GO_LINUX_PACKAGE_URL=${INPUT_GOVERSION}
fi

wget --progress=dot:mega ${GO_LINUX_PACKAGE_URL} -O go-linux.tar.gz 
tar -zxf go-linux.tar.gz
mv go /usr/local/
mkdir -p /go/bin /go/src /go/pkg

export GO_HOME=/usr/local/go
export GOPATH=/go
export PATH=${GOPATH}/bin:${GO_HOME}/bin/:$PATH

apt update \
 && apt install -y \
    gcc \
    libblkid-dev \
    gcc-aarch64-linux-gnu \
    libc6-dev-arm64-cross \
    gcc-multilib \
    libc6-dev-i386 \
    linux-libc-dev:i386 \
    gcc-mingw-w64-x86-64 \
    gcc-mingw-w64-i686 \
 && apt clean \
 && apt autoremove -y \
 && rm -rf /var/lib/apt/lists/*


