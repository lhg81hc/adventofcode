require 'test/unit'
require_relative '../../../year2022/day15/beacon'

module Year2022
  module Day15
    class BeaconTest < Test::Unit::TestCase
      def setup
        @beacon = Year2022::Day15::Beacon.new(1, 2)
        @another_beacon = Year2022::Day15::Beacon.new(100, 99)
      end

      def test_initialization
        assert_equal(1, @beacon.x)
        assert_equal(2, @beacon.y)
      end

      def test_x
        assert_equal(1, @beacon.x)
        assert_equal(100, @another_beacon.x)
      end

      def test_y
        assert_equal(2, @beacon.y)
        assert_equal(99, @another_beacon.y)
      end
    end
  end
end
