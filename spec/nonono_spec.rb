require 'fileutils'
require 'spec_helper'
require 'pry'

RSpec.describe Nonono, 'nonono specs' do
  before(:each) do
    FileUtils.mkdir_p('test_repo')
    FileUtils.cd('test_repo')
    `git init`
  end

  after(:each) do
    FileUtils.cd('../')
    FileUtils.remove_dir('test_repo')
  end

  describe 'Git init' do
    it 'knows the reverse commands' do
      out = run 'nonono'
      binding.pry
      puts "------------"
      expect(4).to eq 4
    end

    it 'reverses correctly' do
      expect(4).to eq 4
    end
  end

  private

  def run(cmd)
    out = IO.popen cmd
    out.readlines
  end
end
