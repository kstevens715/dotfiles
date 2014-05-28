namespace :ruby do

  task :install_rvm do
    next if Dir.exists? RVM_PATH

    puts "Installing RVM"
    rvm_exec_path = File.join(RVM_PATH, 'scripts', 'rvm')
    system '\curl -sSL https://get.rvm.io | bash -s stable'
    system %Q[echo '[[ -s "#{RVM_PATH}" ]] && source "#{RVM_PATH}"' >> #{BASHRC_PATH}]
    system "source #{BASHRC_PATH}"
    system "rvm install #{DEFAULT_RUBY_VERSION}"
    system "rvm use #{DEFAULT_RUBY_VERSION} --default"
  end

end
