module Day18
  module Part2
    class Digger
      attr_reader :lines

      def initialize(lines)
        @lines = lines
      end

      def dig(start_x, start_y)
        last_y = start_x
        last_x = start_y

        lines.map do |line|
          direction, num_of_meters = line_parser(line)

          trench = dig_by_direction(last_x, last_y, direction, num_of_meters)
          last_x, last_y = trench[-1]

          trench
        end
      end

      private

      def hexadecimal_codes_from_line(line)
        parts = line.split
        color = parts[2]
        hexadecimal_codes = color.scan(/\w{6}/).first
        raise "Hexadecial codes are not found" unless hexadecimal_codes

        hexadecimal_codes
      end

      def line_parser(line)
        hexadecimal_codes = hexadecimal_codes_from_line(line)
        encoded_distance = hexadecimal_codes[0..4]
        encoded_direction = hexadecimal_codes[-1]

        direction = decode_direction(encoded_direction)
        num_of_meters = encoded_distance.to_i(16)

        [direction, num_of_meters]
      end

      def decode_direction(encoded_direction)
        case encoded_direction
        when '0'
          'R'
        when '1'
          'D'
        when '2'
          'L'
        when '3'
          'U'
        else
          raise "Invalid encoded_distance #{encoded_direction}"
        end
      end

      def dig_by_direction(start_position_x, start_position_y, direction, num_of_meters)
        case direction
        when 'R'
          [
            [start_position_x + 1, start_position_y],
            [start_position_x + num_of_meters, start_position_y]
          ]
        when 'L'
          [
            [start_position_x - 1, start_position_y],
            [start_position_x - num_of_meters, start_position_y]
          ]
        when 'U'
          [
            [start_position_x, start_position_y - 1],
            [start_position_x, start_position_y - num_of_meters]
          ]
        when 'D'
          [
            [start_position_x, start_position_y + 1],
            [start_position_x, start_position_y + num_of_meters]
          ]
        else
          raise "Invalid direction #{direction}"
        end
      end
    end
  end
end
