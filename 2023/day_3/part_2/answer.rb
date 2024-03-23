require_relative '../schematic_parser'

module Day3
  module Part2
    class Answer
      def self.run
        new.run
      end

      def run
        sum =
          schematic_parser.part_numbers.inject(0) do |s, n|
            puts n.integer_value
            s += n.integer_value
            s
          end

        puts "The sum of all of the gear ratios in your engine schematic: #{sum}"
      end

      def schematic_parser
        @schematic_parser ||= Day3::SchematicParser.new(input_path)
      end

      def input_path
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
