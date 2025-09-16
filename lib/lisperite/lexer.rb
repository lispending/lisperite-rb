module Lisperite
  class Lexer
    private attr_reader :reader

    def initialize(source)
      @reader = Lisperite::Reader.new(source)
      @line = 1
      @column = 0
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
      while !reader.eof? && reader.next
        str << reader.current
      end
      {type: :atom, value: str}
    end
  end
end
