module Year2022
  module Day15
    class Sensor
      attr_reader :x, :y
      attr_accessor :closest_beacon

      def initialize(x, y)
        @x = x
        @y = y
        @closest_beacon = nil
      end

      def closest_beacon_x
        closest_beacon&.x
      end

      def closest_beacon_y
        closest_beacon&.y
      end

      def manhattan_distance_to_closest_beacon
        raise ArgumentError, 'Closest beacon must not be nil!' if closest_beacon.nil?

        (x - closest_beacon_x).abs + (y - closest_beacon_y).abs
      end

      def covered_range_on_a_row(row_idx)
        raise ArgumentError, 'Row index must be an integer' unless row_idx.is_a?(Integer)

        distance_to_projection_on_row = (y - row_idx).abs
        distance_to_closest_beacon = manhattan_distance_to_closest_beacon

        return nil if distance_to_closest_beacon < distance_to_projection_on_row

        min_x_index_of_covered_range = x - (distance_to_closest_beacon - distance_to_projection_on_row)
        max_x_index_of_covered_range = x + (distance_to_closest_beacon - distance_to_projection_on_row)
        (min_x_index_of_covered_range..max_x_index_of_covered_range)
      end

      def coordinate_of_maximum_reachable_points
        raise ArgumentError, 'Closest beacon must not be nil!' if closest_beacon.nil?

        # In clockwise order: top, right, bottom, left
        [
          [x, y - manhattan_distance_to_closest_beacon],
          [x + manhattan_distance_to_closest_beacon, y],
          [x, y + manhattan_distance_to_closest_beacon],
          [x - manhattan_distance_to_closest_beacon, y],
        ]
      end
    end
  end
end
