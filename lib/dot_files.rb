require 'yaml'

module DotFiles

  def install_packages(packages)
    system "sudo", "apt-get", "-q", "-y", "install", *packages
  end

  def package_config
    @config ||= YAML.load_file(PACKAGE_PATH)
  end

end
