module Day22
  class Brick
    attr_reader :name, :first_coordinates_set, :second_coordinates_set, :num_of_cubes

    def initialize(name, first_coordinates_set, second_coordinates_set)
      @name = name
      @first_coordinates_set = first_coordinates_set
      @second_coordinates_set = second_coordinates_set
      @num_of_cubes = calculate_num_of_cubes
    end

    def update_start_z_coordinate(z_coordinate)
      @first_coordinates_set.last = z_coordinate
    end

    def update_end_z_coordinate(z_coordinate)
      @first_coordinates_set.last = z_coordinate
    end

    end

    def calculate_num_of_cubes
      differences =
        first_coordinates_set.each.with_index.inject([]) do |r, (coordinate, idx)|
          r << (second_coordinates_set[idx] - coordinate + 1) if second_coordinates_set[idx] != coordinate
          r
        end

      num_of_diff = differences.length

      return 1 if num_of_diff.zero?
      return differences.first if num_of_diff == 1

      raise "Invalid brick coordinates #{name}"
    end
  end
end
