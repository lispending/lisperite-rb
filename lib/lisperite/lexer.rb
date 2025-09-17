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
      until reader.eof?
        c = consume
        break if c == "\s"
        value << c
      end
      end_col = {column: (reader.eof? ? @column - 1 : @column - 2), line: @line}
      {type: :atom, value: value, position: {start: start, end: end_col}}
    end

    def consume
      reader.next.tap do |c|
        @column += 1 unless c.nil?
      end
    end
  end
end
