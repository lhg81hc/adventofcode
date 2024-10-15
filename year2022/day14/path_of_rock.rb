require_relative 'rock'
require_relative 'line_of_rock'

module Year2022
  module Day14
    class PathOfRock
      POINT_DIVIDER = ' -> '

      attr_reader :str

      def initialize(str)
        @str = str
      end

      def rocks
        @rocks ||= str.split(POINT_DIVIDER).map { |rock_coordinates| Year2022::Day14::Rock.new(rock_coordinates) }
      end

      def lines_of_rock
        @lines_of_rock ||=
          begin
            if rocks.length <= 1
              []
            else
              (0..rocks.length - 2).map { |idx| LineOfRock.new(rocks[idx], rocks[idx + 1]) }
            end
          end
      end
    end
  end
end
