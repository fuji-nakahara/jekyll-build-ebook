module JekyllBuildEbook
  class Generator
    def generate(site)
      config = Config.new(site.config)

      FileUtils.mkdir_p(config['destination'])

      generate_epub(site, config)
      generate_kindle(config) if config['kindle']
    end

    private

    def generate_epub(site, config, book: GEPUB::Book.new)
      book.date                       = config['date'] || site.time
      book.identifier                 = config['identifier']
      book.title                      = config['title']
      book.language                   = config['language']
      book.creator                    = config['creator']
      book.page_progression_direction = config['page_progression_direction']

      site.static_files.each do |static_file|
        href = remove_head_slash(File.join(static_file.destination_rel_dir, static_file.name))
        File.open(static_file.path) do |io|
          book.add_item(href, content: io)
        end
      end

      book.ordered do
        site.posts.docs.each do |post|
          post.output = Jekyll::Renderer.new(site, post).run

          book
            .add_item(remove_head_slash(post.url))
            .add_content(StringIO.new(Nokogiri::HTML(post.output).to_xhtml))
            .toc_text(post['title'])
        end
      end

      book.generate_epub(config.destination_path)
    end

    def generate_kindle(config, logger: Jekyll.logger)
      stdout, stderr, _status = Kindlegen.run(config.destination_path, '-o', "#{config['file_name']}.mobi")

      logger.debug('Kindlegen:', stdout) unless stdout.empty?
      logger.error('Kindlegen:', stderr) unless stderr.empty?
    end

    def remove_head_slash(str)
      str.sub(%r{\A/}, '')
    end
  end
end
