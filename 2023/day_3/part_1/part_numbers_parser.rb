module Day3
  module Part1
    class PartNumbersParser
      NUMBER_CHARS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].freeze

      attr_reader :lines

      ParsedNumber = Struct.new(:chars, :integer_value, :start_index, :length_of_chars, :surrounding_chars)

      def initialize(lines)
        @lines = lines
      end

      def numbers
        @numbers ||=
          begin
            number_chars = []

            curr_line.each_char.with_index.inject([]) do |r, (char, idx)|
              if NUMBER_CHARS.include?(char)
                number_chars << char
              else
                length = number_chars.length
                unless length.zero?
                  parsed_number =
                    ParsedNumber.new(
                      number_chars.dup,
                      number_chars.join.to_i,
                      idx - length,
                      number_chars.length,
                      surrounding_chars(idx - length, number_chars.length)
                    )

                  r << parsed_number
                  number_chars.clear
                end
              end

              r
            end
          end
      end

      def part_numbers
        @part_numbers ||=
          numbers.select { |number| number.surrounding_chars.values.flatten.any? { |c| !c.nil? && c != '.' } }
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
        (0 .. (length - 1)).each.inject([]) do |r, idx|
          r << prev_line[start_index + idx]
          r
        end
      end

      def bottom_surrounding_chars(start_index, length)
        return Array.new(length, nil) if next_line.nil?

        # Left to right
        (0 .. (length - 1)).each.inject([]) do |r, idx|
          r << next_line[start_index + idx]
          r
        end
      end

      def prev_line
        lines[0]
      end

      def curr_line
        lines[1]
      end

      def next_line
        lines[2]
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
