module Tex2png
  class Command
    attr_reader :path, :out, :name

    def initialize(name)
      @name = name
      @path = IO.popen("which #{name}").read.chomp
      CommandNotFound.raise!(name) {path.empty?}
    end

    def run(*args)
      Result.new(name, IO.popen(%Q|#{path} #{args.join(" ")}|, :err => [:child, :out]))
    end
  end
end
