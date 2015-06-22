require 'fileutils'
require 'spec_helper'
# require 'pry'

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
RSpec.describe Nonono, 'nonono specs' do
  # before(:each) do
  #   FileUtils.mkdir_p('test_repo')
  #   FileUtils.cd('test_repo')
  #   `git init`
  # end

  # after(:each) do
  #   FileUtils.cd('../')
  #   FileUtils.remove_dir('test_repo')
  # end

  describe "test spec" do
    assert_equal true, true
  end

  # describe 'Git init' do
  #   it 'knows the reverse commands' do
  #     out = run 'nonono'
  #     binding.pry
  #     puts "------------"
  #     expect(4).to eq 4
  #   end

  #   it 'reverses correctly' do
  #     expect(4).to eq 4
  #   end
  # end

  # private

  # Useful helper functions for testing
  #
  # - Initialize a git repo at a given location
  # - Run arbitrary shell commands (does it matter if in subprocess?)
  # - Capture $stdout/$stderr and match against a given regex

  # def run(cmd)
  #   out = IO.popen cmd
  #   out.readlines
  # end
end
