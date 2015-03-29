class people::ykt::misc::init {

  include git

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