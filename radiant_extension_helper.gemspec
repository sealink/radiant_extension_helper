# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'radiant_extension_helper/version'

Gem::Specification.new do |spec|
  spec.name          = 'radiant_extension_helper'
  spec.version       = RadiantExtensionHelper::VERSION
  spec.authors       = ['Michael Noack', 'Michael Smirnoff']
  spec.email         = ['support@travellink.com.au']
  spec.description   = %q{Helper to easily copy assets/load config from your radiant extension to your CMS}
  spec.summary       = %q{Helper to easily copy assets/load config from your radiant extension to your CMS}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
