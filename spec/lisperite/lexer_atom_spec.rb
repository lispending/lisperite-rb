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
    positions = tokens.map { |t| t[:position] }

    expect(positions).to eq [
      {start: {column: 1, line: 1}, end: {column: 9, line: 1}},
      {start: {column: 11, line: 1}, end: {column: 11, line: 1}},
      {start: {column: 13, line: 1}, end: {column: 16, line: 1}},
      {start: {column: 18, line: 1}, end: {column: 21, line: 1}},
      {start: {column: 23, line: 1}, end: {column: 26, line: 1}}
    ]
  end
end
