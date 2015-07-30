class people::ykt::misc::init {

  include git
  include git-flow

  file { ['/usr', '/usr/local', '/usr/local/bin']:
    ensure => 'directory'
  }

  # file { hiera(init::directories):
  #     ensure => "directory",
  #     mode   => 750,
  # }

  git::config::global { 'user.email':
    value  => 'yasir.khalid@gmail.com'
  }

  git::config::global { 'user.name':
    value  => 'Yasir Khalid'
  }
}