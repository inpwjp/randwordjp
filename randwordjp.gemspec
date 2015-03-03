# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'randwordjp/version'

Gem::Specification.new do |spec|
  spec.name          = 'randwordjp'
  spec.version       = Randwordjp::VERSION
  spec.authors       = ['inpwjp']
  spec.email         = ['inpw@mua.biglobe.ne.jp']
  spec.description    = 'get Japanese random words.'
  spec.summary        = 'get Japanese random words.'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'sqlite3' if $platform.to_s == 'ruby'
  spec.add_dependency 'jdbc-sqlite3' if $platform.to_s == 'java'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3' if $platform.to_s == 'ruby'
  spec.add_development_dependency 'jdbc-sqlite3' if $platform.to_s == 'java'
end
