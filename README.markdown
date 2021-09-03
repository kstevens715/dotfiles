# dot-files
## New
Just turn on Prefs > Advanced > Work around Big Sur bug where a white line flashes at the top of the screen in full screen mode.
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Oh My ZSH
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install neovim
mkdir .config/nvim/
ln -s ~/dot-files/init.vim .config/nvim/
ln -s ~/dot-files/custom.zsh .oh-my-zsh/custom/
# Install Vim Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

In neovim:
:PlugInstall

## Old
```
brew install bat

pip install neovim && \
  pip3 install neovim
```

## Setting up coc

```
python3 -m pip install --user --upgrade pynvim
ln -s ~/dot-files/coc-settings.json .config/nvim/
gem install solargraph
solargraph bundle
```

## Fonts
1. Double click "Hack Regular Nerd Font Complete.ttf" to install
2. Set that font in iTerm

[Initial Commit](https://github.com/kstevens715/dot-files/commit/9951c25ac2423d27efb4c355e9b6861ed4511f93)
