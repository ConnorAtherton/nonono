require "nonono/version"
require "pry"

module Nonono
  attr_accessor :commands

  class << self
    def find should_undo
      put "Not a git dir" unless in_git_directory
      history = `history 50`
      binding.pry
      history.each do |cmd|
        return process_cmd if is_git_cmd? cmd
      end

      puts "no git commands"
    end

    def commands
      @commands ||= YAML.load(File.open(File.expand_path(File.join(__FILE__, '..', 'commands.yml'))))
    end

    def in_git_directory
      # TODO how well does this work?
      `git rev-parse --is-inside-work-tree` rescue false
    end
  end
end

