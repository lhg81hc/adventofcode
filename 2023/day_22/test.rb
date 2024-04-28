require_relative 'brick_landing_position_finder'
require_relative 'disintegratable_bricks_finder'

module Day22
  class Test
    attr_accessor :falling_bricks

    def initialize(falling_bricks)
      @falling_bricks = falling_bricks
    end

    def landed_bricks
      @landed_bricks ||= Day22::BrickLandingPositionFinder.new(falling_bricks).land
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

    def disintegrate_brick(brick)
      filtered = landed_bricks.reject { |b| b.name == brick.name }
      Day22::BrickLandingPositionFinder.new(filtered).land
    end

    def count
      landed_bricks.reverse.inject(0) do |r, brick|
        unless disinteratable_brick_names.include?(brick.name)
          new_landed_bricks = disintegrate_brick(brick)
          # if brick.name == '6'
            p original_start_z_coordinate_map
            p new_landed_bricks
          # end
          puts "Disintegrating brick '#{brick.name}' would cause all #{count_start_z_coordinate_change(new_landed_bricks)} other bricks to fall"
          r += count_start_z_coordinate_change(new_landed_bricks)
        end

        r
      end
    end

    def count_start_z_coordinate_change(new_landed_bricks)
      new_landed_bricks.inject(0) do |r, new_landed_brick|
        prev_start_z_coordinate = original_start_z_coordinate_map[new_landed_brick.name]
        r += 1 if !prev_start_z_coordinate.nil? && prev_start_z_coordinate != new_landed_brick.start_z_coordinate
        r
      end
    end
  end
end
