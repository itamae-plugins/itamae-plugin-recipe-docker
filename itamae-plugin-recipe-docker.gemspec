# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/recipe/docker/version'

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-recipe-docker"
  spec.version       = Itamae::Plugin::Recipe::Docker::VERSION
  spec.authors       = ["Takashi Kokubun"]
  spec.email         = ["takashikkbn@gmail.com"]

  spec.summary       = %q{Itamae recipe plugin to install Docker.}
  spec.description   = %q{Itamae recipe plugin to install Docker.}
  spec.homepage      = "https://github.com/k0kubun/itamae-plugin-recipe-docker"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "itamae", ">= 1.6"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "itamae-plugin-resource-cask"
  spec.add_development_dependency "rake", "~> 10.0"
end
