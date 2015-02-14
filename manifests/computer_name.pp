
class systemsetup::computer_name($computer_name = 'machine') {
  systemsetup::base{ 'systemsetup computer name':
    key    => 'computername',
    value  => $computer_name,
    type   => 'string'
  }
  systemsetup::base{ 'systemsetup local subnet name':
    key    => 'localsubnetname',
    value  => $computer_name,
    type   => 'string'
  }
}