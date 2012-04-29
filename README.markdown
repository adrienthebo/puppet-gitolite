puppet-gitolite
===============

Install and manage gitolite

Defines

  package { 'git': ensure => present } ->
  class { '::gitolite': }
  include gitolite::gitweb

  gitolite::adc { 'adc.common-functions': mode => '0600'}
  gitolite::adc { 'help': }
  gitolite::adc { 'hub': }
  gitolite::adc { 'fork': }
  gitolite::adc { 'unlock': }
  gitolite::adc { 'lock': }
  gitolite::adc { 'trash': }
