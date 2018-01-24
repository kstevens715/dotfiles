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

# System Setup Stuff
## Wireless
I use netctl and wifi-menu to manage my wireless connection. In order to automatically start a wireless connection on boot,
first you need to find the profile name with `netctl list`. Next, enable it which will create and enable a systemd service:

```
sudo netctl enable wlp2s0-Redcat-5G
```

## Disable system beep

```
sudo su
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
```

## Other packages to install
* mupdf - PDF viewer
* ristretto - Image viewer for XFCE

# Other
I use this for my command prompt: https://github.com/banga/powerline-shell
