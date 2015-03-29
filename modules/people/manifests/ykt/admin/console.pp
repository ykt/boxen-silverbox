# Perhaps to rename this manifest
# 
class people::ykt::admin::console {
  include iterm2::dev
  include tcsh

  # FIXME cant make it work with this 'puppet:///modules/people/files/user/home/.tcshrc'
  file{ '/Users/yasir/.tcshrc':
    source => '/opt/boxen/repo/modules/people/manifests/files/user/home/.tcshrc',
    ensure => 'present',
    require => Class['tcsh']
  }
  file { '/usr/local/share/tcsh/complete.tcsh':
    source => '/opt/boxen/repo/modules/people/manifests/files/usr/local/share/tcsh/complete.tcsh',
    ensure => 'present',
    require => File['/Users/yasir/.tcshrc']
  }

}