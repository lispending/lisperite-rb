module Lisperite
  class Lexer
    private attr_reader :reader

    def initialize(source)
      @reader = Lisperite::Reader.new(source)
    end
  end
end
