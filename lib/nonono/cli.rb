require 'nonono'
require 'minimist'
require 'pry'

module Nonono
  module CLI
    attr_accessor :should_undo, :commands

    class << self
      def start(argv)
        args = Minimist.parse argv
        Nonono.find !!args[:undo]
      end
    end
  end
end
