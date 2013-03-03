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

### Install Prerequisites
```
sudo apt-get install coffeescript
```

### Install .vim config
```
cd ~
git clone git@github.com:kstevens715/dot-vim.git ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
cd ~/.vim
```

### Clone and Update Git Submodules
```
git submodule init
git submodule update
```

### Compile Command-T Extension
```
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make

```

### Enable GVim Fullscreen Mode
Once this is installed, open compiz settings manager, and under Window Management enable Extra WM Actions. Then, click into the extra actions sub-menu and enable the Toggle Fullscreen option with F11 as the keyboard shortcut.
```
sudo apt-get install compizconfig-settings-manager compiz-plugins-extra
```

### Create Unity launcher
Run the below commands, create the launcher and then add it by searching the Unity Dash.
```
sudo apt-get install gnome-panel
sudo gnome-desktop-item-edit /usr/share/applications/ --create-new
```

### Enable open in existing tab
Copy these files to your local applications dir. Be careful not to overwrite existing files.
TODO: Symlink these to the expected location.
```
cp gvim-tab.desktop ~/.local/share/applications/
cp mimeapps.list ~/.local/share/applications/
```

