require "./lib/nonono/version"

Gem::Specification.new do |gem|
  gem.name          = "nonono"
  gem.authors       = ["Connor Atherton"]
  gem.email         = "c.liam.atherton@gmail.com"
  gem.summary       = "Handy git undo advice."
  gem.description   = "A CLI for undoing git actions."
  gem.homepage      = "http://github.com/ConnorAtherton/nonono"
  gem.license       = "MIT"

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
end
