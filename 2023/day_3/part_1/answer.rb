require_relative 'part_numbers_parser'

module Day3
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
        input_file.each_line.with_index do |line, index|
          if index == 0
            @lines << line
            next
          end

          until enough_to_parse? do
            @lines << line
            next
          end

          if enough_to_parse?
            update_sum
            puts '----------------------'

            swap_lines_and_pop_last_line
          end
        end

        if input_file.eof?
          @lines[2] = nil
          update_sum
          puts '----------------------'

        end

        puts "The sum of all of the part numbers in the engine schematic: #{sum}"
        puts "Count: #{@count}"
        input_file.close
      end

      def swap_lines_and_pop_last_line
        @lines[0] = @lines[1]
        @lines[1] = @lines[2]
        @lines.pop
      end

      def enough_to_parse?
        lines.length == 3
      end

      def parsed_result
        parser = Day3::Part1::PartNumbersParser.new(lines)
        parser.parse
        parser
      end

      def update_sum
        @count += 1
        parsed_result.part_numbers.each do |found_num|
          puts found_num
          @sum += found_num.integer_value
        end
      end

      def input_file
        @input_file ||= File.open(input_path)
      end

      def input_path
        File.join(File.dirname(__FILE__), '/input.txt')
      end
    end
  end
end
