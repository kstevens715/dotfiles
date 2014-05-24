#!/usr/bin/env bash
#
# This is a bootstrap script that sets up my Ubuntu system.
#

echo 'Bootstrapping system'
# Install updates
sudo apt-get update && sudo apt-get -y upgrade

# Add repos
sudo apt-add-repository ppa:system76-dev/stable -y
sudo apt-add-repository ppa:webupd8team/java -y
sudo apt-add-repository ppa:nviennot/tmate -y
sudo apt-add-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner" -y

# Update package list
sudo apt-get update

export DEBIAN_FRONTEND=noninteractive

sudo apt-get -q -y install  aptitude \
                            bundler \
                            curl \
                            freetds-dev \
                            git \
                            kmymoney \
                            libpq-dev \
                            libxslt-dev \
                            oracle-java8-installer \
                            phantomjs \
                            postgresql \
                            python-software-properties \
                            rabbitmq-server \
                            rake \
                            redis-server \
                            skype \
                            tmate \
                            tmux \
                            unixodbc-dev \
                            xchat

#TODO: Install RVM and correct Ruby version

git clone git@github.com:kstevens715/dot-files.git ~/dot-files
cd ~/dot-files
rake vim:install


