require 'spec_helper'

describe 'catalogue', :type => :class do
  include_context 'hieradata'

  describe 'actual test' do
    it { pp @catalogue }
    it { should include_class('foo') }
  end


end
