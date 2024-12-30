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

      Prediction = Struct.new(:route, :visited_positions, :loop_found)

      attr_reader :two_d_map, :starting_position, :starting_direction

      def initialize(two_d_map, starting_position, starting_direction)
        @two_d_map = two_d_map
        @starting_position = starting_position
        @starting_direction = starting_direction
        @history = {}
      end

      def predict
        current_guard_position = starting_position.dup
        current_guard_direction = starting_direction.dup

        route = []
        memoize_positions = {}
        memoize_positions_and_directions = {}
        visited_positions = []
        loop_found = false

        until out_of_mapped_area?(current_guard_position) || loop_found
          current_guard_position_dup = current_guard_position.dup
          route << { position: current_guard_position_dup, direction: current_guard_direction.dup }

          position_str = current_guard_position_dup.join(',')
          position_and_direction_str = "#{position_str},#{current_guard_direction}"

          if memoize_positions[position_str].nil?
            memoize_positions[position_str] = true
            visited_positions << current_guard_position_dup
          end

          if memoize_positions_and_directions[position_and_direction_str].nil?
            memoize_positions_and_directions[position_and_direction_str] = true
          else
            loop_found = true
          end

          next_position_and_direction = get_next_position_and_direction(current_guard_position, current_guard_direction)
          current_guard_position = next_position_and_direction[0]
          current_guard_direction = next_position_and_direction[1]
        end

        Prediction.new(route, visited_positions, loop_found)
      end

      def predict_after_placing_new_obstacle(new_obstacle_position)
        @two_d_map[new_obstacle_position[0]][new_obstacle_position[1]] = '#'

        current_guard_position = starting_position.dup
        current_guard_direction = starting_direction.dup

        route = []
        memoize_positions = {}
        memoize_positions_and_directions = {}
        visited_positions = []
        loop_found = false

        until out_of_mapped_area?(current_guard_position) || loop_found
          current_guard_position_dup = current_guard_position.dup
          route << { position: current_guard_position_dup, direction: current_guard_direction.dup }

          position_str = current_guard_position_dup.join(',')
          position_and_direction_str = "#{position_str},#{current_guard_direction}"

          if memoize_positions[position_str].nil?
            memoize_positions[position_str] = true
            visited_positions << current_guard_position_dup
          end

          if memoize_positions_and_directions[position_and_direction_str].nil?
            memoize_positions_and_directions[position_and_direction_str] = true
          else
            loop_found = true
          end

          if !adjacent_to_obstacle_position?(current_guard_position, new_obstacle_position)
            next_position_and_direction = @history[position_and_direction_str]

            if next_position_and_direction.nil?
              next_position_and_direction = get_next_position_and_direction(current_guard_position, current_guard_direction)
              @history[position_and_direction_str] = [next_position_and_direction[0].dup, next_position_and_direction[1].dup]
            end
          else
            next_position_and_direction = get_next_position_and_direction(current_guard_position, current_guard_direction)
          end

          current_guard_position = next_position_and_direction[0]
          current_guard_direction = next_position_and_direction[1]
        end

        @two_d_map[new_obstacle_position[0]][new_obstacle_position[1]] = '.'

        Prediction.new(route, visited_positions, loop_found)
      end

      def adjacent_to_obstacle_position?(position, obstacle_position)
        position[0] >= obstacle_position[0] - 1 && position[0] <= obstacle_position[0] + 1 &&
          position[1] >= obstacle_position[1] - 1 && position[1] <= obstacle_position[1] + 1
      end

      def out_of_mapped_area?(position)
        position[0].negative? ||
          position[1].negative? ||
          two_d_map[position[0]].nil? ||
          two_d_map[position[0]][position[1]].nil?
      end

      def get_position_directly_in_front_of_current_position(current_position, current_direction)
        return [current_position[0] - 1, current_position[1]] if current_direction == UP_DIRECTION
        return [current_position[0] + 1, current_position[1]] if current_direction == DOWN_DIRECTION
        return [current_position[0], current_position[1] + 1] if current_direction == RIGHT_DIRECTION
        return [current_position[0], current_position[1] - 1] if current_direction == LEFT_DIRECTION

        raise ArgumentError, "Invalid direction #{current_direction}"
      end

      def get_object_directly_in_front_of_current_position(current_position, current_direction)
        next_position = get_position_directly_in_front_of_current_position(current_position, current_direction)

        return nil if out_of_mapped_area?(next_position)
        return nil if two_d_map[next_position[0]].nil?

        two_d_map[next_position[0]][next_position[1]]
      end

      def get_next_position_and_direction(current_position, current_direction)
        object_directly_in_front = get_object_directly_in_front_of_current_position(current_position, current_direction)

        if obstacle?(object_directly_in_front)
          next_direction = DIRECTION_TURNING[current_direction]
          raise ArgumentError, "Invalid direction #{current_direction}" unless next_direction

          [get_position_directly_in_front_of_current_position(current_position, next_direction), next_direction]
        else
          [get_position_directly_in_front_of_current_position(current_position, current_direction), current_direction]
        end
      end

      def obstacle?(obj)
        obj == OBSTACLE_CHAR
      end
    end
  end
end
