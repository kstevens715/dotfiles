# My Vim Config
Here are basic instructions for setting up and using my personal Vim config. I use it mostly for Rails development on Ubuntu 12.04 LTS.

## Included Bundles
* **ack** - Search from Vim using Grep.
* **command-t** - Easily open files from current directory tree.
* **handlebars** - Syntax highlighting for handlebars templates.
* **molokai** - Syntax highlighting color scheme.
* **tcomment** - Comment out multiple lines.
* **vim-coffee-script** - Support for CoffeeScript.
* **vim-fugitive** - Vim helpers for Git.
* **vim-rails** - Vim helpers for Rails.

## Tips
* Usually I like to compile the latest Vim from source with support for my primary version of Ruby from RVM (see http://joncairns.com/2012/09/compiling-vim-with-ruby-from-rvm-on-ubuntu/).

## Custom Key Bindings
* jj - In insert mode, quickly switch to normal mode.
* TODO: describe other bindings.

## Setup Instructions

### Install prerequisites.
```
sudo apt-get install coffeescript
```

### Install .vim config.
```
cd ~
git clone git@github.com:kstevens715/dot-vim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
cd ~/.vim
```

### Clone and update git submodules
```
git submodule init
git submodule update
```

### Compile command-t extension.
```
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make

```

### Enable GVim fullscreen mode.
```
sudo apt-get install compizconfig-settings-manager compiz-plugins-extra
```
Once this is installed, open compiz settings manager, and under Window Management enable Extra WM Actions. Then, under system keyboard preferences,
set F11 as a shortcut to fullscreen an app. Reboot computer and F11 should toggle fullscreen mode.

