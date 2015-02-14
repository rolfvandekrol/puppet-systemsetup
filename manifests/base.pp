# Public: Set a system config option with the OS X defaults system

define systemsetup::base(
  $key,
  $value,
  $type,
) {
  $systemsetup_cmd  = '/usr/sbin/systemsetup'

  case $type {
    'onoff': {
      $checkvalue = $value ? {
        /(true|yes)/ => 'On',
        /(false|no)/ => 'Off',
      }
    }
    'string': {
      $checkvalue = $value
    }
    'idle': {
      $checkvalue = $value ? {
        /([Nn]ever|[Oo]ff|false|no)/ => 'Never',
        default => "after ${value} minutes"
      }
    }
    default: {
      fail('Value of type parameter is not supported')
    }
  }

  $write_cmd = shellquote($systemsetup_cmd, "-set${key}", strip("${checkvalue} "))
  $read_cmd  = shellquote($systemsetup_cmd, "-get${key}")


  exec { "systemsetup write ${key}=>${value}":
    command => $write_cmd,
    unless  => "${read_cmd} | sed -e \"s/^[^:]*: //\" | awk '{ exit (\$0 != \"${checkvalue}\") }'",
    user    => 'root'
  }


  # if (($type == undef) and (($value == true) or ($value == false))) or ($type =~ /^bool/) {
  #   $type_ = 'bool'

  #   $checkvalue = $value ? {
  #     /(true|yes)/ => '1',
  #     /(false|no)/ => '0',
  #   }

  # } else {
  #   $type_      = $type
  #   $checkvalue = $value
  # }

  # $write_cmd = $type_ ? {
  #   undef   => shellquote($default_cmds, 'write', $domain, $key, strip("${value} ")),
  #   default => shellquote($default_cmds, 'write', $domain, $key, "-${type_}", strip("${value} "))
  # }

  # $read_cmd = shellquote($default_cmds, 'read', $domain, $key)

  # $readtype_cmd = shellquote($default_cmds, 'read-type', $domain, $key)
  # $checktype = $type_ ? {
  #   /^bool$/ => 'boolean',
  #   /^int$/  => 'integer',
  #   /^dict$/ => 'dictionary',
  #   default  => $type_
  # }
  # $checktype_cmd = $type_ ? {
  #   undef   => '',
  #   default => " && (${readtype_cmd} | awk '/^Type is / { exit \$3 != \"${checktype}\" } { exit 1 }')"
  # }

  # $refreshonly_ = $refreshonly ? {
  #   undef   => false,
  #   default => true,
  # }

  # exec { "osx_defaults write ${host} ${domain}:${key}=>${value}":
  #   command     => $write_cmd,
  #   unless      => "${read_cmd} && (${read_cmd} | awk '{ exit \$0 != \"${checkvalue}\" }')${checktype_cmd}",
  #   user        => $user,
  #   refreshonly => $refreshonly_
  # }
  # }
}
