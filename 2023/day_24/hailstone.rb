require 'matrix'

module Day24
  class Hailstone
    attr_reader :name, :position, :velocity

    def initialize(name, position, velocity)
      @name = name
      @position = position
      @velocity = velocity
    end

    def to_s
      name
    end

    %w[x y z].each.with_index do |coordination, idx|
      define_method(coordination) do
        position[idx]
      end

      define_method("#{coordination}_velocity") do
        velocity[idx]
      end
    end

    def coordinates_of_intersection(another_hailstone)
      matrix_a = Matrix[[x_velocity, -another_hailstone.x_velocity], [y_velocity, -another_hailstone.y_velocity]]
      matrix_b = Matrix[[another_hailstone.x - x], [another_hailstone.y - y]]

      r = matrix_a.inverse * matrix_b
      t1, t2 = r.to_a.flatten

      if t1 > 0 && t2 > 0
        [(x + x_velocity * t1), (y + y_velocity * t1)]
      else
        [nil, nil]
      end
    rescue ExceptionForMatrix::ErrNotRegular
      return nil
    end
  end
end
