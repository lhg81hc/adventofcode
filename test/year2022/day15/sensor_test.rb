require 'test/unit'
require_relative '../../../year2022/day15/sensor'
require_relative '../../../year2022/day15/beacon'

module Year2022
  module Day15
    class SensorTest < Test::Unit::TestCase
      def setup
        @sensor = Year2022::Day15::Sensor.new(8, 7)
      end

      def test_initialization
        assert_equal(8, @sensor.x)
        assert_equal(7, @sensor.y)
        assert_nil(@sensor.closest_beacon)
      end

      def test_closest_beacon_x
        assert_nil(@sensor.closest_beacon_x)

        beacon = Year2022::Day15::Beacon.new(5, 6)
        @sensor.closest_beacon = beacon

        assert_equal(5, @sensor.closest_beacon_x)
      end

      def test_closest_beacon_y
        assert_nil(@sensor.closest_beacon_y)

        beacon = Year2022::Day15::Beacon.new(5, 6)
        @sensor.closest_beacon = beacon

        assert_equal(6, @sensor.closest_beacon_y)
      end

      def test_manhattan_distance_to_closest_beacon
        assert_raises(ArgumentError) { @sensor.manhattan_distance_to_closest_beacon }

        beacon = Year2022::Day15::Beacon.new(2, 10)
        @sensor.closest_beacon = beacon

        assert_equal(9, @sensor.manhattan_distance_to_closest_beacon)
      end

      def test_covered_range_on_a_row_when_invalid_argument
        [nil, 1.1, 'a'].each do |invalid_row_idx|
          assert_raises(ArgumentError) { @sensor.covered_range_on_a_row(invalid_row_idx) }

          beacon = Year2022::Day15::Beacon.new(2, 10)
          @sensor.closest_beacon = beacon

          assert_raises(ArgumentError) { @sensor.covered_range_on_a_row(invalid_row_idx) }
        end
      end

      def test_covered_range_on_a_row_when_in_range
        assert_raises(ArgumentError) { @sensor.covered_range_on_a_row(16) }

        beacon = Year2022::Day15::Beacon.new(2, 10)
        @sensor.closest_beacon = beacon

        assert_equal((8..8), @sensor.covered_range_on_a_row(16))
        assert_equal((3..13), @sensor.covered_range_on_a_row(11))
        assert_equal((-1..17), @sensor.covered_range_on_a_row(7))
      end

      def test_covered_range_on_a_row_that_is_too_far
        beacon = Year2022::Day15::Beacon.new(2, 10)
        @sensor.closest_beacon = beacon

        assert_nil(@sensor.covered_range_on_a_row(40))
      end
    end
  end
end
