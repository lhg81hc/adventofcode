require_relative '../schematic_parser'

module Day3
  module Part2
    class Answer
      def self.run
        new.run
      end

      def run
        sum =
          schematic_parser.star_symbols_map.inject(0) do |s, (_k, v)|
            s += v.map { |part_number| part_number.integer_value }.inject(:*) if v.length == 2
            s
          end

        puts "The sum of all of the gear ratios in my engine schematic: #{sum}"
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
