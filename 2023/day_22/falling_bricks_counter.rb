require_relative 'brick_landing_position_finder'
require_relative 'disintegratable_bricks_finder'

module Day22
  class FallingBricksCounter
    attr_accessor :falling_bricks

    def initialize(falling_bricks)
      @falling_bricks = falling_bricks
    end

    def landed_bricks
      @landed_bricks ||= Day22::BrickLandingPositionFinder.new(falling_bricks).land
    end

    def highest_z_coordinate
      @highest_z_coordinate ||= landed_bricks.last.end_z_coordinate
    end

    def disinteratable_brick_names
      @disinteratable_brick_names ||=
        Day22::DisintegratableBricksFinder.new(landed_bricks).disinteratable_bricks.map(&:name)
    end

    def original_start_z_coordinate_map
      @original_start_z_coordinate_map ||=
        landed_bricks.inject({}) do |r, brick|
          r[brick.name] = brick.start_z_coordinate
          r
        end
    end

    def bricks_map_by_start_z_coordinate
      @bricks_map_by_start_z_coordinate ||=
        landed_bricks.inject({}) do |r, brick|
          r[brick.start_z_coordinate] ||= []
          r[brick.start_z_coordinate] << brick
          r
        end
    end

    def disintegrate_brick(brick)
      filtered =
        (brick.start_z_coordinate).upto(highest_z_coordinate).inject([]) do |r, z_coordinate|
          if z_coordinate == brick.start_z_coordinate
            r += bricks_map_by_start_z_coordinate[z_coordinate].select { |b| b.name != brick.name }
          else
            r += bricks_map_by_start_z_coordinate[z_coordinate] unless bricks_map_by_start_z_coordinate[z_coordinate].nil?
          end

          r
        end

      Day22::BrickLandingPositionFinder.new(filtered).land
    end

    # Idea:
    # - Firstly, settle the 'falling bricks' to make them 'landed bricks' (find the coordination when each brick can not
    #   fall down any further)
    # - Secondly, remove brick by brick from the 'landed bricks', start from the low level go up to the top level (z coordinate),
    #   after remove the brick calculate the 'landed bricks' again and compare with the original 'landed bricks'
    # - Finally, if the new 'landed bricks' all have the same z coordinate compare to the original 'landed bricks'
    #   meaning there are no bricks to fall further, otherwise count the different and get the total number of changes.
    def total_falling_bricks_if_disintegrate_all_bricks_one_by_one
      landed_bricks.reverse.inject(0) do |r, brick|
        unless disinteratable_brick_names.include?(brick.name)
          count = num_of_falling_bricks_if_disintegrate(brick)
          puts "Disintegrating brick '#{brick.name}' would cause all #{count} other bricks to fall"
          r += count
        end

        r
      end
    end

    def num_of_falling_bricks_if_disintegrate(brick)
      # TODO:
      # Can improve further by checking if at a certain level the bricks stop falling down
      # Because when that happens meaning the remaining level (above the current level) are not going to change so no need to check
      disintegrate_brick(brick).inject(0) do |r, new_landed_brick|
        prev_start_z_coordinate = original_start_z_coordinate_map[new_landed_brick.name]
        r += 1 if !prev_start_z_coordinate.nil? && prev_start_z_coordinate != new_landed_brick.start_z_coordinate
        r
      end
    end
  end
end
