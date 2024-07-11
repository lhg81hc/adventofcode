require 'test/unit'
require_relative '../../../year2022/day12/grid_square'

module Year2022
  module Day11
    class GridSquareTest < Test::Unit::TestCase
      def setup
        @starting_square = Year2022::Day12::GridSquare.new(0, 0, 'S')
        @destination_square = Year2022::Day12::GridSquare.new(3, 4, 'E')
        @normal_square = Year2022::Day12::GridSquare.new(2, 5, 'm')
      end

      def test_height
        assert_equal(0, @starting_square.height)
        assert_equal(25, @destination_square.height)
        assert_equal(12, @normal_square.height)
      end

      def test_name
        assert_equal('0,0', @starting_square.name)
        assert_equal('3,4', @destination_square.name)
        assert_equal('2,5', @normal_square.name)
      end

      def test_starting_elevation?
        assert(@starting_square.starting_elevation?)
        refute(@destination_square.starting_elevation?)
        refute(@normal_square.starting_elevation?)
      end

      def test_destination_elevation?
        refute(@starting_square.destination_elevation?)
        assert(@destination_square.destination_elevation?)
        refute(@normal_square.destination_elevation?)
      end
    end
  end
end
