# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "slugoid/version"

Gem::Specification.new do |s|
  s.name        = "slugoid"
  s.version     = Acts::Slugoid::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["David Padilla", "Emmanuel Delgado"]
  s.email       = ["david@crowdint.com", "emmanuel@crowdint.com"]
  s.homepage    = "http://rubygems.org/gems/slugoid"
  s.summary     = %q{Drop-in solution to pretty urls when using Mongoid}
  s.description = %q{Drop-in solution to pretty urls when using Mongoid}

  s.add_dependency('mongoid', '>= 2.0.0.beta.17')
  s.add_development_dependency('shoulda', '~>2.11.3')
  s.add_development_dependency('bson_ext', '~>1.2.4')

  s.rubyforge_project = "slugoid"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
