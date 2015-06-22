require 'nonono'
require 'minimist'

module Nonono
  module CLI
    class << self
      def start(argv)
        args = Minimist.parse argv
        Nonono.find !!args[:undo]
      end
    end
  end
end
