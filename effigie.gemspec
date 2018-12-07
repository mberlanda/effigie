lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "effigie/version"

Gem::Specification.new do |spec|
  spec.name          = "effigie"
  spec.version       = Effigie::VERSION
  spec.authors       = ["Mauro Berlanda"]
  spec.email         = ["mauro.berlanda@gmail.com"]

  spec.summary       = %q{Simple utility to render ERB templates from hash, objects or self.}
  spec.description   = %q{Utility to render ERB templates out of hash maps, objects or self using ruby standard library}
  spec.homepage      = "https://www.github.com/mberlanda/effigie"
  spec.license       = "MIT"

  spec.files         = Dir.glob("#{lib}/**/*.rb") + ["README.md"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
