module Tex2png
  class Result
    attr_reader :raw, :output, :cmd

    def initialize(cmd, io)
      @cmd = cmd
      @raw = io
    end

    def output
      @output ||= raw.read
    end

    def success?
      @success ||= Process.wait2(raw.pid)[1].success?
    end

    def raise!
      ExcutionError.raise!("#{cmd} - #{output}") {!success?}
    end
  end
end
