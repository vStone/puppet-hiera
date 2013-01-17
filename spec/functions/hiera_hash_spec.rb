require 'spec_helper'


describe 'hiera_hash() function' do
  include_context 'hieradata'

  it 'should exist' do
    Puppet::Parser::Functions.function('hiera_hash').should == 'function_hiera_hash'
  end

  it "should throw an error with no arguments" do
    lambda {
      scope.function_hiera_hash([])
    }.should(raise_error(Puppet::ParseError), 'Please supply a parameter to perform a Hiera lookup')
  end

  it 'should fail with a non-existing key' do
    lambda {
      scope.function_hiera_hash(['does_not_exist'])
    }.should(raise_error(Puppet::ParseError,/^Could not find data item/))
  end

  it 'should fallback to a provided default with a non-existing key' do
    scope.function_hiera_hash(['does_not_exist',['use_me_me_me']]).should == ['use_me_me_me']
  end

  it 'should return a hash with a key' do
    scope.function_hiera_hash(['hashkey']).should be_matching({
      'one' => 'foobar',
      'two' => 'foobar',
      'three' => 'foobar',
      'four' => 'foobar',
    })
  end

end
