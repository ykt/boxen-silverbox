class people::ykt::misc::editor {
  class { 'intellij':
    edition => 'ultimate',
    version => '14.1'
  }

  file { '/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl':
    target => '/usr/local/bin/sublime',
    ensure => 'link'
  }
}