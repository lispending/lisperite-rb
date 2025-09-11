# frozen_string_literal: true

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup

require_relative "lisperite/version"

module Lisperite
  class Error < StandardError; end
  # Your code goes here...
end
