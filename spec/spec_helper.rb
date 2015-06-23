$:.unshift File.dirname(__FILE__) + '/../lib'

require 'nonono'
require 'helpers'

# Some thoughts
#
# Each git command should have it's own dedicated
# file for placing tests. All setup data should be
# namespaced by the command name, and should take
# responsibility for setting up and tearing down it's
# test environment. Theoretically, this will allow
# each context suite to run in parallel thereby making
# these tests - which will, by definition, operate directly
# with the disk - much quicker.

RSpec.configure do |config|
  config.include Helpers
end
