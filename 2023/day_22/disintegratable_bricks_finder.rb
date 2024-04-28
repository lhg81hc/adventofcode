module Day22
  class DisintegratableBricksFinder
    attr_reader :landed_bricks

    def initialize(landed_bricks)
      @landed_bricks = landed_bricks
    end

    def landed_brick_by_start_z_coordinate
      @landed_brick_by_start_z_coordinate ||= @landed_bricks.group_by(&:start_z_coordinate)
    end

    def landed_brick_by_end_z_coordinate
      @landed_brick_by_end_z_coordinate ||= @landed_bricks.group_by(&:end_z_coordinate)
    end

    # Idea:
    # Iterate through the landed bricks list, on each item perform the following:
    # 1. Find the precedent bricks (the one that lie on one level above)
    # 2. If the precedent bricks is an empty list then the current brick can be disintegrated (because it does not support any bricks)
    # 3. If the precedent bricks are present, on each of item of the precedent list, check if the precedent brick is supported by more
    # than 1 bricks,
    def disinteratable_bricks
      landed_bricks.select { |b| disinteratable?(b) }
    end

    def disinteratable?(brick)
      puts "Checking if brick #{brick.name} can be disintegrated..."

      preceding_bricks = find_precedent_bricks(brick)
      return true if preceding_bricks.empty?

      preceding_bricks.all? { |b| find_support_bricks(b).count > 1 }
    end

    def find_precedent_bricks(brick)
      bricks = landed_brick_by_start_z_coordinate[brick.end_z_coordinate + 1] || []
      filter_bricks_by_occupied_coordinates(bricks, brick)
    end

    def find_support_bricks(brick)
      bricks = landed_brick_by_end_z_coordinate[brick.start_z_coordinate - 1] || []
      filter_bricks_by_occupied_coordinates(bricks, brick)
    end

    def filter_bricks_by_occupied_coordinates(bricks, brick)
      bricks.select do |b|
        b.name != brick.name &&
          (b.occupied_coordinates_according_to_z_axis_perspective & brick.occupied_coordinates_according_to_z_axis_perspective).any?
      end
    end
  end
end
