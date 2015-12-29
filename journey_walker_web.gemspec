# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'journey_walker_web/version'

Gem::Specification.new do |spec|
  spec.name          = 'journey_walker_web'
  spec.version       = JourneyWalkerWeb::VERSION
  spec.authors       = ['Gareth Smyth']

  spec.summary       = 'Journey Walker web utilises the journey_Walker gem to present slims based on get calls to '\
                       'endpoints based on the states in the journey walker config.'
  spec.homepage      = 'https://github.com/gareth-smyth/journey_walker_web'
  spec.license       = 'MIT'

  spec.files         = Dir.glob('lib/**/*') + %w(LICENSE README.md)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'r18n-core'
  spec.add_runtime_dependency 'journey_walker'
  spec.add_runtime_dependency 'sinatra'
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rack-test'
end
