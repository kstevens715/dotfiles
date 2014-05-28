require 'yaml'

namespace :packages do

  desc 'Install all Ubuntu packages'
  task :install => [:install_repos] do
    install_packages(package_config['packages'])
  end

  desc 'Add PPA repos'
  task :install_repos do
    package_config['repos'].each do |repo|
      system "sudo", "apt-add-repository", repo, "-y"
    end
  end

end
