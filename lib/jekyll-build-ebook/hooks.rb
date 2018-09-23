module JekyllBuildEbook
  module Hooks
    def self.register
      overwrite_post_data
    end

    def self.overwrite_post_data
      Jekyll::Hooks.register :posts, :pre_render do |post, _payload|
        layout    = post.site.config['ebook']['layout']
        permalink = "#{post.cleaned_relative_path}.xhtml"

        post.merge_data!(
          'layout'    => post.site.layouts.key?(layout) ? layout : 'none',
          'permalink' => permalink,
        )
      end
    end
  end
end
