module Lisperite
  class Lexer
    private attr_reader :reader

    def initialize(source)
      @reader = Lisperite::Reader.new(source)
      @column = 1
      @line = 1
    end

    def run
      tokens = []
      until reader.eof?
        consume while reader.peek == "\s"
        if reader.peek == "\n" || reader.peek == "\r"
          new_line
          next
        end
        token = next_token
        tokens << token unless token.nil?
      end
      tokens
    end

    private

    def next_token
      atom
    end

    def atom
      value = ""
      start = {column: @column, line: @line}
      end_col = @column

      until reader.eof?
        break if reader.peek == "\n" || reader.peek == "\r"
        c = consume
        break if c == "\s"
        end_col += 1
        value << c
      end

      {type: :atom, value: value, position: {
        start: start, end: {column: end_col - 1, line: @line}
      }}
    end

    def consume
      reader.next.tap do |c|
        @column += 1 unless c.nil?
      end
    end

    def new_line
      consume
      consume if reader.peek == "\n" # in case we have CRLF
      @line += 1
      @column = 1
    end
  end
end
