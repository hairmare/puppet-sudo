class sudo::params {
  case $::operatingsystem {
    ubuntu, debian: {
      $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = 'puppet:///modules/sudo/sudoers.deb'
    }
	redhat, centos: {
	  $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d/'
      $source = 'puppet:///modules/sudo/sudoers.rhel'
	}
    gentoo: {
      $package = 'sudo'
      $config_file = '/etc/sudoers'
      $config_dir = '/etc/sudoers.d'
      $source = 'puppet:///modules/sudo/sudoers.portage'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}
