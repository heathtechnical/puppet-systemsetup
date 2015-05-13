# systemsetup

#### Table of Contents

1. [Overview](#overview)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)

## Overview

This Puppet module provides basic system configuration of a Mac OS X system using
the 'systemsetup' utility.

## Usage

    class { 'systemsetup': 
      remote_login          => true,
      time_zone             => 'Europe/London',
      use_network_time      => true,
      network_time_server   => 'time.apple.com',
      computer_sleep_mins   => 30,
      display_sleep_mins    => 5,
      harddisk_sleep_mins   => 20
    }

Parameters are fairly self-explanatory and are documented in 'man systemsetup',
they are also all optional.

Computer/display/harddisk sleep minutes can be set to Never by setting the 
relevant parameters to 0.

Puppet > 3.0 users can also pass in parameters using hiera variables:

    systemsetup::remote_login: true    

## Limitations

This module only implements a subset of configuration items provided by the
'systemsetup' command.
