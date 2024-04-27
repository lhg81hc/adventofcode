module Day22
  class Snapshot
    attr_reader :bricks

    def initialize(bricks = [])
      @bricks = bricks
    end

    def x_axis_perspective
      axis_perspective(0)
    end

    def y_axis_perspective
      axis_perspective(1)
    end

    private

    def axis_perspective(axis_index)
      raise ArgumentError, 'Only accept 1 or 2 as argument value' if axis_index != 1 && axis_index != 2

      result = []
      max_index = 0

      bricks.each do |brick|
        brick_name = brick.name

        (brick.start_z_coordinate..brick.end_z_coordinate).each do |z_coordinate|
          result[z_coordinate] ||= []

          from_coordinate, to_coordinate = axis_index == 1 ? brick.ordered_x_coordinates : brick.ordered_y_coordinates
          max_index = to_coordinate if max_index < to_coordinate

          (from_coordinate..to_coordinate).each do |coordinate|
            result[z_coordinate][coordinate] ||= []
            result[z_coordinate][coordinate] << brick_name unless result[z_coordinate][coordinate].include?(brick_name)
          end
        end
      end

      result[0] = Array.new(max_index + 1, ['-'])

      result
    end
  end
end
