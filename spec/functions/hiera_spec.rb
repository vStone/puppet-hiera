require 'spec_helper'


describe 'hiera() function' do
  include_context 'hieradata'

  it 'should exist' do
    Puppet::Parser::Functions.function('hiera').should == 'function_hiera'
  end

  it "should throw an error with no arguments" do
    lambda {
      scope.function_hiera([])
    }.should(raise_error(Puppet::ParseError), 'Please supply a parameter to perform a Hiera lookup')
  end

  it 'should fail with a non-existing key' do
    lambda {
      scope.function_hiera(['does_not_exist'])
    }.should(raise_error(Puppet::ParseError,/^Could not find data item/))
  end

  it 'should fallback to default with a non-existing key' do
    scope.function_hiera(['does_not_exist','use_me_me_me']).should == 'use_me_me_me'
  end

  it 'should return a value with an existing key' do
    scope.function_hiera(['foo']).should == 'bar'
  end

end
