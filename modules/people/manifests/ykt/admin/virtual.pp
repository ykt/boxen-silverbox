class people::ykt::admin::virtual {
  # include virtualbox
  # include vagrant_manager
  # include packer
  class { 'vagrant': }

  exec { 'vagrant install plugin':
    command => 'vagrant plugin install vagrant-hosts vagrant-auto_network',
    onlyif => 'test  `vagrant plugin list | grep -cE "vagrant-hosts|vagrant-auto_network"` -lt 2',
    require => Class['vagrant']
  }
}
