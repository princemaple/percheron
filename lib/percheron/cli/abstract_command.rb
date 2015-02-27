module Percheron
  module CLI
    class AbstractCommand < Clamp::Command

      option [ '-c', '--config_file' ], 'CONFIG', 'Configuration file', default: '.percheron.yml'

      option '--version', :flag, 'show version' do
        puts Percheron::VERSION
        exit(0)
      end

      def config
        @config ||= Percheron::Config.new(config_file)
      rescue Errors::ConfigFileInvalid => e
        $logger.error "An error has occurred - #{e.message}"
      end
    end
  end
end
