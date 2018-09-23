module Jekyll
  module Commands
    class BuildEbook < Command
      # Create the Mercenary command for the Jekyll CLI for this Command
      def self.init_with_program(prog)
        prog.command(:'build-ebook') do |c|
          c.syntax 'build-ebook'
          c.description 'Build your ebook'
          c.alias :be

          c.action do |_args, options|
            process(options)
          end
        end
      end

      def self.process(options)
        # Adjust verbosity quickly
        Jekyll.logger.adjust_verbosity(options)

        JekyllBuildEbook::Hooks.register

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
