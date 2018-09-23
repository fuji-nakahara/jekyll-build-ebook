module JekyllBuildEbook
  class Generator
    def generate(site, book: GEPUB::Book.new)
      config = Config.new(site.config)

      book.date                       = config['date'] || site.time
      book.identifier                 = config['identifier']
      book.title                      = config['title']
      book.language                   = config['language']
      book.creator                    = config['creator']
      book.page_progression_direction = config['page_progression_direction']

      site.static_files.each do |static_file|
        File.open(static_file.path) do |io|
          book.add_item(File.join(static_file.destination_rel_dir, static_file.name), io)
        end
      end

      book.ordered do
        site.posts.docs.each do |post|
          post.output = Jekyll::Renderer.new(site, post).run

          book
            .add_item(post.url)
            .add_content(StringIO.new(Nokogiri::HTML(post.output).to_xhtml))
            .toc_text(post['title'])
        end
      end

      FileUtils.mkdir_p(config['destination'])
      book.generate_epub("#{File.join(config['destination'], config['file_name'])}.epub")
    end
  end
end
