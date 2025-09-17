RSpec.describe Lisperite::Reader do
  subject(:reader) { described_class.new("hello world\r\n") }

  it "marks eof? as true after reading the whole string" do
    expect(reader.eof?).to eq false

    13.times { reader.next }

    expect(reader.eof?).to eq true
  end

  it "reads a string char by char" do
    str = ""
    until reader.eof?
      str << reader.next
    end

    expect(str).to eq "hello world\r\n"
  end

  it "allows for peaking next char, without consuming it" do
    expect(reader.peek).to eq "h"
    expect(reader.next).to eq "h"
    expect(reader.peek).to eq "e"
    expect(reader.next).to eq "e"
  end

  it "returns nil if trying to peek after eof" do
    until reader.eof?; reader.next end

    expect(reader.peek).to eq nil
  end

  context "files" do
    it "creates a reader from a file path" do
      reader = described_class.new(fixture_path("hello_world.txt"))
      str = ""
      until reader.eof?
        str << reader.next
      end

      expect(str).to eq "hello world\n"
    end

    it "creates a reader from a File object" do
      reader = described_class.new(File.new(fixture_path("hello_world.txt")))
      str = ""
      until reader.eof?
        str << reader.next
      end

      expect(str).to eq "hello world\n"
    end
  end
end
