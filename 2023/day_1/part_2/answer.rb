require_relative 'line_parser'

module Day1
  module Part2
    class Answer
      attr_reader :sum

      def initialize
        @sum = 0
      end

      def self.run
        new.run
      end

      def run
        File.open(input_path).each do |line|
          parser = Day1::Part2::LineParser.new(line)
          @sum += parser.calibration_value

          puts parser.output
        end

        puts "\n\n"
        puts "The sum of all of the calibration values: #{sum}"
      end

      def input_path
        File.join(File.dirname(__FILE__), '/input.txt')
      end
    end
  end
end
