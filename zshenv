source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
source ~/dotfiles/secrets.sh

# Variables
export EDITOR=nvim
export NO_COVERAGE=true
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PATH="/usr/local/bin:$PATH:$HOME/bin"
export SHELL=zsh
export NODE_OPTIONS="--no-warnings"

# Default schema compatibility for Avro registry
# https://github.com/salsify/avro-schema-registry/blob/f2da75508bea91611f0a1c99a3b46259e5197cc0/config/application.rb#L49
export DEFAULT_COMPATIBILITY="FORWARD"

# Aliases
alias be="bundle exec"
alias dc="docker-compose"
alias vim="nvim"
alias tc="cd ~/code/telchar"
alias po="cd ~/code/porter"

alias minio="nohup minio server --address :4572 ~/minio &> /dev/null 2>&1 &"
alias rebasedevelop="git co develop && git fetch && git rebase && git co - && git rebase develop"

setopt nosharehistory # Do not share history between ZSH instances
