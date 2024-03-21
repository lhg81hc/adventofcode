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

          @count += parse_triplet_and_get_sum(triplet)
          triplet.shift

          next unless line_idx == last_line_idx

          triplet << nil
          @count += parse_triplet_and_get_sum(triplet)
        end

        puts "COUNT: #{@count}"
      end

      def parse_triplet_and_get_sum(triplet)
        parser = Day3::Part1::PartNumbersParser.new(triplet)
        numbers = parser.numbers.map(&:integer_value)
        part_numbers = parser.part_numbers.map(&:integer_value)

        puts "numbers: [#{numbers.join(' ')}]"
        puts "part numbers: [#{part_numbers.join(' ')}]"
        puts "\n"

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
        File.join(File.dirname(__FILE__), '/input.txt')
      end
    end
  end
end
