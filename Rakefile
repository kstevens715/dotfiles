BASHRC_PATH = File.join(Dir.home, '.bashrc')
DEFAULT_RUBY_VERSION = "2.1.1"
ROOT_PATH = File.dirname(__FILE__)
PACKAGE_PATH = File.join(ROOT_PATH, "packages.yml")
RVM_PATH = File.join(Dir.home, '.rvm')
RUBY_PATH = File.join(RVM_PATH, 'rubies', DEFAULT_RUBY_VERSION, 'bin', 'ruby')

Dir.glob('tasks/*.rake').each { |task| import task }
