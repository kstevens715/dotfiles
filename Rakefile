BASHRC_PATH = File.join(Dir.home, '.bashrc')
DEFAULT_RUBY_VERSION = "2.1.1"
ROOT_PATH = File.dirname(__FILE__)
PACKAGE_PATH = File.join(ROOT_PATH, "packages.yml")
RVM_PATH = File.join(Dir.home, '.rvm')
RUBY_PATH = File.join(RVM_PATH, 'rubies', DEFAULT_RUBY_VERSION, 'bin', 'ruby')

require_relative 'lib/dot_files'

include DotFiles

Dir.glob('tasks/*.rake').each { |task| import task }

namespace :"dot-files" do

  #TODO: Run all the rake tasks, in the correct order.
  desc "Install everything"
  task :install => %w{
    packages:install
    ruby:install
    vim:install
  }

end
