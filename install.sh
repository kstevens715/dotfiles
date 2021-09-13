#!/usr/bin/env zsh

cp ./"Hack Regular Nerd Font Complete.ttf" ~/Library/Fonts/

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install bat firefox mas neovim obsidian postgresql redis slack tmux tmate
mas install 961632517 # Be Focused Pomodoro Timer

cd ~

mkdir .config/nvim/
ln -s ~/dotfiles/init.vim          .config/nvim/
ln -s ~/dotfiles/coc-settings.json .config/nvim/
ln -s ~/dotfiles/custom.zsh        .oh-my-zsh/custom/
ln -s ~/dotfiles/gitconfig         .gitconfig
ln -s ~/dotfiles/tmux.conf         .tmux.conf

# Install RVM
gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby

echo "Done."
