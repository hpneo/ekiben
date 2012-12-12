# encoding: UTF-8
# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "ekiben/version"

Gem::Specification.new do |gem|
  gem.name          = "ekiben"
  gem.require_paths = ["lib"]
  gem.authors       = ["Alvaro Pereyra", "Gustavo Leon"]
  gem.email         = ["alvaro@xenda.pe", "gustavo@xenda.pe"]
  gem.description   = "Store management modules"

  gem.platform      = Gem::Platform::RUBY
  gem.version       = Ekiben::VERSION

  gem.files         = `git ls-files`.split("\n").sort
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
end