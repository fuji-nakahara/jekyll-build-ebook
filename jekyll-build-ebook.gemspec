
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-build-ebook/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-build-ebook'
  spec.version       = JekyllBuildEbook::VERSION
  spec.authors       = ['Fuji Nakahara']
  spec.email         = ['fujinakahara2032@gmail.com']

  spec.summary       = 'Jekyll plugin that adds command to generate ebook'
  spec.homepage      = 'https://github.com/fuji-nakahara/jekyll-build-ebook'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'jekyll', '>= 3.5', '< 5.0'

  spec.add_dependency 'gepub', '~> 1.0'
  spec.add_dependency 'kindlegen', '~> 3.0'
  spec.add_dependency 'nokogiri', '~> 1.8'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'meowcop'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
