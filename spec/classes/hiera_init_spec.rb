require 'spec_helper'

describe 'hiera', :type => :class  do

  describe 'with default parameters' do
    it { should include_class('hiera::packages') }
    it { should include_class('hiera::config') }
    it { should contain_package('rubygem-hiera') }
    it { should contain_package('rubygem-hiera-puppet') }
    it { should contain_file('/etc/puppet/hieradata').with_ensure('directory') }
    it { should contain_file('/etc/puppet/hiera.yaml') }
  end

end
