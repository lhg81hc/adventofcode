module Day20
  class ModuleConfiguration
    attr_reader :communication_modules

    def initialize(communication_modules = {})
      @communication_modules = communication_modules
    end

    def add_communication_module(communication_module)
      @communication_modules[communication_module.name] ||= communication_module
    end
  end
end
