#!/bin/sh

# Exit if anything fails
set -e

# Create a timestamp for uniquefying stuff
timestamp=`date +"%Y%m%d%H%M%S"`

# Install packer
mkdir packer
cd packer
wget https://dl.bintray.com/mitchellh/packer/packer_0.7.5_linux_amd64.zip
unzip packer_0.7.5_linux_amd64.zip
cd ..

# Install packer-windows
cd packer
wget https://github.com/packer-community/packer-windows-plugins/releases/download/pre-release/linux_amd64.zip
unzip linux_amd64.zip
cd ..

# Build the AMI for our server
./packer/packer build \
  -var timestamp=${timestamp} \
  -var aws_access_key=${aws_access_key} \
  -var aws_secret_key=${aws_secret_key} \
  ./packer.json
