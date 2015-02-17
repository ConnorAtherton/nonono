require "nonono/version"
require "nonono/file"
require "nonono/commands"
require "pry"

module Nonono
  attr_accessor :commands

  class << self
    def find should_undo
      put "Not a git dir" unless in_git_directory
      past_commands = read_history.map { |cmd| cmd.sub /:\s+\d+:\d+;/, ''}
      last_git_command = past_commands.reverse.find { |cmd| is_git_command? cmd }

      if last_git_command.nil?
        puts "You haven't issued a git command in a while.. Nothing to undo"
        return
      end

      command, args = format_git_command last_git_command
      undo_command = Nonono::Commands.send :delegator, command, args

      # harmless commands so nothing to undo
      return if undo_command.nil?

      puts "Run#{should_undo ? "ning" : ""} #{undo_command} to undo..."
      Kernel.exec undo_command if should_undo
    end

    def in_git_directory
      `git rev-parse --is-inside-work-tree` rescue false
    end

    def is_git_command? command
      /\s*git\s+[\w\s\S]+/ =~ command
    end

    def format_git_command command
      split = command.split " "
      # assuming simple git commands for now
      #  git show
      #  git add
      #  git remote etc
      command = split.slice! 0, 2

      # replace spaces and hashed with underscores
      command = command[1].gsub /-/, "_"
      args = split.empty? ? nil : split.join(" ")

      [command, args]
    end

    def read_history
      path = File.expand_path('~/.zsh_history')
      # TODO regex for any shell history file
      # /(bash|zsh)/ and test against shell version

      if File.exists?(path)
        File.open(path) do |file|
          return file.tail(30)
        end
      end
    end
  end
end

