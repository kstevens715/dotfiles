#!/usr/bin/env bash
#
# This is a bootstrap script that sets up my Ubuntu system.
#

echo 'Bootstrapping system'

sudo apt-get update && sudo apt-get -y upgrade

export DEBIAN_FRONTEND=noninteractive

sudo apt-get -q -y install  curl \
                            git \
                            rake

git clone git@github.com:kstevens715/dot-files.git ~/dot-files
cd ~/dot-files
rake -T
