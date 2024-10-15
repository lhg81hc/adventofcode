module Year2022
  module Day14
    class Sand
      STARTING_POSITION = [500, 0]

      attr_accessor :coordinates, :flew_into_abyss

      def initialize
        @coordinates = STARTING_POSITION
        @flew_into_abyss = false
      end

      def next_coordinates
        current_x = @coordinates[0]
        current_y = @coordinates[1]

        # The order of array is also the priority of move for the sand
        [
          [current_x, current_y + 1],
          [current_x - 1, current_y + 1],
          [current_x + 1, current_y + 1],
        ]
      end

      def flew_into_abyss?
        @flew_into_abyss
      end

      def x
        @coordinates[0]
      end

      def y
        @coordinates[1]
      end
    end
  end
end
