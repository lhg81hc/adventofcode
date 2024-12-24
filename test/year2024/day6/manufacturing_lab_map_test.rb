require 'test/unit'
require_relative '../../../year2024/day6/manufacturing_lab_map'

module Year2024
  module Day6
    class ManufacturingLabMapTest < Test::Unit::TestCase
      def setup
        @input_path = File.join(File.dirname(__FILE__), './input.txt')
        @manufacturing_lab_map = Year2024::Day6::ManufacturingLabMap.new(@input_path)
      end

      def test_initialization
        assert_equal(@manufacturing_lab_map.input_path, @input_path)
      end

      def test_scanned?
        refute(@manufacturing_lab_map.scanned?)

        @manufacturing_lab_map.scan

        assert(@manufacturing_lab_map.scanned?)
      end

      def test_scan
        @manufacturing_lab_map.scan

        assert(@manufacturing_lab_map.scanned?)
        assert_equal(@manufacturing_lab_map.current_guard_position, [6, 4])
        assert_equal(@manufacturing_lab_map.current_guard_direction, :up)
        assert_equal(@manufacturing_lab_map.two_d_map.length, 10)
        assert_equal(@manufacturing_lab_map.two_d_map[0][0], '.')
        assert_equal(@manufacturing_lab_map.two_d_map[9][6], '#')
      end
    end
  end
end
