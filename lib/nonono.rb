require 'nonono/version'
require 'nonono/file'
require 'nonono/commands'

module Nonono
  class << self
    def find(should_undo)
      put 'You are not inside a git directory' unless in_git_directory?
      past_commands = read_history.map { |cmd| cmd.sub(/:\s+\d+:\d+;/, '') }
      last_git_command = past_commands.reverse.find { |cmd| git_command? cmd }

      if last_git_command.nil?
        puts "You haven't issued a git command in a while.. Nothing to undo"
        return
      end

      args = format_git_command last_git_command
      undo_command, no_run = Nonono::Commands.delegator(args[:commands].shift, args, should_undo)

      # harmless commands so nothing to undo
      return if undo_command.nil?

      # means the revert commnd is dangerous and we shouldn't
      # run it automatically
      if no_run
        puts "I can't run this automatically because it is dangerous. Here is my best guess.."
        undo_command = false
      end

      puts "Run#{should_undo ? 'ning' : ''} #{undo_command} to undo..."
      Kernel.exec undo_command if should_undo
    end

    def in_git_directory?
      `git rev-parse --is-inside-work-tree` rescue false
    end

    def git_command?(command)
      /\s*git\s+[\w\s]+/ =~ command
    end

    def format_git_command(command)
      # remove the git command
      split = command.split(' ').drop(1)
      Minimist.parse(split)
    end

    def read_history
      return if history_file.nil?

      File.open(history_file) do |file|
        return file.tail(30)
      end
    end

    def history_file
      if ENV['TEST']
        return File.expand_path(
          '../spec/fixtures/mock_history',
          File.dirname(__FILE__)
        )
      end

      @history_file ||= %w( zsh bash ).each do |sh|
        path = File.expand_path("~/.#{sh}_history")
        return path if File.exist?(path)
      end
    end
  end
end
