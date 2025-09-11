class Lisperite::Reader
  attr_reader :io

  def initialize(source)
    @io = source
  end

  def read
    tokens = []
    while(!io.eof?)
      c = io.getc
      while(c == " "); c = io.getc end
      next if io.eof?
      io.ungetc(c)
      tokens << next_token
    end
    tokens
  end

  private

  def next_token
    c = io.getc
    case c
    when "("
      list
    else
      io.ungetc(c)
      atom
    end
  end

  def atom
    token = {type: :atom, content: ""}
    c = io.getc
    while(!c.nil? && !io.eof?)
      token[:content] << c
      c = io.getc
      return token if c == " "
    end

    token
  end

  def list
  end
end
