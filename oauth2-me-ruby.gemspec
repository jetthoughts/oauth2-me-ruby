# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oauth2-me/version'

Gem::Specification.new do |spec|
  spec.name          = 'oauth2-me'
  spec.version       = OAuth2Me::VERSION
  spec.authors       = ['Dmitriy Dudkin']
  spec.email         = ['dudkin.dmitriy@gmail.com']
  spec.summary       = %q{A gem for integrating oauth2.me into your ruby application}
  spec.description   = ''
  spec.homepage      = 'http://oauth2.me/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
