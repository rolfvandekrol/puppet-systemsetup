require 'spec_helper'
# Rename this file to classname_spec.rb
# Check other boxen modules for examples
# or read http://rspec-puppet.com/tutorial/
describe 'systemsetup::base' do
  let(:title)  { 'example' }
  let(:key)    { 'testkey' }
  let(:value)  { 'testvalue' }
  let(:type)   { 'string' }

  let(:params) {
    { :key    => key,
      :value  => value,
      :type   => type,
    }
  }

  it do
    should contain_exec("systemsetup write #{key}=>#{value}").
      with(:command => "/usr/sbin/systemsetup -set#{key} #{value}")
  end
end
