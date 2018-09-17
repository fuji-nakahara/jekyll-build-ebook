
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "jekyll/e/book/version"

Gem::Specification.new do |spec|
  spec.name          = "jekyll-e-book"
  spec.version       = Jekyll::E::Book::VERSION
  spec.authors       = ["Fuji Nakahara"]
  spec.email         = ["fujinakahara2032@gmail.com"]

  spec.summary       = 'E-book generator for Jekyll'
  spec.homepage      = 'https://github.com/fuji-nakahara/jekyll-e-book'
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
