source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
source ~/dotfiles/secrets.sh

# Variables
export EDITOR=nvim
export NO_COVERAGE=true
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PATH="/usr/local/bin:$PATH:$HOME/bin:/usr/local/opt/python@3.10/libexec/bin:/Applications/Postgres.app/Contents/Versions/latest/bin"
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
alias pair="tmux -2 new -s pairing"
alias pair_with_ben="upterm host --github-user BenKanouse --force-command 'tmux attach -t pair-programming' -- tmux new -t pair-programming"

alias minio="nohup minio server --address :4572 ~/minio &> /dev/null 2>&1 &"
alias rebasedevelop="git co develop && git fetch && git rebase && git co - && git rebase develop"

setopt nosharehistory # Do not share history between ZSH instances

# Make Tmux resize correctly when pairing
if [ -n "$TMUX" ]; then
  tmux set window-size smallest
fi
