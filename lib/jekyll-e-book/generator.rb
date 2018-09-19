require 'fileutils'

module JekyllEBook
  class Generator < Jekyll::Generator
    safe true
    priority :lowest

    def generate(site, book: GEPUB::Book.new)
      config = Config.new(site.config)

      return if config.skip_build?

      book.identifier                 = config.identifier
      book.title                      = config.title
      book.language                   = config.language
      book.creator                    = config.creator
      book.date                       = config.date
      book.page_progression_direction = config.page_progression_direction

      book.ordered do
        site.posts.docs.each do |post|
          original_layout     = post.data['layout']
          post.data['layout'] = config.layout || site.layouts.key?('ebook') ? 'ebook' : 'none'

          output = Jekyll::Renderer.new(site, post).run
          doc    = Nokogiri::HTML(output)

          post.data['layout'] = original_layout

          book
            .add_item("#{post['title']}.xhtml")
            .add_content(StringIO.new(doc.to_xhtml))
            .toc_text(post['title'])
        end
      end

      FileUtils.mkdir_p(config.destination)
      book.generate_epub(File.join(config.destination, config.file_name))
    end
  end
end
