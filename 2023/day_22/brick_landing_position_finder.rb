module Day22
  class BrickLandingPositionFinder
    MIN_Z_COORDINATE = 1

    attr_reader :bricks

    def initialize(bricks)
      @bricks = bricks
    end

    def land
      bricks_order_by_z_index.inject([]) do |r, falling_brick|
        puts "Landing brick #{falling_brick.name}..."

        last_landed_brick = r.last
        start_z_coordinate = falling_brick.start_z_coordinate

        if last_landed_brick && (start_z_coordinate < last_landed_brick.start_z_coordinate)
          raise ArgumentError, 'Invalid z coordinate'
        end

        start_z_coordinate, end_z_coordinate = find_new_z_coordinates(falling_brick, r)
        clone = falling_brick.clone

        if start_z_coordinate != falling_brick.start_z_coordinate || end_z_coordinate != falling_brick.end_z_coordinate
          clone.update_start_z_coordinate(start_z_coordinate)
          clone.update_end_z_coordinate(end_z_coordinate)
        end

        r << clone
      end
    end

    def bricks_order_by_z_index
      bricks.sort_by { |brick| [brick.first_coordinates_set.last, brick.second_coordinates_set.last] }
    end


    # Idea:
    # Check if the falling brick can be SETTLED at a specific level, if it can then move down to the next level
    # and repeat the checking process until it can not be moved down any further.
    #
    # Steps:
    # 1. set current level equals to the start z coordinate of the falling brick
    # 2. Check if there are any cubes that occupied on the same position of the falling brick
    # 3. If false, repeat step 2 for the next level (current level -= 1) until there is no level to try (hits the ground)
    # 4. If true returns current level + 1 (since it can not be settle at the current level, it has to be 1 level up)
    def find_new_z_coordinates(falling_brick, curr_landed_bricks)
      current_level = falling_brick.start_z_coordinate

      while current_level >= MIN_Z_COORDINATE
        occupied_coordinates_on_current_level = occupied_coordinates(curr_landed_bricks, current_level)

        if occupied_coordinates_on_current_level.any?
          occupied_coordinates_of_falling_brick = falling_brick.occupied_coordinates_according_to_z_axis_perspective

          if (occupied_coordinates_of_falling_brick & occupied_coordinates_on_current_level).any?
            return [current_level + 1, current_level + falling_brick.length_according_to_z_axis_perspective]
          end
        end

        break if current_level == MIN_Z_COORDINATE

        current_level -= 1
      end

      [current_level, current_level + falling_brick.length_according_to_z_axis_perspective - 1]
    end

    def occupied_coordinates(curr_landed_bricks, curr_level)
      curr_landed_bricks.inject([]) do |r, brick|
        r += brick.occupied_coordinates_according_to_z_axis_perspective if brick.end_z_coordinate == curr_level
        r
      end
    end
  end
end
