require_relative '../line_parser'
require_relative '../arrangement_generator'

module Day12
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
        File.foreach(input_path) do |line|
          line_parser = Day12::LineParser.new(line.strip, num_of_folds: 2)
          damage_records = line_parser.damage_records
          recorded_damaged_group_sizes = line_parser.size_of_each_contiguous_group_of_damaged_springs
          arrangement_generator = Day12::ArrangementGenerator.new(damage_records, recorded_damaged_group_sizes)

          puts "#{damage_records} - #{arrangement_generator.possible_arrangements.count} arrangements"
          @sum += arrangement_generator.possible_arrangements.count
        end

        puts sum
      end

      def input_path
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
