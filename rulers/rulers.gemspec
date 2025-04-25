# frozen_string_literal: true

require_relative "lib/rulers/version"

Gem::Specification.new do |spec|
  spec.name = "rulers"
  spec.version = Rulers::VERSION
  spec.authors = ["Josiah"]
  spec.email = ["josiah.pilon@gmail.com"]

  spec.summary = %q{A Rack-based Web Framework}
  spec.description = %q{A Rack-based Web Framework, but with extra awesome.}
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = "http://www.example.com"

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.files = `git ls-files -z`.split("\x0")

  spec.add_dependency "rack", "~> 2.2"
  spec.add_dependency "webrick"
  spec.add_dependency "erubis"
  spec.add_dependency "multi_json"
  spec.add_dependency "sqlite3"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rack-test"
end
