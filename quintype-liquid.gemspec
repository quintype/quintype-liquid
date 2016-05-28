# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quintype/liquid/version'

Gem::Specification.new do |spec|
  spec.name          = "quintype-liquid"
  spec.version       = Quintype::Liquid::VERSION
  spec.authors       = ["Tejas Dinkar"]
  spec.email         = ["tejas@gja.in"]

  spec.summary       = %q{Isomorphically Render Liquid in Rails and JS}
  spec.homepage      = "https://github.com/quintype/quintype-liquid"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "liquid-rails", "~> 0.1.3"
  spec.add_dependency "concurrent-ruby", "~> 1.0.2"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
