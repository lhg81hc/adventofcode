module Year2022
  module Day9
    module StepUtils
      def move(direction)
        head.location = next_head_location(direction)
        tail.location = head.last_location unless two_ends_touching?
      end

      def current_head_location
        head.location
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
