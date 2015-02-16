# Systemsetup Module for Boxen

Using `systemsetup` you can define certain System Preferences from the command line. Take a look at https://github.com/kevinSuttle/OSXDefaults/blob/master/REFERENCE.md#systemsetup for an overview of available settings.

[![Build Status](https://travis-ci.org/rolfvandekrol/puppet-systemsetup.svg?branch=master)](https://travis-ci.org/rolfvandekrol/puppet-systemsetup)

## Usage

```puppet
class { 'systemsetup::computer_name':
  computer_name => 'mycomputername'
}
```

## Required Puppet Modules

* `boxen`

## Development

Write code.

Run `script/cibuild`.
