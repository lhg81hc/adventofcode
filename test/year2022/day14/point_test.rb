require 'test/unit'
require_relative '../../../year2022/day14/point'

module Year2022
  module Day14
    class PointTest < Test::Unit::TestCase
      def setup
        @point = Year2022::Day14::Point.new('123,4')
      end

      def test_initialization
        assert_equal('123,4', @point.str)
      end

      def test_x
        assert_equal(123, @point.x)
      end

      def test_y
        assert_equal(4, @point.y)
      end
    end
  end
end
