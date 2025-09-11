class Lisperite::Reader
  attr_reader :io

  def initialize(source)
    @io = source
  end

  def read
    tokens = []
    while(!io.eof?)
      token = next_token
      tokens << token unless token.nil?
    end
    tokens
  end

  private

  def next_token
    c = io.getc
    while(c == " "); c = io.getc end
    case c
    when ")"
      raise "unmatched ), no list was open"
    when "("
      list
    else
      io.ungetc(c)
      atom
    end
  end

  def atom
    c = io.getc
    while(c == " " && !io.eof?); c = io.getc end
    return nil if io.eof?

    token = {type: :atom, content: ""}
    while(!c.nil? && !io.eof?)
      token[:content] << c
      c = io.getc
      return token if c == " "
      if c == ")"
        io.ungetc(c)
        return token
      end
    end
    token[:content] << c unless c.nil?
    token
  end

  def list
    token = {type: :list, content: []}
    while(!io.eof?)
      c = io.getc
      while(c == " " && !io.eof?); c = io.getc end
      return token if c == ")"
      break if io.eof?
      io.ungetc(c)
      token[:content] << next_token
    end
    raise "unmatched (, expecting ) after: #{token[:content].last}" if(c != ")")
    token
  end
end
