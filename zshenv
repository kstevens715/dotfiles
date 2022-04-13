source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
source ~/dotfiles/secrets.sh

# Variables
export EDITOR=nvim
export NO_COVERAGE=true
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PATH="/usr/local/bin:$PATH:$HOME/bin"
export SHELL=zsh

# Aliases
alias be="bundle exec"
alias dc="docker-compose"
alias vim="nvim"
alias tc="cd ~/code/telchar"

alias minio="nohup minio server --address :4572 ~/minio &> /dev/null 2>&1 &"
alias rebasedevelop="git co develop && git fetch && git rebase && git co - && git rebase develop"
