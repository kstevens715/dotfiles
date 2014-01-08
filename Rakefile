namespace :vim do

  VIM_PATH = File.expand_path("~/vim")
  DOT_FILES_PATH = File.dirname __FILE__

  desc "Install everything"
  task install: [
    :remove_system_vim,
    :install_dependencies,
    :install_vim,
    :install_powerline,
    :init_submodules,
    :create_symlinks
  ]

  desc "Remove system Vim"
  task :remove_system_vim do
    packages = %w[vim vim-gnome vim-gtk vim-tiny vim-scripts]
    x = system "sudo", "apt-get", "purge", *packages
  end

  desc "Install all dependencies"
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
    system "sudo", "apt-get", "install", *packages
    system "sudo apt-get build-dep vim"
  end

  desc "Download and compile Vim from source"
  task :install_vim do

    unless Dir.exists? VIM_PATH
      system "hg clone https://vim.googlecode.com/hg #{VIM_PATH}"
      args = [
        "--with-features=HUGE",
        "--enable-pythoninterp=yes",
        "--with-python-config-dir=/usr/lib/python2.7/config/",
        "--enable-multibyte=yes",
        "--enable-cscope=yes",
        "--enable-rubyinterp=yes",
        "--with-ruby-command=/home/kyle/.rvm/rubies/ruby-1.9.3-p125/bin/ruby",
        "--enable-fontset"
      ]
      Dir.chdir(VIM_PATH)
      system "make clean"
      system "./configure", *args
      system "make"
      system "sudo make install"
    end

  end

  desc "Install Powerline for Vim"
  task :install_powerline do
    system "sudo pip install git+git://github.com/Lokaltog/powerline"
    system "wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf"
    system "sudo mv PowerlineSymbols.otf /usr/share/fonts/"
    system "sudo fc-cache -vf"
    system "sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/"
  end

  desc "Initialize submodules"
  task :init_submodules do
    Dir.chdir(DOT_FILES_PATH)
    system "git submodule init"
    system "git submodule update"
  end

  desc "Create symlinks"
  task :create_symlinks do
    args = ["-s", File.join(DOT_FILES_PATH, 'vim'), File.expand_path("~/.vim")]
    system "ln", *args
    args = ["-s", File.join(DOT_FILES_PATH, 'git', 'gitconfig'), File.expand_path("~/.gitconfig")]
    system "ln", *args
    args = ["-s", File.join(DOT_FILES_PATH, 'pgpass'), File.expand_path("~/.pgpass")]
    system "ln", *args
  end
end
