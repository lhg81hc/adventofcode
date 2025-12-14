require 'test/unit'
require_relative '../../../year2025/day1/rotation'

module Year2025
  module Day1
    class RotationTest < Test::Unit::TestCase
      def setup
        @first_rotation = Year2025::Day1::Rotation.new('L10')
        @second_rotation = Year2025::Day1::Rotation.new('R22')
      end

      def test_initialization
        assert_equal(@first_rotation.str, 'L10')
        assert_equal(@second_rotation.str, 'R22')
      end

      def test_direction
        assert_equal(@first_rotation.direction, 'L')
        assert_equal(@second_rotation.direction, 'R')
      end

      def test_clicks
        assert_equal(@first_rotation.clicks, 10)
        assert_equal(@second_rotation.clicks, 22)
      end

      def test_to_the_left_and_to_the_right
        assert(@first_rotation.to_the_left?)
        refute(@first_rotation.to_the_right?)
        assert(@second_rotation.to_the_right?)
        refute(@second_rotation.to_the_left?)
      end

      def test_to_i
        assert_equal(@first_rotation.to_i, -10)
        assert_equal(@second_rotation.to_i, 22)
      end
    end
  end
end