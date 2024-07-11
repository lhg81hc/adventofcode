module Year2022
  module Day12
    class GridSquare
      STARTING_ELEVATION = 'S'.freeze
      DESTINATION_ELEVATION = 'E'.freeze
      MIN_ELEVATION_CHAR = 'a'.freeze
      MAX_ELEVATION_CHAR = 'z'.freeze

      attr_reader :char_index, :line_index, :elevation, :height

      def initialize(char_index, line_index, elevation)
        @char_index = char_index
        @line_index = line_index
        @elevation = elevation
        @height = calculate_height
      end

      def name
        "#{char_index},#{line_index}"
      end

      def starting_elevation?
        elevation == STARTING_ELEVATION
      end

      def destination_elevation?
        elevation == DESTINATION_ELEVATION
      end

      private

      def calculate_height
        h = elevation.ord - MIN_ELEVATION_CHAR.ord

        return h if h.positive?

        if starting_elevation?
          0
        elsif destination_elevation?
          MAX_ELEVATION_CHAR.ord - MIN_ELEVATION_CHAR.ord
        else
          raise ArgumentError, "Invalid elevation #{elevation}"
        end
      end
    end
  end
end