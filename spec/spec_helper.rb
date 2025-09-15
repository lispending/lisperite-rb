# frozen_string_literal: true

require "lisperite"

module Lisperite
  module SpecHelper
    FIXTURES_PATH = File.expand_path("../fixtures/", __FILE__).freeze

    def fixture_path(file_name)
      File.join(FIXTURES_PATH, file_name)
    end

    def fixture(file_name)
      path = fixture_path(file_name)
      raise "no file: #{fixture_path(path)}" if !File.exist?(fixture_path(path))
      File.read(path)
    end
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include Lisperite::SpecHelper
end
