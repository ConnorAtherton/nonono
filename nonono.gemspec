require "./lib/nonono/version"

Gem::Specification.new do |gem|
  gem.name          = "nonono"
  gem.authors       = ["Connor Atherton"]
  gem.email         = "c.liam.atherton@gmail.com"
  gem.summary       = "Handy git undo advice."
  gem.description   = "A CLI for undoing git actions."
  gem.homepage      = "http://github.com/ConnorAtherton/nonono"
  gem.license       = "MIT"
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  gem.files = Dir.glob("lib/**/*") + [
    "README.md",
    "Rakefile",
    "Gemfile",
    "nonono.gemspec",
  ]
  gem.test_files    = Dir.glob("test/**/*")

  gem.version       = Nonono::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.7"
  gem.add_development_dependency "rake", "~> 10.0"
  gem.add_development_dependency("rspec", "~> 2.14")
end
