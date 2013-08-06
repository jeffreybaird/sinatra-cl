# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra-cl/version'

Gem::Specification.new do |gem|
  gem.name          = "sinatra-cl"
  gem.version       = Sinatra::Cl::VERSION
  gem.authors       = ["jeffreybaird"]
  gem.email         = ["jlbaird87@gmail.com"]
  gem.description   = "This uses Ashley William's ratpack setup to scaffold a sinatra app"
  gem.summary       = "This is a test"
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
