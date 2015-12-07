require "securerandom"
require "base64"
require "fileutils"

module Tex2png
  class Converter
    attr_reader :hash, :formula, :density, :name, :dir, :base

    def initialize(formula, density: 155)
      @formula = formula
      @density = density
      @hash    = SecureRandom.hex(16)
      @base    = File.join TEMP_DIR, hash
    end

    def content
      @content ||= <<-END.gsub(/^ {6}/, "")
        \\documentclass[12pt]{article}
        \\usepackage[utf8]{inputenc}
        \\usepackage{#{LATEX_PACKAGES.join(", ")}}
        \\begin{document}
        \\pagestyle{empty}
        \\begin{displaymath}
        #{formula}
        \\end{displaymath}
        \\end{document}
      END
    end

    def data
      @data ||= png do |io|
        "data:image/png;base64, #{Base64.encode64(io.read)}"
      end
    end

    def png(&block)
      @png ||= proc do
        args = [
         "-q -T tight -D #{density}", "-o #{base}.png", "#{base}.dvi"
        ]

        tex
        dvi
        Tex2png::dvipng.run(*args).raise!
        clean!

        path(:png)
      end.call

      file(:png, &block)
    end

    private

    def tex
      @tex ||= file(:tex, "w") do |file|
        file.write content
        file.path
      end
    end

    def dvi
      @dvi ||= proc do
        args = [
          "-output-directory=#{TEMP_DIR}", "-interaction=nonstopmode", tex
        ]

        Tex2png::latex.run(*args).raise!

        path(:dvi)
      end.call
    end

    def clean!
      FileUtils.rm %W{tex aux log dvi}.map {|ext| path(ext)}
    end

    def file(ext, mode = "r", &block)
      FileUtils.mkdir TEMP_DIR if !File.exists? TEMP_DIR
      File.open(path(ext), mode, &block)
    end

    def path(ext)
      "#{base}.#{ext}"
    end
  end
end
