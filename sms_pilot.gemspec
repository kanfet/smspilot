# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sms_pilot/version"

Gem::Specification.new do |s|
  s.name        = "sms_pilot"
  s.version     = SmsPilot::VERSION
  s.authors     = ["Pavel Nemkin"]
  s.email       = ["byte.developer@gmail.com"]
  s.homepage    = "https://github.com/kanfet/smspilot"
  s.summary     = "Wrapper for smspilot.ru API"
  s.description = "Wrapper for smspilot.ru API"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", ["~> 2.11.0"]
  s.add_development_dependency "guard-rspec", ["~> 1.2.1"]
end
