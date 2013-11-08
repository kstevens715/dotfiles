#!/usr/bin/env bash

sudo apt-get purge vim vim-gnome vim-gtk vim-tiny vim-scripts

sudo apt-get install coffeescript ack-grep exuberant-ctags python-dev python-pip mercurial git xclip

# Compile Vim from source
hg clone https://vim.googlecode.com/hg/ ~/vim
cd ~/vim
./configure --with-features=HUGE \
    --enable-pythoninterp=yes \
    --with-python-config-dir=/usr/lib/python2.7/config/ \
    --enable-multibyte=yes \
    --enable-cscope=yes \
    --enable-rubyinterp=yes \
    --with-ruby-command=/home/kyle/.rvm/rubies/ruby-2.0.0-p247/bin/ruby \
    --enable-fontset
make && sudo make install

# Install Powerline
sudo pip install git+git://github.com/Lokaltog/powerline
wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo fc-cache -vf
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

cd ~/.vim
git submodule init
git submodule update

cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make

ln -s ~/.vim/vimrc ~/.vimrc
