require 'yaml'

namespace :packages do

  desc 'Install all Ubuntu packages'
  task :install => [:install_repos] do
    install_packages(package_config['packages'])
  end

  desc 'Add PPA repos'
  task :install_repos do
    current_release = `lsb_release -sc`.strip

    package_config['repos'].each do |repo|
      repo.gsub!("{release}", current_release)
      system "sudo", "apt-add-repository", repo, "-y"
    end
    system "sudo", "apt-get", "update"
  end

end
