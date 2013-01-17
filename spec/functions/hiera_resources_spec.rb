require 'spec_helper'

describe 'hiera_resources() function' do
  include_context 'hieradata'

  let (:scope) { PuppetlabsSpec::PuppetInternals.scope }
  let (:node) { 'testhost.example.com' }

  it 'should exist' do
    Puppet::Parser::Functions.function('hiera_resources').should == 'function_hiera_resources'
  end


  it "should throw an error with no arguments" do
    lambda {
      scope.function_hiera_resources([])
    }.should(raise_error(Puppet::Error))
  end
  it 'should not throw an error with 1 argument' do
    lambda {
      scope.function_hiera_resources(['foo'])
    }.should_not(raise_error(Puppet::Error))
  end
  it "should throw an error with 2 (or more) arguments" do
    lambda {
      scope.function_hiera_resources(['foo','bar'])
    }.should(raise_error(Puppet::Error))
  end

end
