# = Class: gitolite
#
# Install gitolite with default values.
#
# == Example
#
# include gitolite
#
# == Author
#
# Adrien Thebo <adrien@puppetlabs.com>
#
# == Copyright
#
# Copyright 2012 Puppet Labs, unless otherwise noted
#
class gitolite {
  include gitolite::install
  include gitolite::instance
  include gitolite::rc

  anchor { 'gitolite::begin': } ->
  Class['gitolite::instance'] ->
  Class['gitolite::rc'] ->
  anchor { 'gitolite::end': }

}
