#!/usr/bin/env zsh

# Install Node for coc.nvim
curl -sL install-node.now.sh/lts | bash

brew tap heroku/brew

brew install bat fd git-flow gpg heroku imagemagick mas rabbitmq redis rg slack yarn

brew services start postgresql
brew services start rabbitmq
brew services start redis

mas install 961632517 # Be Focused Pomodoro Timer

ln -s ~/dotfiles/coc-settings.json .config/nvim/

