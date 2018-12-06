
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "effigie/version"

Gem::Specification.new do |spec|
  spec.name          = "effigie"
  spec.version       = Effigie::VERSION
  spec.authors       = ["Mauro Berlanda"]
  spec.email         = ["mauro.berlanda@gmail.com"]

  spec.summary       = %q{Simple utility to render ERB templates from hash}
  spec.description   = %q{Utility to render ERB templates out of hash maps using ruby standard library}
  spec.homepage      = "https://www.github.com/mberlanda/effigie"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
