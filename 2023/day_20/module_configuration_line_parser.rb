require_relative 'broadcast_module'
require_relative 'conjunction_module'
require_relative 'flip_flop_module'

module Day20
  class ModuleConfigurationLineParser
    PREFIXES = %w[% &]

    attr_reader :line

    def initialize(line)
      @line = line
    end

    def module_prefix
      first_char = line[0]

      if PREFIXES.include?(first_char)
        first_char
      else
        nil
      end
    end

    def module_name
      remaining = module_prefix.nil? ? line : line[1..-1]
      remaining.split(' -> ').first
    end

    def dest_modules_names
      line.split(' -> ')[1].split(', ')
    end

    def parse
      if module_prefix
        if module_prefix == '%'
          return Day20::FlipFlopModule.new(module_name, dest_modules_names)
        end

        if module_prefix == '&'
          return Day20::ConjunctionModule.new(module_name, dest_modules_names)
        end
      else
        if module_name == 'broadcaster'
          return Day20::BroadcastModule.new(module_name, dest_modules_names)
        end
      end

      raise 'Invalid module prefix and module name'
    end
  end
end
