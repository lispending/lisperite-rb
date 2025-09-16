RSpec.describe Lisperite::Lexer do
  it "recognizes a single atom" do
    tokens = described_class.new("lisperite").run

    expect(tokens.first[:type]).to eq :atom
    expect(tokens.first[:value]).to eq "lisperite"
  end

  it "recognizes multiple atoms separated by space" do
    tokens = described_class.new("lisperite a ruby lispey thingy").run

    expect(tokens.map { |t| t[:value] }).to eq ["lisperite", "a", "ruby", "lispey", "thingy"]
  end

  it "keeps track of columns where atoms start and end" do
    tokens = described_class.new("lisperite").run

    expect(tokens.first[:position][:start]).to eq(line: 1, column: 1)
  end

  it "recognizes changes of lines when finding atoms"
end
