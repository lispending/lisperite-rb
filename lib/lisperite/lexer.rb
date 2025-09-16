module Lisperite
  class Lexer
    private attr_reader :reader

    def initialize(source)
      @reader = Lisperite::Reader.new(source)
      @line = 1
      @column = 1
    end

    def run
      tokens = []
      until reader.eof?
        tokens << next_token
      end

      tokens
    end

    private

    def next_token
      return if reader.eof?

      case reader.peek
      when "..."
        nil
      else
        atom
      end
    end

    def atom
      str = ""
      start = {line: @line, column: @column}
      while !reader.eof? && consume
        break if reader.current == "\s"
        str << reader.current
      end
      {type: :atom, value: str, position: {start: start, end: {line: @line, column: @column}}}
    end

    def consume
      reader.next.tap { @column += 1 }
    end
  end
end
