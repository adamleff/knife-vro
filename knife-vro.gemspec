# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'knife-vro/version'

Gem::Specification.new do |spec|
  spec.name          = "knife-vro"
  spec.version       = KnifeVro::VERSION
  spec.authors       = ["Adam Leff"]
  spec.email         = ["aleff@chef.io"]
  spec.summary       = %q{Knife plugin to interact with VMware vRealize Orchestrator.}
  spec.description   = spec.summary
  spec.homepage      = "http://gihub.com/chef-partners/knife-vro"
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'chef',         '~> 12.0'
  spec.add_dependency 'vcoworkflows', '~> 0.2.1'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake',    '~> 10.0'
end
