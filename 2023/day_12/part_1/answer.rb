require_relative '../line_parser'

module Day12
  module Part1
    class Answer
      attr_reader :sum, :lines

      def initialize
        @sum = 0
        @count = 0
        @lines = [nil]
      end

      def self.run
        new.run
      end

      def run
        File.foreach(input_path) do |line|
          line_parser = Day12::LineParser.new(line.strip)
          puts line
          puts line_parser.size_of_each_contiguous_group_of_damaged_springs.join(', ')
        end
      end

      def input_path
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
