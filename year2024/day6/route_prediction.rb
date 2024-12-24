module Year2024
  module Day6
    class RoutePrediction
      UP_DIRECTION = :up
      DOWN_DIRECTION = :down
      LEFT_DIRECTION = :left
      RIGHT_DIRECTION = :right

      DIRECTION_TURNING = {
        UP_DIRECTION => RIGHT_DIRECTION,
        RIGHT_DIRECTION => DOWN_DIRECTION,
        DOWN_DIRECTION => LEFT_DIRECTION,
        LEFT_DIRECTION => UP_DIRECTION
      }.freeze

      OBSTACLE_CHAR = '#'.freeze

      attr_reader :manufacturing_lab_map

      def initialize(manufacturing_lab_map)
        @manufacturing_lab_map = manufacturing_lab_map
        @manufacturing_lab_map.scan unless @manufacturing_lab_map.scanned?
      end

      def predict
        current_guard_position = manufacturing_lab_map.current_guard_position.dup
        current_guard_direction = manufacturing_lab_map.current_guard_direction.dup

        route = []

        until out_of_mapped_area?(current_guard_position)
          route << current_guard_position.dup

          object_directly_in_front = find_object_directly_in_front(current_guard_position, current_guard_direction)
          current_guard_direction = find_next_direction(current_guard_direction, object_directly_in_front)
          current_guard_position = find_next_position(current_guard_position, current_guard_direction)
        end

        route
      end

      def obstacle?(obj)
        obj == OBSTACLE_CHAR
      end

      def out_of_mapped_area?(position)
        manufacturing_lab_map.two_d_map[position[0]].nil? ||
          manufacturing_lab_map.two_d_map[position[0]][position[1]].nil?
      end

      def find_next_direction(current_direction, object_in_front)
        if obstacle?(object_in_front)
          case current_direction
          when UP_DIRECTION, DOWN_DIRECTION, LEFT_DIRECTION, RIGHT_DIRECTION
            DIRECTION_TURNING[current_direction]
          else
            raise ArgumentError, "Invalid direction #{direction}"
          end
        else
          current_direction
        end
      end

      def find_next_position(current_position, direction)
        return [current_position[0] - 1, current_position[1]] if direction == UP_DIRECTION
        return [current_position[0] + 1, current_position[1]] if direction == DOWN_DIRECTION
        return [current_position[0], current_position[1] + 1] if direction == RIGHT_DIRECTION
        return [current_position[0], current_position[1] - 1] if direction == LEFT_DIRECTION

        raise ArgumentError, "Invalid direction #{direction}"
      end

      def find_object_directly_in_front(current_position, current_direction)
        position_directly_in_front = find_next_position(current_position, current_direction)
        return nil if manufacturing_lab_map.two_d_map[position_directly_in_front[0]].nil?

        manufacturing_lab_map.two_d_map[position_directly_in_front[0]][position_directly_in_front[1]]
      end
    end
  end
end
