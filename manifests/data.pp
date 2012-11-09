class sudo::data {
  $source_base = "puppet:///modules/${module_name}/"

  case $::osfamily {
    debian: {
      $sudo_package = 'sudo'
      $sudo_config_file = '/etc/sudoers'
      $sudo_config_dir = '/etc/sudoers.d/'
      $sudo_source = "${source_base}sudoers.deb"
      $sudo_config_file_group = 'root'
    }
    redhat: {
      $sudo_package = 'sudo'
      $sudo_config_file = '/etc/sudoers'
      $sudo_config_dir = '/etc/sudoers.d/'
      $sudo_source = "${source_base}sudoers.rhel"
      $sudo_config_file_group = 'root'
    }
    suse: {
      $sudo_package = 'sudo'
      $sudo_config_file = '/etc/sudoers'
      $sudo_config_dir = '/etc/sudoers.d/'
      $sudo_source = "${source_base}sudoers.suse"
      $sudo_config_file_group = 'root'
    }
    solaris: {
      $sudo_package = 'SFWsudo'
      $sudo_config_file = '/opt/sfw/etc/sudoers'
      $sudo_config_dir = '/opt/sfw/etc/sudoers.d/'
      $sudo_source = "${source_base}sudoers.solaris"
      $sudo_config_file_group = 'root'
    }
    freebsd: {
      $sudo_package = 'security/sudo'
      $sudo_config_file = '/usr/local/etc/sudoers'
      $sudo_config_dir = '/usr/local/etc/sudoers.d'
      $sudo_source = "${source_base}sudoers.freebsd"
      $sudo_config_file_group = 'wheel'
    }
    default: {
      case $::operatingsystem {
        gentoo, archlinux: {
          $sudo_package = 'sudo'
          $sudo_config_file = '/etc/sudoers'
          $sudo_config_dir = '/etc/sudoers.d/'
          $sudo_source = "${source_base}sudoers.deb"
          $sudo_config_file_group = 'root'
        }
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}
