require "tex2png/version"
require "tex2png/errors"
require "tex2png/result"
require "tex2png/command"
require "tex2png/converter"

module Tex2png
  LATEX_PACKAGES = [
    "amssymb", "amsmath", "color", "amsfonts"
  ].freeze

  TEMP_DIR = "/tmp/tex2png"

  class << self
    def latex
      @latex ||= Command.new(:latex)
    end

    def dvipng
      @dvipng ||= Command.new(:dvipng)
    end
  end

  def Convert(formula, density: 155)
    Converter.new(formula, density: density)
  end
end
