# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'randwordjp/version'

Gem::Specification.new do |spec|
  spec.name          = "randwordjp"
  spec.version       = Randwordjp::VERSION
  spec.authors       = ["inpjp"]
  spec.email         = ["inpwjp@yokoyama-you.com"]
  spec.summary       = %q{TODO: "ランダムな文字列を取得する"}
  spec.description   = %q{TODO: "ランダムな文字列を取得する"}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
