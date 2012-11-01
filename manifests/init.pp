# Class: sudo
#
# This module manages sudo
#
# Parameters:
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*autoupgrade*]
#     Upgrade package automatically, if there is a newer version.
#     Default: false
#
#   [*package*]
#     Name of the package.
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
#   [*config_file*]
#     Main configuration file.
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
#   [*config_file_replace*]
#     Replace configuration file with that one delivered with this module
#     Default: true
#
#   [*config_dir*]
#     Main configuration directory
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
#   [*source*]
#     Alternate source file location
#     Only set this, if your platform is not supported or you know,
#     what you're doing.
#     Default: auto-set, platform specific
#
# Actions:
#   Installs and configures the sudo package for managing system security and access.
#
# Requires:
#   Nothing
#
# Sample Usage:
#   class { 'sudo':
#      ensure = 'present',
#      autoupgrade = false,
#      package = 'sudo'
#      config_file = /etc/sudoers
#      config_file_replace = true,
#      config_dir = '/etc/sudoers.d'
#      source = "puppet:///modules/${module_name}/sudoers.custom"
#   }
#
# [Remember: No empty lines between comments and class definition]
class sudo(
  $ensure = 'present',
  $autoupgrade = false,
  $package = hiera("sudo_package"),
  $config_file = hiera("sudo_config_file"),
  $config_file_replace = true,
  $config_dir = hiera("sudo_config_dir"),
  $source = hiera("sudo_source")
) {

  case $ensure {
    /(present)/: {
      $dir_ensure = 'directory'
      if $autoupgrade == true {
        $package_ensure = 'latest'
      } else {
        $package_ensure = 'present'
      }
    }
    /(absent)/: {
      $package_ensure = 'absent'
      $dir_ensure = 'absent'
    }
    default: {
      fail('ensure parameter must be present or absent')
    }
  }

  package { $package:
    ensure => $package_ensure,
  }

  file { $config_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => hiera("sudo_config_file_group"),
    mode    => '0440',
    replace => $config_file_replace,
    source  => $source,
    require => Package[$package],
  }

  file { $config_dir:
    ensure  => $dir_ensure,
    owner   => 'root',
    group   => hiera("sudo_config_file_group"),
    mode    => '0550',
    recurse => true,
    purge   => true,
    require => Package[$package],
  }
}
