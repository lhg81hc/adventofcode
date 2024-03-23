require_relative 'part_numbers_parser'

module Day3
  module Part1
    class Answer
      def initialize
        @count = 0
      end

      def self.run
        new.run
      end

      def run
        triplet = [nil]
        last_line_idx = lines.length - 1

        lines.each.with_index do |line, line_idx|
          triplet << line
          next if triplet.length != 3

          @count += sum_of_part_numbers(triplet)
          triplet.shift

          next unless line_idx == last_line_idx

          triplet << nil
          @count += sum_of_part_numbers(triplet)
        end

        puts "The sum of all of the gear ratios in your engine schematic: #{@count}"
      end

      def sum_of_part_numbers(triplet)
        parser = Day3::Part1::PartNumbersParser.new(triplet)
        parser.part_numbers.map(&:integer_value).sum
      end

      def lines
        @lines ||=
          begin
            File.open(input_path).inject([]) do |r, line|
              r << line.strip
              r
            end
          end
      end

      def input_path
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
