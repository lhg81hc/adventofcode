require 'test/unit'
require_relative '../../../year2022/day15/sensor_system'

module Year2022
  module Day15
    class SensorSystemTest < Test::Unit::TestCase
      def setup
        @input_path = File.join(File.dirname(__FILE__), './input.txt')
        @sensor_system = Year2022::Day15::SensorSystem.new(@input_path)
      end

      def test_initialization
        assert_equal(@input_path, @sensor_system.input_path)
        assert_equal([], @sensor_system.sensors)
        refute(@sensor_system.deployed?)
      end

      def test_deployed?
        refute(@sensor_system.deployed?)

        @sensor_system.deploy
        assert(@sensor_system.deployed?)
      end

      def test_occupied_x_indexes_on_row
        @sensor_system.deploy

        assert_equal([0], @sensor_system.occupied_x_indexes_on_row(11))
        assert_equal([14, 15].to_set, @sensor_system.occupied_x_indexes_on_row(3).to_set)
      end

      def test_total_positions_on_row_cannot_contain_a_beacon
        @sensor_system.deploy

        assert_equal(26, @sensor_system.total_positions_on_row_cannot_contain_a_beacon(10))
      end
    end
  end
end
