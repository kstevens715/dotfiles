namespace :vim do

  VIM_PATH = File.join(Dir.home, 'vim')

  desc "Install and setup a custom build of Vim"
  task install: [
    :remove_system_vim,
    :install_dependencies,
    :install_vim,
    :install_powerline,
    :create_symlinks
  ]

  task :remove_system_vim do
    packages = %w[vim vim-gnome vim-gtk vim-tiny vim-scripts]
    x = system "sudo", "apt-get", "purge", *packages
  end

  task :install_dependencies do
    packages = %w[
      ack-grep
      coffeescript
      exuberant-ctags
      git
      git-flow
      mercurial
      python-dev
      python-pip
      xclip
    ]
    install_packages(packages)
    system "sudo apt-get build-dep vim"
  end

  task :install_vim do
    return if Dir.exists? VIM_PATH
    system "hg clone https://vim.googlecode.com/hg #{VIM_PATH}"
    args = [
      "--with-features=HUGE",
      "--enable-pythoninterp=yes",
      "--with-python-config-dir=/usr/lib/python2.7/config/",
      "--enable-multibyte=yes",
      "--enable-cscope=yes",
      "--enable-rubyinterp=yes",
      "--with-ruby-command=#{RUBY_PATH}",
      "--enable-fontset"
    ]
    Dir.chdir(VIM_PATH)
    system "make clean"
    system "./configure", *args
    system "make"
    system "sudo make install"
  end

  task :install_powerline do
    system "sudo pip install git+git://github.com/Lokaltog/powerline"
    system "wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf"
    system "sudo mv PowerlineSymbols.otf /usr/share/fonts/"
    system "sudo fc-cache -vf"
    system "sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/"
  end

  task :create_symlinks do
    args = ["-s", File.join(ROOT_PATH, 'vim'), File.expand_path("~/.vim")]
    system "ln", *args
    #TODO: These last lines don't belong in this rake task.
    args = ["-s", File.join(ROOT_PATH, 'git', 'gitconfig'), File.expand_path("~/.gitconfig")]
    system "ln", *args
    args = ["-s", File.join(ROOT_PATH, 'pgpass'), File.expand_path("~/.pgpass")]
    system "ln", *args
    args = ["-s", File.join(ROOT_PATH, 'ackrc'), File.expand_path("~/.ackrc")]
    system "ln", *args
    args = ["-s", File.join(ROOT_PATH, 'tmux.conf'), File.expand_path("~/.tmux.conf")]
    system "ln", *args
  end
end
