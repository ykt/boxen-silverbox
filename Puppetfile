# This file manages Puppet module dependencies.
#
# It works a lot like Bundler. We provide some core modules by
# default. This ensures at least the ability to construct a basic
# environment.

# Shortcut for a module from GitHub's boxen organization
def github(name, *args)
  options ||= if args.last.is_a? Hash
    args.last
  else
    {}
  end

  if path = options.delete(:path)
    mod name, :path => path
  else
    version = args.first
    options[:repo] ||= "boxen/puppet-#{name}"
    mod name, version, :github_tarball => options[:repo]
  end
end

# Shortcut for a module under development
def dev(name, *args)
  mod "puppet-#{name}", :path => "#{ENV['HOME']}/src/boxen/puppet-#{name}"
end

# Includes many of our custom types and providers, as well as global
# config. Required.

github "boxen", "3.10.2"

# Support for default hiera data in modules

github "module_data", "0.0.3", :repo => "ripienaar/puppet-module-data"

# Core modules for a basic development environment. You can replace
# some/most of these if you want, but it's not recommended.

github "sudo",        "1.0.0"
github "stdlib",      "4.2.1", :repo => "puppetlabs/puppetlabs-stdlib"

github "gcc",         "2.2.0"
#github "go",          "2.1.0"
github "nodejs",      "4.0.0"
github "ruby",        "8.1.7"

github "brewcask",    "0.0.6"
github "homebrew",    "1.11.2"
github "pkgconfig",   "1.0.0"

github "dnsmasq",     "2.0.1"
github "nginx",       "1.4.4"

#github "phantomjs",   "2.3.0"
github "foreman",     "1.2.0"

github "git",         "2.7.5"
github "hub",         "1.4.0"

github "inifile",     "1.1.1", :repo => "puppetlabs/puppetlabs-inifile"

github "openssl",     "1.0.0"
github "repository",  "2.3.0"
#github "xquartz",     "1.2.1"

# Optional/custom modules. There are tons available at
# https://github.com/boxen.

github "osx"

github "java", "1.7.1"

github "sublime_text_2", "1.1.2"
github "intellij", "1.5.1"

github "keepassx", :path => "/Users/yasir/Development/repo/git/github/ykt/puppet-keepassx"
github "dropbox"

github "iterm2", "1.2.4"

github "chrome"
github "hipchat"
github "skype"

github "virtualbox"
github "vagrant"

github "alfred"
github "mou"

github "tcsh", "1.0.0", :repo => "ykt/puppet-tcsh"


