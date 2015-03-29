# Perhasps put in the misc
# refer: https://github.com/boxen/puppet-osx
# TODO: 
#   - Binding 4 workspace, cmd + 1...5
#   - Binding Afred and spotlight
class people::ykt::osx::configure {
	
	include osx::global::disable_autocorrect
	include osx::global::tap_to_click
	include osx::dock::clear_dock

	class { 'osx::dock::magnification':
	  magnification => true,
	  magnification_size => 84
	}
	class { 'osx::sound::interface_sound_effects':
	  enable => false
	}

	include alfred
}