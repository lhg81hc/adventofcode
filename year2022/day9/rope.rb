# require_relative 'step_utils'

module Year2022
  module Day9
    class Rope
      attr_reader :knots

      def initialize(knots)
        @knots = knots
      end

      def head
        @knots[0]
      end

      def tail
        @knots[-1]
      end

      def current_head_location
        head.location
      end

      def move(direction)
        prev_knot = nil

        knots.each do |knot|
          if prev_knot.nil?
            knot.location = next_head_location(direction).dup
          else
            if prev_knot.touching_another?(knot)
              break
            else
              knot.location = prev_knot.last_location.dup
            end
          end

          prev_knot = knot
        end
      end

      def next_head_location(direction)
        case direction
        when 'U'
          [current_head_location[0], current_head_location[1] + 1]
        when 'D'
          [current_head_location[0], current_head_location[1] - 1]
        when 'R'
          [current_head_location[0] + 1, current_head_location[1]]
        when 'L'
          [current_head_location[0] - 1, current_head_location[1]]
        else
          raise ArgumentError, "Invalid direction: #{direction}"
        end
      end
    end
  end
end
