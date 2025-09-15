module Lisperite
  class Reader
    private attr_reader :io

    def initialize(source)
      @io =
        if source.is_a?(IO)
          source
        else
          File.exist?(source) ? File.new(source) : StringIO.new(source)
        end
    end

    def eof?
      io.eof?
    end

    def next
      io.getc
    end

    def peek
      io.getc.tap { |c| io.ungetc(c) }
    end
  end
end
