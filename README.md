# jekyll-e-book

Jekyll plugin to generate an EPUB file including your Jekyll posts.

## Installation

Add this line to your site's Gemfile:

```ruby
gem 'jekyll-e-book'
```

And then add the following to your site's `_config.yml`:

```yaml
plugins:
  - jekyll-e-book
```

## Usage

This plugin will automatically generate an EPUB file at `_ebook/#{file_name}.epub`.

You can also edit the build settings and the EPUB metadata in `_config.yml`:

```yaml
ebook:
  # Build settings
  build: true
  layout: ebook 
  destination: _ebook
  file_name: My book
  # EPUB metadata
  identifier: http://example.com
  title: Your book title
  language: ja_JP
  creator: Your name
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fuji-nakahara/jekyll-e-book. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JekyllEBook project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/jekyll-e-book/blob/master/CODE_OF_CONDUCT.md).
