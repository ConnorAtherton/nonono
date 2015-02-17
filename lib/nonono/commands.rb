require "yaml"
require "pry"

module Nonono
  class Commands
    HARMLESS_COMMANDS = [
      :status, :log, :diff, :show,
      :ls_tree, :cat_file, :grep, :help
    ]

    # commands that can't be undone in git
    DOOM_COMMANDS = []

    class << self

      # Prints the message specified and gives control
      # to a specific method for that command
      def delegator cmd, args
        is_harmless = HARMLESS_COMMANDS.include? cmd.to_sym
        # TODO check if run with --dry-run here and print message
        # saying the last command had no effect
        # if /--dry-run/ ~= args

        # end

        print commands["harmless"] if is_harmless
        puts commands[cmd]["message"]
        send cmd, args if self.respond_to? cmd.to_sym
      end

      def add args
        return "git reset" unless (/(^.$|.\s+|--all|\*)/ =~ args).nil?

        "git reset #{args}"
      end

      def branch args
        # lists branches
        # TODO distinguish between remotes and local branches
        return puts commands['branch']['list']['message'] if args.nil?

        # rename branch with -m
        unless (/\s*-m\s+/ =~ args).nil?
          old, new = args.gsub(/\s*-m\s+/, "").split(" ")
          return "git branch -m #{new} #{old}"
        end

        # deleted branch
        # TODO need to interpolate strings in .yml file to pass in vars
        unless (/\s*(d|D)\s+/ =~ args).nil?
          branch = args.gsub(/\s*(d|D)\s+/, "").strip
          interpolate(commands['branch']['delete']['message'], branch)
          return
        end

        # created a new branch
        if !!(/^[A-Za-z0-9]+([:-]*[A-Za-z0-9]+)*$/ =~ args)
          interpolate(commands['branch']['create']['message'], args)
          return "git branch -D #{args}"
        end

        # set/unset upstream
        # todo
      end

      def checkout args

      end

      def clone args

      end

      def commit args

      end

      def fetch args

      end

      def init args

      end

      def merge args

      end

      def mv args

      end

      def pull args

      end

      def push args

      end

      def rebase args

      end

      def reset args

      end

      def rm args

      end

      def tag args

      end

      private

      def commands
        @commands ||= YAML.load(File.open(File.expand_path(File.join(__FILE__, '..', 'commands.yml'))))
      end

      def interpolate string, *args
        args.each_with_index do |arg, i|
          string.gsub! "{{#{i + 1}}}", arg
        end

        puts string
      end
    end
  end
end
