require 'pry'
require 'nonono'

module Nonono
  module CLI
    attr_accessor :should_undo, :commands

    class << self
      def start(argv)
        should_undo = wants_to_undo? argv
        Nonono.find should_undo
      end

      def wants_to_undo?(argv)
        argv.first =~ /(undo|u)/
      end
    end
  end
end
