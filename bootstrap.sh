#!/usr/bin/env bash
#
# This is a bootstrap script that sets up my Ubuntu system.
#

echo 'Bootstrapping system'
# Install updates
sudo apt-get update && sudo apt-get -y upgrade

# Add repos
sudo apt-add-repository ppa:system76-dev/stable
sudo apt-add-repository ppa:webupd8team/java
sudo apt-add-repository ppa:nviennot/tmate
sudo apt-add-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"

# Update package list
sudo apt-get update
#
# sudo apt-get install curl \
#          git \
