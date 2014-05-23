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

sudo apt-get install  aptitude \
                      bundler \
                      curl \
                      freetds-dev \
                      git \
                      kmymoney \
                      libpq-dev \
                      libxlst-dev \
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

#TODO: clone dot-files and get that to take over the process. Maybe only install minimal packages above and let the Rakefile
# take care of the test.
