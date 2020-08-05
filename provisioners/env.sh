#!/bin/bash

set -x

export DEBIAN_FRONTEND=noninteractive

export GO_VERSION="1.14.6"
export PACKER_VERSION="1.6.1"

pwd

sudo apt-get update -qq

# Provides the add-apt-repository script
sudo apt-get install -yq software-properties-common

# Install required packages
sudo apt-get install -yq \
    git \
    zip \
    unzip \
    wget \


# Install go
wget --no-verbose https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
PATH=$PATH:/usr/local/go/bin
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile

go version
rm go${GO_VERSION}.linux-amd64.tar.gz

# Install packer

wget --no-verbose https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
unzip -q packer_${PACKER_VERSION}_linux_amd64.zip
sudo mv packer /usr/local/bin/

packer --version
rm packer_${PACKER_VERSION}_linux_amd64.zip


# Install packer-builder-arm
sudo apt-get install -yq \
    qemu-utils \
    qemu-user-static \
    e2fsprogs \
    dosfstools \
    parted
    #sgdisk


git clone https://github.com/mkaczanowski/packer-builder-arm
cd packer-builder-arm
go mod download
go build

sudo mv packer-builder-arm /usr/local/bin

cd ..
rm -rf packer-builder-arm
