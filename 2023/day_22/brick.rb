module Day22
  class Brick
    attr_reader :name, :first_coordinates_set, :second_coordinates_set

    def initialize(name, first_coordinates_set, second_coordinates_set)
      @name = name
      @first_coordinates_set = first_coordinates_set
      @second_coordinates_set = second_coordinates_set
    end

    def update_start_z_coordinate(z_coordinate)
      @first_coordinates_set[2] = z_coordinate
    end

    def update_end_z_coordinate(z_coordinate)
      @second_coordinates_set[2] = z_coordinate
    end

    # #ordered_x_coordinates(),
    # #ordered_y_coordinates(),
    # #ordered_z_coordinates(),
    # #start_x_coordinates(),
    # #start_y_coordinates(),
    # #start_z_coordinates(),
    # #end_x_coordinates(),
    # #end_y_coordinates(),
    # #end_z_coordinates(),
    # #length_according_to_x_axis_perspective(),
    # #length_according_to_y_axis_perspective(),
    # #length_according_to_z_axis_perspective(),
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

      define_method("length_according_to_#{coordinate_name}_axis_perspective") do
        send("end_#{coordinate_name}_coordinate") - send("start_#{coordinate_name}_coordinate") + 1
      end
    end

    def occupied_coordinates_according_to_z_axis_perspective
      ((start_x_coordinate..end_x_coordinate).to_a).
        product((start_y_coordinate..end_y_coordinate).to_a)
    end
  end
end
