require 'spec_helper'


describe 'hiera' do

  describe 'with default parameters' do
    it do
      should include_class('hiera::packages')
      should include_class('hiera::config')
      should contain_package('rubygem-hiera')
      should contain_package('rubygem-hiera-puppet')
      should contain_file('/etc/puppet/hieradata').with_ensure('directory')
      should contain_file('/etc/puppet/hiera.yaml')
    end
  end

end
