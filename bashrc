#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set VI mode
set -o vi

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Show git status in the command prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
source ~/dot-files/git-prompt.sh
PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/kstevens/bin/google-cloud-sdk/path.bash.inc' ]; then source '/home/kstevens/bin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/kstevens/bin/google-cloud-sdk/completion.bash.inc' ]; then source '/home/kstevens/bin/google-cloud-sdk/completion.bash.inc'; fi
source <(kubectl completion bash)

# PATH additions
export PATH=$PATH:/home/kstevens/code/wa-devenv/deploy/deploy/
export PATH=$PATH:/home/kstevens/code/wa-devenv/deploy/
export PATH=$PATH:/home/kstevens/code/wa-devenv/kubernetes/
export PATH=$PATH:/home/kstevens/bin

# Aliases
alias dc='docker-compose'
alias railsc='docker-compose exec app bundle exec rails c'
alias railsdb='docker-compose exec app bundle exec rails db -p'
alias railss='docker-compose exec app bundle exec rails s'
alias resque='docker-compose exec app bundle exec rake resque:work VERBOSE=1 QUEUE=* --trace'
alias guard='docker-compose exec app guard'
alias killguard="dc exec app bash -c \"pkill -U app -f 'ruby /home/app/bundle/bin/guard'\""
alias zeus='docker-compose exec app zeus start'
