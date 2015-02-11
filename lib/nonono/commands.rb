require "yaml"
require "pry"

module Nonono
  class Commands
    class << self

      #
      # Prints the message specified and gives control
      # to a specific method for that command
      #
      def delegator cmd, args
        puts "NONONO.. you are saved."
        puts commands[cmd]["message"]
        send cmd, args
        puts "git undo done"
      end

      #
      # Methods that handle each commands on
      # an individual basis
      #
      def help *args
        puts "getting help from git"
      end

      def add
       # TODO
      end

      def branch
        # todo
      end

      def checkout

      end

      def clone

      end

      def commit

      end

      def diff

      end

      def fetch

      end

      def grep

      end

      def init

      end

      def log

      end

      def merge

      end

      def mv

      end

      def pull

      end

      def push

      end

      def rebase

      end

      def reset

      end

      def rm

      end

      def show

      end

      def status

      end

      def tag

      end

      private
      def commands
        @commands ||= YAML.load(File.open(File.expand_path(File.join(__FILE__, '..', 'commands.yml'))))
      end
    end
  end
end
