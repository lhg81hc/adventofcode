require 'test/unit'
require_relative '../../../year2025/day1/part1/rotation'

module Year2025
  module Day1
    class RotationTest < Test::Unit::TestCase
      def setup
        @first_rotation = Year2025::Day1::Part1::Rotation.new('L10')
        @second_rotation = Year2025::Day1::Part1::Rotation.new('R22')
      end

      def test_initialization
        assert_equal(@first_rotation.str, 'L10')
        assert_equal(@second_rotation.str, 'R22')
      end

      def test_direction
        assert_equal(@first_rotation.direction, 'L')
        assert_equal(@second_rotation.direction, 'R')
      end

      def test_num_of_clicks
        assert_equal(@first_rotation.num_of_clicks, 10)
        assert_equal(@second_rotation.num_of_clicks, 22)
      end
    end
  end
end