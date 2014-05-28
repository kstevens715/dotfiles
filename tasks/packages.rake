require 'yaml'

namespace :packages do

  desc 'Install all Ubuntu packages'
  task :install do
    config = YAML.load_file(PACKAGE_PATH)
    config['packages'].each do |package|
      puts package
    end
  end

end
