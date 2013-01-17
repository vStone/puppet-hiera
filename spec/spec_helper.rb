require 'rubygems'
require 'mocha'

require 'rspec-puppet'
require 'puppetlabs_spec_helper/module_spec_helper'

# Allows setting the config to use manually before using any hiera functions.
require 'hiera_puppet'
require 'hiera_puppet_helper'

# Use diff_matcher for comparing hashes
require 'diff_matcher_helper'

# Fixture path.
fixture_path = File.expand_path(File.join(__FILE__, '..', 'fixtures'))

RSpec.configure do |c|
  c.module_path = File.join(fixture_path, 'modules')
  c.manifest_dir = File.join(fixture_path, 'manifests')
  c.mock_with :mocha
end

# Configure hiera and setup the puppet scope.
shared_context 'hieradata' do
  before :each do
    HieraPuppet.extend(HieraHelper)
    HieraPuppet.use_config({
      :backends => ['yaml'],
      :hierarchy => ['top','resources','common','bottom'],
      :yaml => { :datadir => File.join(fixture_path, 'hieradata') }
    })
  end
  let(:scope) {
    PuppetlabsSpec::PuppetInternals.scope
  }
end
