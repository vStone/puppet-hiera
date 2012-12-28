require 'diff_matcher'

# Uses the diff_matcher gem to provide advanced matching abilities, along with nice visual representation of the
# diff between actual and expected. The functionality set is very helpful for comparing hashes.
#
# Usage examples:
#  it { should be_matching(my_var) }
#  it { should be_matching(my_var).with_options(ignore_additional: true) }
#
# Options: by default, color_enabled is controlled by Rspec, and quiet is set to true.
RSpec::Matchers.define :be_matching do |expected|
  match do |actual|
    options = { :color_enabled => RSpec::configuration.color_enabled?, :quiet => true }.merge(@options || {})
    @difference = DiffMatcher::Difference.new(expected, actual, options)
    @difference.matching?
  end

  chain :with_options do |options|
    @options = options
  end

  failure_message_for_should do |actual|
    "diff is:\n" + @difference.to_s
  end

  failure_message_for_should_not do |actual|
    "diff is:\n" + @difference.to_s
  end

  description do
    "match via DiffMatcher #{expected}" + (@options.blank? ? '' : " with options: #{@options}")
  end
end

