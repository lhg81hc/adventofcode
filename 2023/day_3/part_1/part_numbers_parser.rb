module Day3
  module Part1
    class PartNumbersParser
      NUMBER_CHARS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].freeze

      attr_reader :lines, :numbers

      ParsedNumber = Struct.new(:chars, :integer_value, :start_index, :length_of_chars, :surrounding_chars)

      def initialize(lines)
        @lines = lines
        @numbers = []
      end

      def prev_line
        @prev_line ||= lines[0]
      end

      def curr_line
        @curr_line ||= lines[1]
      end

      def next_line
        @next_line ||= lines[2]
      end

      def part_numbers
        @part_numbers ||=
          numbers.select do |parsed_number|
            parsed_number.surrounding_chars.values.flatten.any? { |c| !c.nil? && c != '.' }
            # parsed_number.surrounding_chars.values.flatten.any? { |c| NUMBER_CHARS.include?(c) }
          end
      end

      def parse
        number_chars = []

        curr_line.each_char.with_index do |char, idx|
          if NUMBER_CHARS.include?(char)
            number_chars << char
          else
            length = number_chars.length
            if !length.zero?
              process_number_chars(number_chars, idx - length)
              number_chars.clear
            else
              next
            end
          end
        end
      end

      def process_number_chars(number_chars, start_index)
        @numbers <<
          ParsedNumber.new(
            number_chars.dup,
            number_chars.join.to_i,
            start_index,
            number_chars.length,
            surrounding_chars(start_index, number_chars.length)
          )
      end

      def surrounding_chars(start_index, length)
        {
          left_surrounding_chars: left_surrounding_chars(start_index),
          top_surrounding_chars: right_surrounding_chars(start_index, length),
          right_surrounding_chars: top_surrounding_chars(start_index, length),
          bottom_surrounding_chars: bottom_surrounding_chars(start_index, length)
        }
      end

      def left_surrounding_chars(start_index)
        return Array.new(3, nil) if start_index == 0

        # Top to bottom
        [
          first_line? ? nil : prev_line[start_index - 1],
          curr_line[start_index - 1],
          last_line? ? nil : next_line[start_index - 1]
        ]
      end

      def right_surrounding_chars(start_index, length)
        return Array.new(3, nil) if start_index + length >= curr_line.length

        # Top to bottom
        [
          first_line? ? nil : prev_line[start_index + length],
          curr_line[start_index + length],
          last_line? ? nil : next_line[start_index + length]
        ]
      end

      def top_surrounding_chars(start_index, length)
        return Array.new(length, nil) if prev_line.nil?

        # Left to right
        r = []
        for idx in (0 .. (length - 1)) do
          r << prev_line[start_index + idx]
        end

        r
      end

      def bottom_surrounding_chars(start_index, length)
        return Array.new(length, nil) if next_line.nil?

        # Left to right
        r = []
        for idx in (0 .. (length - 1)) do
          r << next_line[start_index + idx]
        end

        r
      end

      def first_line?
        prev_line.nil?
      end

      def last_line?
        next_line.nil?
      end
    end
  end
end
