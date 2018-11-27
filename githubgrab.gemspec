
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "githubgrab/version"

Gem::Specification.new do |spec|
  spec.name          = "githubgrab"
  spec.version       = Githubgrab::VERSION
  spec.authors       = ["sizief"]
  spec.email         = ["sizief@gmail.com"]

  spec.summary       = "This is a very simple CLI to download Github profile images"
  spec.homepage      = "http://github.com/sizief/gig"
  spec.license       = "MIT"


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  #spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
  #  `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  #end

  spec.files = Dir['lib/*.rb'] + Dir['bin/*']
  spec.files += Dir['[A-Z]*'] + Dir['test/**/*']
  spec.files.reject!{ |fn| fn.include? "CVS" }
  
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "rest-client"
  spec.add_development_dependency "colorize"
  spec.add_development_dependency "thread"
end