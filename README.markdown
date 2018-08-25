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

## Guard fix
Run this:
```
echo fs.inotify.max_user_watches=524288 | sudo tee /etc/sysctl.d/40-max-user-watches.conf && sudo sysctl --system
```

## Other packages to install
* bash-completion
* blueman - Bluetooth manager GUI
* brother-hl2040 (aur)
* docker-compose
* eog - Image viewer for XFCE
* extra/pangox-compat	- Needed to run the Cisco Anyconnect UI client
* ghostscript - Dependency of brother printer driver
* git-crypt - Needed by monster
* gnome-keyring libsecret - Use Gnome keyring
* hunspell hunspell-en - Spell checking in Firefox
* nodejs
* npm
* mupdf - PDF viewer
* unzip - Unzip zip files
* xarchiver-gtk2 - Archive GUI tool
* flashplugin, libvdpau-va-gl - Both needed for Flash player

# Other
I use this for my command prompt: https://github.com/banga/powerline-shell
