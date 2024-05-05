module Day24
  class TestingArea
    attr_reader :lower_bound, :upper_bound

    def initialize(lower_bound, upper_bound)
      @lower_bound = lower_bound
      @upper_bound = upper_bound
    end

    def min
      [lower_bound, lower_bound]
    end

    def max
      [upper_bound, upper_bound]
    end

    def intersect_with_hailstone_future_path?(r)
      tmin = -Float::INFINITY
      tmax = Float::INFINITY

      (0..1).each do |i|
        if r.velocity[i] != 0
          t1 = (min[i] - r.position[i]) / r.velocity[i]
          t2 = (max[i] - r.position[i]) / r.velocity[i]

          tmin = [tmin, [t1, t2].min].max
          tmax = [tmax, [t1, t2].max].min
        else
          return false if r.position[i] <= min[i] || r.position[i] >= max[i]
        end
      end

      tmax > tmin && tmax > 0
    end

    def include?(coordinates)
      coordinates[0].between?(lower_bound, upper_bound) &&
        coordinates[1].between?(lower_bound, upper_bound)
    end
  end
end
