module Year2022
  module Day9
    class Knot
      attr_reader :line_index, :char_index, :name
      attr_accessor :prev_knot, :next_knot

      def initialize(char_index, line_index, name, prev_knot = nil, next_knot = nil)
        @char_index = char_index
        @line_index = line_index
        @name = name
        @prev_knot = prev_knot
        @next_knot = next_knot
      end

      def location
        [char_index, line_index]
      end

      def location=(l)
        @char_index, @line_index = l
      end

      def to_s
        name.to_s
      end

      def next_location_to_follow_head_knot(head_knot)
        if overlapping_with_another_knot?(head_knot)
          location
        else
          next_location_based_on_distances(head_knot)
        end
      end

      def overlapping_with_another_knot?(another_knot)
        char_index == another_knot.char_index && line_index == another_knot.line_index
      end

      def horizontal_distance_to_another_knot(another_knot)
        (char_index - another_knot.char_index).abs
      end

      def vertical_distance_to_another_knot(another_knot)
        (line_index - another_knot.line_index).abs
      end

      def next_location_by_direction(direction)
        case direction
        when 'U'
          [char_index, line_index + 1]
        when 'D'
          [char_index, line_index - 1]
        when 'R'
          [char_index + 1, line_index]
        when 'L'
          [char_index - 1, line_index]
        else
          raise ArgumentError, "Invalid direction: #{direction}"
        end
      end

      private

      def next_location_based_on_distances(head_knot)
        horizontal_distance = horizontal_distance_to_another_knot(head_knot)
        vertical_distance = vertical_distance_to_another_knot(head_knot)

        case
        when horizontal_distance > vertical_distance
          [
            adjust_index(head_knot.char_index, char_index),
            head_knot.line_index
          ]
        when horizontal_distance < vertical_distance
          [
            head_knot.char_index,
            adjust_index(head_knot.line_index, line_index)
          ]
        when horizontal_distance == 2 && vertical_distance == 2
          [
            adjust_index(head_knot.char_index, char_index),
            adjust_index(head_knot.line_index, line_index)
          ]
        when horizontal_distance == 1 && vertical_distance == 1
          location
        else
          raise ArgumentError, 'Invalid head location'
        end
      end

      def adjust_index(head_index, current_index)
        head_index > current_index ? head_index - 1 : head_index + 1
      end
    end
  end
end
