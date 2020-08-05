#!/bin/bash

echo "Building image ($USERNAME@$HOSTNAME)"

set -x

export DEBIAN_FRONTEND=noninteractive
export PACKER_RESULTING_ARTIFACT="2020-02-13-raspbian-buster-lite.img"

# for some packer is unable to get username :(
sudo USERNAME=$USERNAME packer build ~/templates/raspberry-pi.json

# todo: get packer build artifact name

mv ${PACKER_RESULTING_ARTIFACT} ~/dist
