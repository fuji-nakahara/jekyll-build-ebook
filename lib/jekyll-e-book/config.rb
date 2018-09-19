require 'securerandom'

module JekyllEBook
  InvalidConfigError = Class.new(StandardError)

  class Config
    def initialize(config)
      @config = config
    end

    def skip_build?
      ebook['build'] == 'false'
    end

    def layout
      ebook['layout']
    end

    def destination
      File.expand_path(ebook['destination'] || '_ebook')
    end

    def file_name
      "#{ebook['file_name'] || title}.epub"
    end

    def identifier
      ebook['identifier'] || site['url'].nil? ? nil : "#{site['url']}#{site['base_url']}" || SecureRandom.uuid
    end

    def title
      ebook['title'] || site['title'] or raise InvalidConfigError, 'Title is required'
    end

    def language
      ebook['language'] || site['language'] || site['lang'] or raise InvalidConfigError, 'Language is required'
    end

    def date
      ebook['date'] || Time.now
    end

    def creator
      case
      when !ebook['creator'].nil?
        ebook['creator']
      when site['author'].is_a?(String)
        site['author']
      when site['author'].is_a?(Hash) && !site['author']['name'].nil?
        site['author']['name']
      else
        nil
      end
    end

    def page_progression_direction
      ebook['page_progression_direction']
    end

    private

    def site
      @config
    end

    def ebook
      @config['ebook'] || {}
    end
  end
end
