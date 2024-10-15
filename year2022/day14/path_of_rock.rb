require_relative 'point'

module Year2022
  module Day14
    class PathOfRock
      POINT_DIVIDER = ' -> '

      attr_reader :str

      def initialize(str)
        @str = str
      end

      def points
        @points ||= str.split(POINT_DIVIDER).map { |point_coordinates| Year2022::Day14::Point.new(point_coordinates) }
      end

      def lines_of_rock
        @lines_of_rock ||=
          begin
            if points.length <= 1
              []
            else
              (0..points.length - 2).map { |point_idx| LineOfRock.new(points[point_idx], points[point_idx + 1]) }
            end
          end
      end
    end
  end
end
