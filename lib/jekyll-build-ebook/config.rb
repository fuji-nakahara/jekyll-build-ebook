module JekyllBuildEbook
  class Config
    DEFAULTS = {
      'ebook' => {
        'destination' => File.join(Dir.pwd, '_ebook'),
        'layout'      => 'ebook',
      },
    }.freeze

    REQUIRED_FIELDS = %w[identifier title language].freeze

    attr_reader :data

    def initialize(site_config)
      @data = {
        'file_name'  => site_config['title'],
        'identifier' => site_config['url'].nil? ? SecureRandom.uuid : "#{site_config['url']}#{site_config['base_url']}",
        'title'      => site_config['title'],
        'language'   => site_config['language'] || site_config['lang'],
        'creator'    => case site_config['author']
                        when String
                          site_config['author']
                        when Hash
                          site_config['author']['name']
                        else
                          nil
                        end,
      }.merge(site_config['ebook'])

      REQUIRED_FIELDS.each do |field|
        raise InvalidConfigError, "#{field} is required" if data[field].nil?
      end
    end

    def [](key)
      data[key]
    end

    def destination_path(ext: 'epub')
      "#{File.join(data['destination'], data['file_name'])}.#{ext}"
    end
  end
end
