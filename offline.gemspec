# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "offline/version"

Gem::Specification.new do |s|
  s.name        = "offline"
  s.version     = Offline::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Luke Chadwick"]
  s.email       = ["luke.a.chadwick@gmail.com"]
  s.homepage    = "https://github.com/vertis/offline"
  s.summary     = %q{Tools for working with github}
  s.description = %q{Tools for working with github}

  s.rubyforge_project = "offline" # Not really

  s.add_dependency("httparty")
  s.add_dependency('thor')

  s.add_development_dependency('rspec')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
