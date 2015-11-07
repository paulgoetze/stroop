# -*- encoding: utf-8 -*-

require File.dirname(__FILE__) + "/lib/stroop/version"

Gem::Specification.new do |gem|
  gem.name          = "stroop"
  gem.version       = Stroop::VERSION
  gem.summary       = "Stroop effect"
  gem.description   = "The Stroop effect - demonstrating the interference in the reaction time of a task."
  gem.authors       = ["Paul Götze"]
  gem.email         = "paul.christoph.goetze@gmail.com"
  gem.homepage      = "https://github.com/paulgoetze/stroop"
  gem.license       = "MIT"

  gem.files         = Dir['{**/}{.*,*}'].select{ |path| File.file?(path) && path !~ /^pkg/ }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '~> 2.0'

  gem.add_runtime_dependency     'colorize', '~> 0.7'
  gem.add_runtime_dependency     'thor',     '~> 0.19'

  gem.add_development_dependency 'rspec',    '~> 3.0'
  gem.add_development_dependency 'rake',     '~> 10.0'
end
