require_relative '../button_module'
require_relative '../module_configuration'
require_relative '../module_configuration_line_parser'

module Day20
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        module_configuration = build_module_configuration
        total_low_pulses, total_high_pulses = module_configuration.push_button_module(1000)

        puts "Total low pulses: #{total_low_pulses}"
        puts "Total high pulses: #{total_high_pulses}"
      end

      def button_module
        Day20::ButtonModule.new('button', ['broadcaster'])
      end

      def input_path
        File.join(File.dirname(__FILE__), '../input.txt')
      end

      def build_module_configuration
        configuration = ModuleConfiguration.new({ button_module.name => button_module })

        File.foreach(input_path) do |line|
          communication_module = Day20::ModuleConfigurationLineParser.new(line.strip).parse
          configuration.add_communication_module(communication_module)
        end

        configuration
      end
    end
  end
end