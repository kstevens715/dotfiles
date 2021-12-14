#!/usr/bin/env zsh

cp ./"Hack Regular Nerd Font Complete.ttf" ~/Library/Fonts/

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Node for coc.nvim
curl -sL install-node.now.sh/lts | bash

brew tap heroku/brew

brew install bat chruby firefox git-flow gpg heroku imagemagick mas neovim rabbitmq redis rg ruby-install slack tmux tmate yarn

brew services start postgresql
brew services start rabbitmq
brew services start redis

mas install 961632517 # Be Focused Pomodoro Timer

cd ~

mkdir .config/nvim/
ln -s ~/dotfiles/init.vim          .config/nvim/
ln -s ~/dotfiles/coc-settings.json .config/nvim/
ln -s ~/dotfiles/custom.zsh        .oh-my-zsh/custom/
ln -s ~/dotfiles/gitconfig         .gitconfig
ln -s ~/dotfiles/tmux.conf         .tmux.conf

echo "Done."
