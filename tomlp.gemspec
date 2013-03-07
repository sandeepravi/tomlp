# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tomlp/version'

Gem::Specification.new do |gem|
  gem.name          = "tomlp"
  gem.version       = Tomlp::VERSION
  gem.authors       = ["sandeepravi"]
  gem.email         = ["sandeepravi.bits@gmail.com"]
  gem.summary       = "A ruby parser for the TOML library."
  gem.description   = %q{Parse the TOML specificatin}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'treetop'

  gem.add_development_dependency "rspec"
end
