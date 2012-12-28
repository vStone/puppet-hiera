require 'rake'
require 'rspec/core/rake_task'

desc "Run all RSpec code examples"
# Uses spec_prep (creates fixtures)
RSpec::Core::RakeTask.new(:rspec) do |t|
    t.rspec_opts = File.read("spec/spec.opts").chomp || ""
end
# provide split out tasks for functions/classes/...
SPEC_SUITES = (Dir.entries('spec') - ['.', '..','fixtures']).select {|e| File.directory? "spec/#{e}" }
namespace :rspec do
  SPEC_SUITES.each do |suite|
    desc "Run #{suite} RSpec code examples"
    RSpec::Core::RakeTask.new(suite) do |t|
      t.pattern= "spec/#{suite}/**/*_spec.rb"
      t.rspec_opts = File.read("spec/spec.opts").chomp || ""
    end
  end
end

# Default task
task :default => :rspec
