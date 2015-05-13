# == Class: systemsetup
#
# Set basic System Preferences settings
#
# === Parameters
#
# [*remote_login*]
#   Enable/disable remote login via SSH.
#
# [*time_zone*]
#   Set the system timezone.  See 'systemsetup -listtimezones' for available 
#   timezones.
#
# [*use_network_time*]
#   Enable/disable NTP.
#
# [*network_time_server*]
#   Set NTP server.
#
# [*computer_sleep_mins*]
#   Set system sleep minutes, 0 for Never.
#
# [*display_sleep_mins*]
#   Set display sleep minutes, 0 for Never.
#
# [*harddisk_sleep_mins*]
#   Set hard disk spin down minutes, 0 for Never.
#
# === Examples
#
#  class { 'systemsetup':
#    remote_login          => true,
#    time_zone             => 'Europe/London',
#    use_network_time      => true,
#    network_time_server   => 'time.apple.com',
#    computer_sleep_mins   => 30,
#    display_sleep_mins    => 5,
#    harddisk_sleep_mins   => 20
#  }
#
# === Authors
#
# Author Name <dan@heathtechnical.com>
#
# === Copyright
#
# Copyright 2015 Dan Heath, unless otherwise noted.
#


class systemsetup(
  $remote_login         = undef,
  $time_zone            = undef,
  $use_network_time     = undef,
  $network_time_server  = undef,
  $computer_sleep_mins  = undef,
  $display_sleep_mins   = undef,
  $hardddisk_sleep_mins = undef
){
  # Remote login
  if $remote_login {
    if $remote_login == true {
      systemsetup::run { 'remote_login':
        key        => 'remotelogin',
        value      => 'on',
        when_match => 'Off$'
      }
    }else{
      systemsetup::run { 'remote_login':
        key        => 'remotelogin',
        value      => 'off',
        when_match => 'On$',
        pre_pipe   => '/usr/bin/yes yes'
      }
    }
  }

  # Time zone
  if $time_zone {
    systemsetup::run { 'time_zone':
      key               => 'timezone',
      value             => $time_zone,
      when_match        => "${time_zone}$",
      invert_when_match => true
    }
  }

  # Using NTP
  if $use_network_time == true {
    systemsetup::run { 'use_network_time':
      key        => 'usingnetworktime',
      value      => 'On',
      when_match => 'Off$',
    }
  }

  # NTP Server
  if $network_time_server {
    systemsetup::run { 'network_time_server':
      key               => 'networktimeserver',
      value             => $network_time_server,
      when_match        => "${network_time_server}$",
      invert_when_match => true
    }
  }

  # Computer Sleep Minutes
  if $computer_sleep_mins != undef {
    if $computer_sleep_mins == 0 {
      $computer_sleep_mins_when_match = 'Never'
    }else{
      $computer_sleep_mins_when_match = "after ${computer_sleep_mins} minutes"
    }

    systemsetup::run { 'computer_sleep_mins':
      key               => 'computersleep',
      value             => $computer_sleep_mins,
      when_match        => $computer_sleep_mins_when_match,
      invert_when_match => true
    }
  }

  # Display Sleep Minutes
  if $display_sleep_mins != undef {
    if $display_sleep_mins == 0 {
      $display_sleep_mins_when_match = 'Never'
    }else{
      $display_sleep_mins_when_match = "after ${display_sleep_mins} minutes"
    }

    systemsetup::run { 'display_sleep_mins':
      key               => 'displaysleep',
      value             => $display_sleep_mins,
      when_match        => $display_sleep_mins_when_match,
      invert_when_match => true
    }
  }

  # Hard Disk Sleep Minutes
  if $harddisk_sleep_mins {
    if $harddisk_sleep_mins == 0 {
      $harddisk_sleep_mins_when_match = 'Never'
    }else{
      $harddisk_sleep_mins_when_match =
        "after ${harddisk_sleep_mins} minutes"
    }

    systemsetup::run { 'harddisk_sleep_mins':
      key               => 'harddisksleep',
      value             => $harddisk_sleep_mins,
      when_match        => $harddisk_sleep_mins_when_match,
      invert_when_match => true
    }
  }
}
