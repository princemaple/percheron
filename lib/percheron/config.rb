require 'yaml'

module Percheron
  class Config

    def initialize(file)
      @file = Pathname.new(file).expand_path
      valid?
    end

    def settings
      Hashie::Mash.new(YAML.load_file(file))
    end

    def stacks
      settings.stacks.inject({}) do |all, stack_config|
        all[stack_config.name] = stack_config unless all[stack_config.name]
        all
      end
    end

    def file_base_path
      file.dirname
    end

    def valid?
      Validators::Config.new(file).valid?
    end

    private

      attr_reader :file

  end
end
