define gitolite::adc($ensure = present, $source = "puppet:///modules/gitolite/adc/${name}", $mode = '0700'){

  require gitolite

  validate_re('^present$|^absent$')
  $gl_adc_path = hiera('gitolite_rc_gl_adc_path', undef)
  $user        = hiera('gitolite_instance_user')
  $group       = hiera('gitolite_instance_group')

  if $gl_adc_path == undef {
    err("${module_name}::Adc[${name}] ensure is present but ADCs are disabled; this will do nothing!")
  }
  else {
    file { "${gl_adc_path}/${name}":
      ensure   => $ensure,
      owner    => $user,
      group    => $group,
      source   => $source,
      mode     => $mode,
    }
  }
}