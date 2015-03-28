class people::ykt {
  
  include people::ykt::dev::java
  include people::ykt::net::browser
  include people::ykt::admin::console

  # $home     = "/Users/${::boxen_user}"
  # $my       = "${home}/my"
  # $dotfiles = "${my}/dotfiles"
  
  # file { $my:
  #   ensure  => directory
  # }

  # repository { $dotfiles:
  #   source  => 'jbarnette/dotfiles',
  #   require => File[$my]
  # }
}