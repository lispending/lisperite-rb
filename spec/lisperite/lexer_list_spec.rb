RSpec.describe Lisperite::Lexer do
  it "recognizes list delimiters" do
    tokens = described_class.new("()").run

    expect(tokens.first[:type]).to eq :list
    expect(tokens.first[:value]).to eq []
  end

  it "builds a list containing atoms" do
    tokens = described_class.new("(lisperite is a lisp)").run

    expect(tokens.first[:type]).to eq :list
    expect(tokens.first[:value].map { |t| [t[:type], t[:value]] }).to eq [
      [:atom, "lisperite"], [:atom, "is"], [:atom, "a"], [:atom, "lisp"]
    ]
  end

  it "builds a list containing atoms and lists" do
    tokens = described_class.new("(lisperite (is a) lisp)").run
    items = tokens.first[:value]

    expect(items[0][:type]).to eq :atom
    expect(items[0][:value]).to eq "lisperite"
    expect(items[1][:type]).to eq :list
    expect(items[1][:value].map { |t| [t[:type], t[:value]] }).to eq [
      [:atom, "is"], [:atom, "a"]
    ]
    expect(items[2][:type]).to eq :atom
    expect(items[2][:value]).to eq "lisp"
  end

  it "knows the position of a list" do
    tokens = described_class.new("   (   lisperite is a )   \n   (tiny lisp)").run

    expect(tokens[0][:position]).to eq(start: {column: 4, line: 1}, end: {column: 23, line: 1})
    expect(tokens[0][:value][0][:position]).to eq(start: {column: 8, line: 1}, end: {column: 16, line: 1})
    expect(tokens[0][:value][1][:position]).to eq(start: {column: 18, line: 1}, end: {column: 19, line: 1})
    expect(tokens[0][:value][2][:position]).to eq(start: {column: 21, line: 1}, end: {column: 21, line: 1})

    expect(tokens[1][:position]).to eq(start: {column: 4, line: 2}, end: {column: 14, line: 2})
    expect(tokens[1][:value][0][:position]).to eq(start: {column: 5, line: 2}, end: {column: 8, line: 2})
    expect(tokens[1][:value][1][:position]).to eq(start: {column: 10, line: 2}, end: {column: 13, line: 2})
  end
end
