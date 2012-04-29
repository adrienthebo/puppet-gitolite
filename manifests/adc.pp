# = Define: gitolite::adc
#
# Manage the installation and removal of gitolite admin defined commands
#
# == Parameters
#
# [*title*]
#
# The name of the ADC to install.
#
# [*ensure*]
#
# Whether to create or remove the ADC.
#
# Default: present
#
# [*source*]
#
# The source of the ADC file on the server.
#
# Defaults to puppet:///modules/gitolite/adc/${name}
#
# [*mode*]
#
# The file mode to apply to the file. If a file is not executable then
# gitolite will not list it as an available ADC.
#
# Default: 0700
#
# == Example
#
#     gitolite::adc { 'adc.common-functions': mode => '0600'}
#     gitolite::adc { 'help': }
#     gitolite::adc { 'hub': }
#     gitolite::adc { 'fork': }
#     gitolite::adc { 'unlock': }
#     gitolite::adc { 'lock': }
#     gitolite::adc { 'trash': }
#
# == Notes
#
# At the publishing of this module, all ADCs available at the time have been
# vendored, so it if comes in gitolite/contrib, you can add it without having
# to specify a source.
#
# == Author
#
# Adrien Thebo <adrien@puppetlabs.com>
#
# == Copyright
#
# Copyright 2012 Puppet Labs, unless otherwise noted
#
define gitolite::adc($ensure = present, $source = "puppet:///modules/gitolite/adc/${name}", $mode = '0700'){

  require gitolite::instance

  validate_re('^present$|^absent$', $ensure)
  $gl_adc_path = hiera('gitolite_rc_gl_adc_path', 'UNSET')

  # There appears to be a bug with the hiera puppet back end for reading
  # module data, so we use fully scoped variables for data.
  $user  = $gitolite::data::gitolite_instance_user
  $group = $gitolite::data::gitolite_instance_group

  # This would be the preferred approach
  #$user = hiera('gitolite_instance_user')
  #$group = hiera('gitolite_instance_group')

  if $adc_path == 'UNSET' {
    err("${module_name}::Adc[${name}] ensure is present but ADCs are disabled; this will do nothing!")
  }
  else {

    # Ensure ADC directory exists.
    if !defined(File[$gl_adc_path]) {
      file { $gl_adc_path:
        ensure => directory,
        owner  => $user,
        group  => $group,
        mode   => '0700',
        purge  => true,
      }
    }

    file { "${gl_adc_path}/${name}":
      ensure  => $ensure,
      owner   => $user,
      group   => $group,
      source  => $source,
      mode    => $mode,
      require => File[$gl_adc_path],
    }
  }
}
