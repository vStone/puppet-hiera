require 'spec_helper'


describe 'hiera_array() function' do
  include_context 'hieradata'

  it 'should exist' do
    Puppet::Parser::Functions.function('hiera_array').should == 'function_hiera_array'
  end

  it "should throw an error with no arguments" do
    lambda {
      scope.function_hiera_array([])
    }.should(raise_error(Puppet::ParseError), 'Please supply a parameter to perform a Hiera lookup')
  end

  it 'should fail with a non-existing key' do
    lambda {
      scope.function_hiera_array(['does_not_exist'])
    }.should(raise_error(Puppet::ParseError,/^Could not find data item/))
  end

  it 'should fallback to a provided default with a non-existing key' do
    scope.function_hiera_array(['does_not_exist',['use_me_me_me']]).should == ['use_me_me_me']
  end

  it 'should return an array when a key is used once' do
    scope.function_hiera_array(['foo']).should == ['bar']
  end

  it 'should return an array when a key is used multiple times' do
    scope.function_hiera_array(['singlekey']).should == ['top','bottom']
  end

end
