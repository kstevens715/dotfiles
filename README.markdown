Here are basic instructions to setup on a new machine.

```
sudo apt-get install coffeescript
cd ~
git clone http://github.com/kstevens715/dot-vim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
cd ~/.vim
git submodule init
git submodule update
```

== Included Bundles ==
* **ack** - Search from Vim using Grep.
* **command-t** - Easily open files from current directory tree.
* **handlebars** - Syntax highlighting for handlebars templates.
* **molokai** - Syntax highlighting color scheme.
* **tcomment** - Comment out multiple lines.
* **vim-coffee-script** - Support for CoffeeScript.
* **vim-fugitive** - Vim helpers for Git.
* **vim-rails** - Vim helpers for Rails.

== Tips ==
* Usually I like to compile the latest Vim from source with support for my primary version of Ruby from RVM (see http://joncairns.com/2012/09/compiling-vim-with-ruby-from-rvm-on-ubuntu/).
* Make sure all bundles are listed in .gitmodules.
* Command-T may have to be compiled.
