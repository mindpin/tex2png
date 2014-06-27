module Tex2png
  class Error < Exception
    def self.raise!(msg = nil, &cond)
      raise self.new(msg) if !cond || cond.call
    end
  end

  AbstractCommandError = Class.new(Error)
  CommandNotFound      = Class.new(Error)
  ExcutionError        = Class.new(Error)
end
