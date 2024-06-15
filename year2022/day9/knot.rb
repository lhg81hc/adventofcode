module Year2022
  module Day9
    class Knot
      attr_reader :line_index, :char_index, :ordinal_number

      def initialize(char_index, line_index, ordinal_number)
        @char_index = char_index
        @line_index = line_index
        @ordinal_number = ordinal_number
      end

      def last_location
        @last_location
      end

      def location
        [char_index, line_index]
      end

      def location=(l)
        @last_location = location.dup
        @char_index, @line_index = l
      end

      def to_s
        ordinal_number.to_s
      end

      def distance_to_another(another_knot)
        return 0 if overlapping_with_another?(another_knot)

        horizontal_distance = horizontal_distance_to_another(another_knot)
        vertical_distance = vertical_distance_to_another(another_knot)

        horizontal_distance > vertical_distance ? horizontal_distance : vertical_distance
      end

      def overlapping_with_another?(another_knot)
        char_index == another_knot.char_index && line_index == another_knot.line_index
      end

      def touching_another?(another_knot)
        distance_to_another(another_knot) <= 1
      end

      def horizontal_distance_to_another(another_knot)
        (char_index - another_knot.char_index).abs
      end

      def vertical_distance_to_another(another_knot)
        (line_index - another_knot.line_index).abs
      end
    end
  end
end
