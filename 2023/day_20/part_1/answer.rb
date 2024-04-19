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
        parse_input_file_and_build_module_configuration
        sum_low_pulses = 0
        sum_high_pulses = 0

        (1..1000).each do |n|
          total_low_pulses, total_high_pulses = module_configuration.push_button_module!

          sum_low_pulses += total_low_pulses
          sum_high_pulses += total_high_pulses

          puts "##{n}"
          puts "low: #{sum_low_pulses}"
          puts "high: #{sum_high_pulses}"
          puts "\n"
        end
      end

      def module_configuration
        @module_configuration ||= ModuleConfiguration.new({ button_module.name => button_module })
      end

      def button_module
        Day20::ButtonModule.new('button', ['broadcaster'])
      end

      def input_path
        File.join(File.dirname(__FILE__), '../input.txt')
      end

      def parse_input_file_and_build_module_configuration
        File.foreach(input_path) do |line|
          communication_module = Day20::ModuleConfigurationLineParser.new(line.strip).parse
          module_configuration.add_communication_module(communication_module)
        end
      end
    end
  end
end