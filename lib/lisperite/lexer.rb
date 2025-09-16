module Lisperite
  class Lexer
    private attr_reader :reader

    def initialize(source)
      @reader = Lisperite::Reader.new(source)
    end

    def run
      tokens = []
      until reader.eof?
      end
      tokens
    end
  end
end
