# In home directory:
```
$ cd dot-files
$ chmod +x ./install
$ ./install

# Only if you're me.
$ ln -s dot-files/gitconfig .gitconfig
$ ln -s dot-files/bashrc .bashrc
```

In vim `:PluginInstall`

You might also want to add this line to `~/.ssh/config`. This will cause your SSH key to
be stored by ssh-agent the first time a key is accessed.

## Prerequisites
```
# Install the_silver_searcher (ag) for searching:
sudo pacman -S ag

# Install and run ctags alternative
gem install ripper-tags
ripper-tags -R
```

# Other
I use this for my command prompt: https://github.com/banga/powerline-shell
