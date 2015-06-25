$:.unshift File.dirname(__FILE__) + '/../lib'

require 'nonono'
require 'helpers'
require 'fileutils'

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

  config.after :all do
    Dir[test_repos_path + '/*_repo'].each { |f| FileUtils.rm_rf f }
  end

  private

  def test_repos_path
    File.expand_path('fixtures', File.dirname(__FILE__))
  end

  def mock_history(cmd)
    history_file = File.expand_path('fixtures/mock_history', File.dirname(__FILE__))
    File.open(history_file, 'a') { |f| f << ": 1435210072:0;#{cmd}\n" }
  end
end
