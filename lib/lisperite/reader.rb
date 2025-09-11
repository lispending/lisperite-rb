class Lisperite::Reader
  attr_reader :io

  def initialize(source)
    @io = source
  end

  def read
    tokens = []
    while(!io.eof?)
      tokens <<
        case c = io.getc
        when "("
          list
        else
          atom
        end
    end
    tokens
  end

  private

  def list
    token = {type: :list, content: []}
    while(!io.eof?)
      c = io.getc
      return token if(")" == c)
    end

    raise "expecting list to be closed with: #{c}, but none was found"
  end
end
