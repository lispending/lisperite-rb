RSpec.describe Lisperite::Lexer do
  it "recognizes a single atom" do
    tokens = described_class.new("lisperite").run

    expect(tokens.first[:type]).to eq :atom
    expect(tokens.first[:value]).to eq "lisperite"
  end

  it "recognizes multiple atoms separated by space"
  it "ignores unsignificant spaces"
  it "keeps track of columns where atoms start and end"
  it "recognizes changes of lines when finding atoms"
end
