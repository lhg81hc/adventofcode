module Day22
  class BricksArrangement
    attr_reader :bricks

    def initialize(bricks)
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
      result = []
      max_index = 0

      bricks.each do |brick|
        brick_name = brick.name
        first_coordinates_set = brick.first_coordinates_set
        second_coordinates_set = brick.second_coordinates_set

        from_z_coordinate, to_z_coordinate = [first_coordinates_set.last, second_coordinates_set.last].minmax
        (from_z_coordinate..to_z_coordinate).each do |z_coordinate|
          result[z_coordinate] ||= []

          from_coordinate, to_coordinate = [first_coordinates_set[axis_index], second_coordinates_set[axis_index]].minmax
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
