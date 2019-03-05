# In home directory:
```
$ cd dot-files
$ chmod +x ./install
$ ./install

# Only if you're me.
$ ln -s dot-files/gitconfig .gitconfig
```

In vim `:PluginInstall`

You might also want to add this line to `~/.ssh/config`. This will cause your SSH key to
be stored by ssh-agent the first time a key is accessed.

## VS Code
Settings stored here: https://gist.github.com/kstevens715/d976fb41cbcf2320256f879157496143

## Prerequisites
```
# Requirements for omnisharp-vim:
brew install python3
pip3 install pynvim
```

# Other
I use this for my command prompt: https://github.com/banga/powerline-shell
