require 'test/unit'
require_relative '../../../year2024/day6/loop_causing_position_finder'
require_relative '../../../year2024/day6/manufacturing_lab_map'
require_relative '../../../year2024/day6/route_prediction'

module Year2024
  module Day6
    class LoopCausingPositionFinderTest < Test::Unit::TestCase
      def setup
        @input_path = File.join(File.dirname(__FILE__), './input.txt')
        @manufacturing_lab_map = Year2024::Day6::ManufacturingLabMap.new(@input_path)
        @manufacturing_lab_map.scan

        @loop_causing_position_finder = Year2024::Day6::LoopCausingPositionFinder.new(@manufacturing_lab_map)
      end

      def test_initialization
        assert_equal(@loop_causing_position_finder.manufacturing_lab_map, @manufacturing_lab_map)
        assert(@loop_causing_position_finder.route_prediction.is_a?(Year2024::Day6::RoutePrediction))
      end

      def test_visited_positions
        visited_positions =
          [
            [5, 4], [4, 4], [3, 4], [2, 4], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8], [2, 8], [3, 8], [4, 8],
            [5, 8], [6, 8], [6, 7], [6, 6], [6, 5], [6, 3], [6, 2], [5, 2], [4, 2], [4, 3], [4, 5], [4, 6], [5, 6],
            [7, 6], [8, 6], [8, 5], [8, 4], [8, 3], [8, 2], [8, 1], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 7],
            [8, 7], [9, 7]
          ]

        assert_equal(@loop_causing_position_finder.visited_positions, visited_positions)
      end

      def test_search
        positions = [[6, 3], [7, 6], [8, 3], [8, 1], [7, 7], [9, 7]]

        assert_equal(@loop_causing_position_finder.search, positions)
      end
    end
  end
end
