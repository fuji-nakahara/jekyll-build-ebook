module JekyllBuildEbook
  module Filters
    def self.register
      Liquid::Template.register_filter(URLFilters)
    end

    module URLFilters
      include Jekyll::Filters::URLFilters

      def relative_url(input)
        return if input.nil?
        input = input.url if input.respond_to?(:url)
        return input if Addressable::URI.parse(input.to_s).absolute?

        page     = @context.registers[:page]
        page_dir = Pathname.new(page.url).dirname

        Pathname.new(ensure_leading_slash(input)).relative_path_from(page_dir).to_s
      end

      alias_method :absolute_url, :relative_url
    end
  end
end
