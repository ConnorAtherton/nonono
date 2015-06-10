require 'yaml'
require 'pry'

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
      def delegator(cmd, args, should_undo = nil)
        is_harmless = HARMLESS_COMMANDS.include? cmd.to_sym

        @commands = args[:commands]
        @options = args[:options]

        # TODO: check if run with --dry-run here and print message
        # saying the last command had no effect
        # if args[:options][:dry_run]

        # end

        unless should_undo
          print commands['harmless'] if is_harmless
          puts commands[cmd].is_a?(Hash) ? commands[cmd]['message'] : commands[cmd]
        end

        send(cmd, args) if self.respond_to? cmd.to_sym
      end

      def add(args)
        return 'git reset' unless (/(^.$|.\s+|--all|\*)/ =~ args).nil?

        "git reset #{args}"
      end

      def branch(args)
        # lists branches
        # TODO: distinguish between remotes and local branches
        return puts commands['branch']['list'] if args.nil?

        # TODO: -r list remote and -a lists all branches

        # rename branch with -m
        unless (/\s*-(m|-move)\s+/ =~ args).nil?
          old, new = args.gsub(/\s*-(m|-move)\s+/, "").split(" ")
          return "git branch -m #{new} #{old}"
        end

        # deleted branch
        # TODO: need to interpolate strings in .yml file to pass in vars
        unless (/\s*(d|D)\s+/ =~ args).nil?
          branch = args.gsub(/\s*(d|D)\s+/, "").strip
          interpolate(commands['branch']['delete'], branch)
          return
        end

        # created a new branch
        if !!(/^[A-Za-z0-9]+([:-]*[A-Za-z0-9]+)*$/ =~ args)
          interpolate(commands['branch']['create'], args)
          return "git branch -D #{args}"
        end

        # set/unset upstream
        # todo
      end

      def checkout(args)
        'git checkout -'
      end

      # TODO: this doesn't support options right now
      # needs a way to do args parsing
      def clone(args)
        args.split!
        # git clone [opts] [repo] [dir]
        # raise InvalidArguments error unless args.split.length > 1
        humanized_name = /[a-zA-Z1-9]+.git/.match args[0]
        name = args[1] unless args[1].nil?

        ["rm -rf #{name || humanized_name}", true]
      end

      def commit args
        'git reset --soft HEAD~1'
      end

      def fetch args
        # http://stackoverflow.com/questions/15254480/reverse-a-git-fetch
        ['git update-ref refs/remotes/origin/master refs/remotes/origin/master@{1}', true]
      end

      def init(_)
        'rm -rf .git'
      end

      def merge args
      end

      def mv(args)
        args.gsub(/-[a-zA-Z0-9]/, '').strip

        # TODO: have maliformed git command error
        old, new = args.split
        # raise MalformedCommandError unless old && new
        "git mv #{new} #{old}" if old && new
      end

      def pull(_)
      end

      def push(args)
        args = args.split(' ')

        if args.count == 1
          branch = args.first
        elsif args.count == 2
          remote, branch = args
        else
          # TODO: throw malformed command error
        end

        "You just pushed your #{branch} branch the #{remote} remote."
      end

      def rebase(_)
      end

      def reset(_)
        # TODO
        # could we probe back in the history a little longer
        # to give a better answer here. Won't work on rebase etc
        ['git reset HEAD@{1}', true]
      end

      def revert(_)
        # TODO: should we just do another revert here?
        'git reset --hard HEAD^1'
      end

      def rm(_)
      end

      def tag(args)
        # listing tags..
        if args.nil?
          puts commands['harmless'] + commands['tag']['list']
          return nil
        end

        # added a tag
        add_or_delete = '-d' if (tag_name = /-a\s+([a-zA-Z0.9]+)/.match args)

        # deleted a tag
        if add_or_delete.nil? && (tag_name = /-d\s+([a-zA-Z0.9]+)/.match args)
          add_or_delete = '-a'
        end

        "git tag #{add_or_delete} #{tag_name[1]}"
      end

      def archive(args)
        # Assume we are piping into something
        args = args.split ' '
        # TODO: seriously need a ruby arg parser for this
        branch_name, _op, archive_name = args
        # TODO: malformed git command error
        # return nil if!(branch && archive_name
        interpolate(commands['archive']['notification'], branch_name)
        "rm #{archive_name}"
      end

      def remote(_)
      end

      private

      def commands
        file = File.open(File.expand_path(File.join(__FILE__, '..', 'commands.yml')))
        @commands ||= YAML.load(file)
      end

      def interpolate(string, *args)
        args.each_with_index do |arg, i|
          string.gsub! "{{#{i + 1}}}", arg
        end

        puts string
      end
    end
  end
end
