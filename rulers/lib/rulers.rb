# frozen_string_literal: true

require_relative "rulers/version"
require "rulers/array"

module Rulers
  class App
    def call(env)
      `echo debug > debug.txt`
      [
        200,
        {"Content-Type" => "text/html"},
        ["Hello, World!"]
      ]
    end
  end
end
