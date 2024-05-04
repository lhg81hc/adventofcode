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

    def x
      position[0]
    end

    def y
      position[1]
    end

    def x_velocity
      velocity[0]
    end

    def y_velocity
      velocity[1]
    end
  end
end
