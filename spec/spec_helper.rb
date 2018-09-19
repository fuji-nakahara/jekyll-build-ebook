require 'bundler/setup'
require 'jekyll-e-book'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  SOURCE_DIR = File.expand_path('fixtures', __dir__)
  DEST_DIR   = File.expand_path('dest', __dir__)
  EBOOK_DIR  = File.expand_path('ebook', __dir__)

  def source_dir(*files)
    File.join(SOURCE_DIR, *files)
  end

  def dest_dir(*files)
    File.join(DEST_DIR, *files)
  end

  def ebook_dir(*files)
    File.join(EBOOK_DIR, *files)
  end
end
