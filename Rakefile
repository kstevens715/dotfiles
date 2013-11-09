namespace :vim do

  VIM_PATH = File.expand_path("~/vim")

  desc "Install everything"
  task install: %i[
    remove_system_vim
    install_dependencies
    install_vim
    install_powerline
    init_submodules
    compile_command_t
    create_symlinks
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
      mercurial
      python-dev
      python-pip
      xclip
    ]
    system "sudo", "apt-get", "install", *packages
  end

  desc "Download and compile Vim from source"
  task :install_vim do

    unless Dir.exists? VIM_PATH
      system "hg clone https://vim.googlecode.com/hg", VIM_PATH
      args = [
        "--with-features=HUGE",
        "--enable-pythoninterp=yes",
        "--with-python-config-dir=/usr/lib/python2.7/config/",
        "--enable-multibyte=yes",
        "--enable-cscope=yes",
        "--enable-rubyinterp=yes",
        "--with-ruby-command=/home/kyle/.rvm/rubies/ruby-2.0.0-p247/bin/ruby",
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
    Dir.chdir(File.expand_path("~/dot-files"))
    system "git submodule init"
    system "git submodule update"
  end

  desc "Compile Command-T"
  task :compile_command_t do
    Dir.chdir(File.expand_path("~/dot-files/vim/bundle/command-t/ruby/command-t"))
    system "ruby extconf.rb"
    system "make"
  end

  desc "Create symlinks"
  task :create_symlinks do
    system "ln -s ~/dot-files/vim ~/.vim"
  end
end
