# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lazy_warrior/version'

Gem::Specification.new do |spec|
  spec.name          = 'lazy_warrior'
  spec.version       = LazyWarrior::VERSION
  spec.authors       = ['Brian van de Boogaard']
  spec.email         = ['brian.boogaard@gmail.com']
  spec.summary       = 'Add tasks to Task Warrior from external sources'
  spec.description   = "Update Task Warrior tasks from important sites, because I'm lazy."
  spec.homepage      = 'https://github.com/b-boogaard'
  spec.license       = 'MIT'
  spec.version       = LazyWarrior::VERSION.dup

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib', 'lib/client']
  spec.required_ruby_version = '>= 2.0.0'
  spec.required_rubygems_version = '>= 1.3.5'

  # Development dependencies
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec-core', '~> 3.2'
  spec.add_development_dependency 'rspec-mocks', '~> 3.2'
  spec.add_development_dependency 'rspec-expectations', '~> 3.2'
  spec.add_development_dependency 'pry', '~> 0.10.1'

  # Runtime dependencies
  spec.add_runtime_dependency 'octokit', '~> 3.0'
  spec.add_runtime_dependency 'json', '~> 1.8'
end
