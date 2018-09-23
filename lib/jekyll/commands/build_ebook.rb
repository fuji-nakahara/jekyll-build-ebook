module Jekyll
  module Commands
    class BuildEbook < Command
      # Create the Mercenary command for the Jekyll CLI for this Command
      def self.init_with_program(prog)
        prog.command(:'build-ebook') do |c|
          c.syntax 'build-ebook [options]'
          c.description 'Build your ebook'
          c.alias :be

          c.option 'config', '--config CONFIG_FILE[,CONFIG_FILE2,...]', Array, 'Custom configuration file'
          c.option 'destination', '-d', '--destination DESTINATION', 'The current folder will be generated into DESTINATION'
          c.option 'source', '-s', '--source SOURCE', 'Custom source directory'
          c.option 'future', '--future', 'Publishes posts with a future date'
          c.option 'limit_posts', '--limit_posts MAX_POSTS', Integer, 'Limits the number of posts to parse and publish'
          c.option 'show_drafts', '-D', '--drafts', 'Render posts in the _drafts folder'
          c.option 'unpublished', '--unpublished', 'Render posts that were marked as unpublished'
          c.option 'quiet', '-q', '--quiet', 'Silence output.'
          c.option 'verbose', '-V', '--verbose', 'Print verbose output.'

          c.action do |_args, options|
            process(options)
          end
        end
      end

      def self.process(options)
        # Adjust verbosity quickly
        Jekyll.logger.adjust_verbosity(options)

        JekyllBuildEbook::Hooks.register
        JekyllBuildEbook::Filters.register

        options = Jekyll::Utils.deep_merge_hashes(JekyllBuildEbook::Config::DEFAULTS, options)
        config  = configuration_from_options(options)
        site    = Jekyll::Site.new(config)

        build(site, config)
      end

      def self.build(site, config, generator: JekyllBuildEbook::Generator.new)
        t           = Time.now
        source      = config['source']
        destination = config['ebook']['destination']

        Jekyll.logger.info 'Source:', source
        Jekyll.logger.info 'Destination:', destination
        Jekyll.logger.info 'Generating...'

        site.reset
        site.read
        generator.generate(site)

        Jekyll.logger.info '', "done in #{(Time.now - t).round(3)} seconds."
      end
    end
  end
end
