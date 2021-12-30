source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Variables
export EDITOR=nvim
export NO_COVERAGE=true
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PATH="$PATH:$HOME/bin"
export SHELL=zsh

# Aliases
alias be="bundle exec"
alias dc="docker-compose"
alias vim="nvim"
alias tc="cd ~/code/telchar"

alias minio="minio server --address :4572 ~/minio"
