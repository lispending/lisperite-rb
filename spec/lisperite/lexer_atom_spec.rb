RSpec.describe Lisperite::Lexer do
  it "recognizes a single atom" do
    tokens = described_class.new("lisperite").run
    token = tokens.first

    expect(token[:type]).to eq :atom
    expect(token[:value]).to eq "lisperite"
  end

  it "knows about a single atom position" do
    tokens = described_class.new("lisperite").run
    token = tokens.first

    expect(token[:position][:start]).to eq(line: 1, column: 1)
    expect(token[:position][:end]).to eq(line: 1, column: 9)
  end

  it "recognizes multiple atoms separated by spaces" do
    tokens = described_class.new("lisperite a very tiny lisp").run

    expect(tokens.map { |t| t[:value] }).to eq ["lisperite", "a", "very", "tiny", "lisp"]
  end

  it "knows the position of multiple atom tokens" do
    tokens = described_class.new("lisperite a very tiny lisp").run

    expect(tokens[0][:position]).to eq start: {column: 1, line: 1}, end: {column: 9, line: 1}
    expect(tokens[1][:position]).to eq start: {column: 11, line: 1}, end: {column: 11, line: 1}
    expect(tokens[2][:position]).to eq start: {column: 13, line: 1}, end: {column: 16, line: 1}
    expect(tokens[3][:position]).to eq start: {column: 18, line: 1}, end: {column: 21, line: 1}
    expect(tokens[4][:position]).to eq start: {column: 23, line: 1}, end: {column: 26, line: 1}
  end

  it "recognizes atoms on multiple lines" do
    tokens = described_class.new("lisperite\na very tiny\nlisp").run

    expect(tokens[0][:position]).to eq start: {column: 1, line: 1}, end: {column: 9, line: 1}
    expect(tokens[1][:position]).to eq start: {column: 1, line: 2}, end: {column: 1, line: 2}
    expect(tokens[2][:position]).to eq start: {column: 3, line: 2}, end: {column: 6, line: 2}
    expect(tokens[3][:position]).to eq start: {column: 8, line: 2}, end: {column: 11, line: 2}
    expect(tokens[4][:position]).to eq start: {column: 1, line: 3}, end: {column: 4, line: 3}
  end

  it "ignores non-significant spaces" do
    tokens = described_class.new("   lisperite \n a     very  tiny  \nlisp   ").run

    expect(tokens[0][:position]).to eq start: {column: 4, line: 1}, end: {column: 12, line: 1}
    expect(tokens[1][:position]).to eq start: {column: 2, line: 2}, end: {column: 2, line: 2}
    expect(tokens[2][:position]).to eq start: {column: 8, line: 2}, end: {column: 11, line: 2}
    expect(tokens[3][:position]).to eq start: {column: 14, line: 2}, end: {column: 17, line: 2}
    expect(tokens[4][:position]).to eq start: {column: 1, line: 3}, end: {column: 4, line: 3}
  end
end
