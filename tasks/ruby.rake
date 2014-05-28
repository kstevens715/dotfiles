namespace :ruby do
  task :install_rvm do
    system '\curl -sSL https://get.rvm.io | bash -s stable'
    system 'type rvm | head -n1'
  end
end
