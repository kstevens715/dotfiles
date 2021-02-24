# ln -s $FILE_PATH $HOME/.oh-my-zsh/lib/

# Variables
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export SHELL=zsh
export BAT_THEME="OneHalfDark"
export SPARK_HOME=/opt/spark
export PATH=$SPARK_HOME/bin:$PATH
export PYSPARK_DRIVER_PYTHON=jupyter
export PYSPARK_DRIVER_PYTHON_OPTS='notebook'

# Aliases
alias be="bundle exec"
alias cdc="cd ~/code/content_system"
alias dc="docker-compose"
alias vimcdc="cdc & vim"
alias vim="nvim"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="$PATH:$HOME/.rvm/bin"
