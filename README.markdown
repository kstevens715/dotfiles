# In home directory:
```
$ ln -s dot-files/vim/ .vim
$ ln -s dot-files/vim/vimrc .vimrc
$ ln -s dot-files/gitconfig .gitconfig # Only if you're me.
$ cd dot-files/vim/bundle
$ git clone git@github.com:VundleVim/Vundle.vim.git
```
In vim `:PluginInstall`

If you are on a MAC you will need to brew install ack, and change ack-grep to ack
