module Year2022
  module Day10
    class CathodeRayTubeScreen
      WIDTH = 40
      HEIGHT = 6

      attr_reader :pixel_map
      attr_accessor :sprite_pixel_horizontal_positions

      def initialize
        setup
      end

      def reset
        setup
      end

      def print
        @pixel_map.each { |row| puts row.join }
      end

      def cycle_to_line_index(cycle)
        (cycle - 1) / WIDTH
      end

      def cycle_to_char_index(cycle)
        (cycle - 1) % WIDTH
      end

      def draw(cycle_ordinal_number)
        char_index = cycle_to_char_index(cycle_ordinal_number)
        line_index = cycle_to_line_index(cycle_ordinal_number)

        if ([char_index] & @sprite_pixel_horizontal_positions).any?
          @pixel_map[line_index][char_index] = '#'
        else
          @pixel_map[line_index][char_index] = '.'
        end
      end

      def update_sprite_position(instruction)
        @sprite_pixel_horizontal_positions =
          @sprite_pixel_horizontal_positions.map { |h| h + instruction.value }
      end

      def setup
        @pixel_map = Array.new(HEIGHT) { Array.new(WIDTH, '.') }
        @sprite_pixel_horizontal_positions = [0, 1, 2]
      end
    end
  end
end
