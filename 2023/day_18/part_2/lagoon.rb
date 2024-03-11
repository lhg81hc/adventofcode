module Day18
  module Part2
    class Lagoon
      attr_reader :trenches

      def initialize(trenches)
        @trenches = trenches
      end

      def area
        n = polygon_coordinates.length

        area =
          (0..polygon_coordinates.length - 1).inject(0.0) do |s, i|
            j = (i + 1) % n

            s += polygon_coordinates[i][0] * polygon_coordinates[j][1]
            s -= polygon_coordinates[j][0] * polygon_coordinates[i][1]
            s
          end

        (area.abs / 2) + (trenches_length.sum / 2 + 1)
      end

      def polygon_coordinates
        @polygon_coordinates ||=
          trenches.inject([]) do |r, trench|
            r << trench[-1]
            r
          end
      end

      def trenches_length
        @trenches_length ||=
          trenches.inject([]) do |r, trench|
            start_point = trench[0]
            end_point = trench[1]

            length =
              if start_point[0] == end_point[0]
                (end_point[1] - start_point[1]).abs
              else
                (end_point[0] - start_point[0]).abs
              end

            length += 1

            r << length
            r
          end
      end
    end
  end
end
