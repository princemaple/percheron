module Percheron
  class Stack

    extend Forwardable

    def_delegators :stack_config, :name, :description

    def initialize(config, stack_name)
      @config = config
      @stack_name = stack_name
      valid?
    end

    def self.all(config)
      all = {}
      config.stacks.each do |stack_name, _|
        stack = new(config, stack_name)
        all[stack.name] = stack
      end
      all
    end

    def valid?
      Validators::Stack.new(self).valid?
    end

    def container_configs
      stack_config.container_configs.inject({}) do |all, container_config|
        container_config = ContainerConfig.new(config, container_config)
        all[container_config.name] = container_config unless all[container_config.name]
        all
      end
    end

    private

      attr_reader :config, :stack_name

      def stack_config
        @stack_config ||= config.stacks[stack_name] || Hashie::Mash.new({})
      end
  end
end
