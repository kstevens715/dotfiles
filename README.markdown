Here are basic instructions to setup on a new machine.  May have to compile
command-t as well.

```
cd ~
git clone http://github.com/kstevens715/dot-vim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
cd ~/.vim
git submodule init
git submodule update
```
