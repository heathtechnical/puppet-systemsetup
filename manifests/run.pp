# == Define: systemsetup::run
#
# Define to run set a limited set of OS X System Preferences
#
# == Parameters
#
# [*key*]
#   The systemsetup parameter (without the get/set prefix).
#
# [*value*]
#   Value to set.
#
# [*when_match*]
#   The value will only be set if the output of the get command contains this
#   pattern.
#
# [*value*]
#   The value will only be set if the output of the get command does not 
#   contain the when_match pattern.
#
# [*pre_pipe*]
#   Some set operations require basic yes/no input, you can provide a command
#   to pipe into the set command (usually something like /usr/bin/yes yes).
#
define systemsetup::run(
  $key,
  $value,
  $when_match,
  $invert_when_match = false,
  $pre_pipe = ''
) {

  if $::osfamily != 'Darwin' {
    fail('systemsetup is only supported on Mac OS X')
  }

  if $pre_pipe {
    $_pre_pipe = "${pre_pipe} | "
  }else{
    $_pre_pipe = $pre_pipe
  }

  if $invert_when_match {
    $_invert_when_match = '-v '
  }else{
    $_invert_when_match = ''
  }

  $exec_cmd = "${_pre_pipe}/usr/sbin/systemsetup -set${key} ${value}"

  exec { $exec_cmd:
    onlyif =>
      "/usr/sbin/systemsetup -get${key} | grep ${_invert_when_match}'${when_match}'"
  }
}
