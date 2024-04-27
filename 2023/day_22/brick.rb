module Day22
  class Brick
    attr_reader :name, :first_coordinates_set, :second_coordinates_set

    def initialize(name, first_coordinates_set, second_coordinates_set)
      @name = name
      @first_coordinates_set = first_coordinates_set
      @second_coordinates_set = second_coordinates_set
    end

    def update_start_z_coordinate(z_coordinate)
      @first_coordinates_set.last = z_coordinate
    end

    def update_end_z_coordinate(z_coordinate)
      @first_coordinates_set.last = z_coordinate
    end

    { 'x': 0, 'y': 1, 'z': 2 }.each do |coordinate_name, idx|
      define_method("ordered_#{coordinate_name}_coordinates") do
        [first_coordinates_set[idx], second_coordinates_set[idx]].minmax
      end

      define_method("start_#{coordinate_name}_coordinate") do
        send("ordered_#{coordinate_name}_coordinates").first
      end

      define_method("end_#{coordinate_name}_coordinate") do
        send("ordered_#{coordinate_name}_coordinates").last
      end
    end

      end

    end
  end
end
