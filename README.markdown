puppet-gitolite
===============

Install and manage gitolite with puppet.

Overview
--------

For more detail on any of the classes or defines, view the puppet doc in the
relevant file.

### Classes you might care about

#### Class: gitolite

Installs gitolite with all default values.

#### Class: gitolite::gitweb

Configure a gitweb instance built on top of this gitolite instance.

#### Define: gitolite::adc

Install gitolite ADCs. Requires gitolite 2 or greater.

- - -

### Classes you probably don't care about

#### Class: gitolite::data

Provides the default datasource for hiera lookup values

#### Class: gitolite::install

Installs gitolite from source, backports, or git.

#### Class: gitolite::instance

Creates a gitolite instance and the necessary prerequisite files.

Example
-------

All listed ACDs are vendored and ready for installation. As always, pleaase
read the documentation first.

    package { 'git': ensure => present } -> # Install git
    class { '::gitolite': }                 # Install gitolite with all default values
    include gitolite::gitweb                # Include gitweb access with gitolite based authorization.
    #
    # Install a motley of ADCs
    #
    # Install shared functions without execute access - library only
    #
    gitolite::adc { 'adc.common-functions': mode => '0600'}
    #
    # Github style commands
    #
    gitolite::adc { 'fork': } # github style forking
    gitolite::adc { 'hub': }  # Add in github style pull requests
    #
    # Repo management and deletion
    #
    gitolite::adc { 'list-trashed': } # List trashed repos
    gitolite::adc { 'lock': }         # Lock a repo
    gitolite::adc { 'trash': }        # Move a repository to the trash
    gitolite::adc { 'unlock': }       # Unlock a repo
    gitolite::adc { 'restore': }      # Move a repo from the trash
    #
    # Miscellaneous
    #
    gitolite::adc { 'help': }     # help page for ADCs
    gitolite::adc { 'htpasswd': } # Allow people to add an htpasswd entry. Needed for gitweb::gitolite
    gitolite::adc { 'sskm': }     # Self-serve public key management
    # And many other ADCs...

Requirements
------------

  * hiera
  * puppetlabs-stdlib
  * if the backports install is chosen, puppet-apt
