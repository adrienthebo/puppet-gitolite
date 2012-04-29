# Class: gitolite::gitweb
#
# Configure a gitweb instance built on top of this gitolite instance
#
# == Examples
#
#    include gitolite::gitweb
#
#    class { 'gitolite::gitweb':
#      site_alias => 'git.example.com',
#    }
#
# == Author
#
# Adrien Thebo <adrien@puppetlabs.com>
#
# == Copyright
#
# Copyright 2012 Puppet Labs, unless otherwise noted
#
class gitolite::gitweb($site_alias = hiera('gitolite_gitweb_site_alias')){

  require gitolite::rc

  $doc_root = '/var/www/git'

  class { '::gitweb':
    site_alias    => $site_alias,
    doc_root      => $doc_root,
    ssl           => false,
    project_root  => hiera('gitolite_rc_project_root'),
    projects_list => hiera('gitolite_rc_projects_list'),
  }

  # Provide an empty htpasswd file for the gitolite htpasswd ADC
  file { "/home/git/.htpasswd":
    ensure => file,
    owner  => 'git',
    group  => 'git',
    mode   => '0640',
  }
}
