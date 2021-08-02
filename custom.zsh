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
alias completeprod="rm -f ~/Desktop/_COMPLETE ; touch ~/Desktop/_COMPLETE"
alias completeqa="rm -f ~/Desktop/_COMPLETE ; echo 'qa' > ~/Desktop/_COMPLETE"

