namespace :ruby do

  task :install_rvm do
    rvm_path = File.join(Dir.home, '.rvm')
    unless Dir.exists? rvm_path
      puts "Installing RVM"
      rvm_exec_path = File.join(rvm_path, 'scripts', 'rvm')
      ruby_version = 'ruby-2.1.1'
      system '\curl -sSL https://get.rvm.io | bash -s stable'
      system %Q[echo '[[ -s "#{rvm_path}" ]] && source "#{rvm_path}"' >> ~/.bashrc]
      system "rvm install #{ruby_version}"
      system "rvm use #{ruby_version} --default"
    end
  end

end
