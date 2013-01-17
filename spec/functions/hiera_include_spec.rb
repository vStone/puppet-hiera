require 'spec_helper'

describe 'hiera_include() function' do
  include_context 'hieradata'

  it 'should exist' do
    Puppet::Parser::Functions.function('hiera_include').should == 'function_hiera_include'
  end

  it "should throw an error with no arguments" do
    lambda {
      scope.function_hiera_include([])
    }.should(raise_error(Puppet::ParseError), 'Please supply a parameter to perform a Hiera lookup')
  end

  it 'should fail with a non-existing key' do
    lambda {
      scope.function_hiera_include(['does_not_exist'])
    }.should(raise_error(Puppet::ParseError,/^Could not find data item/))
  end

end
