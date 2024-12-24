require 'test/unit'
require_relative '../../../year2024/day6/route_prediction'
require_relative '../../../year2024/day6/manufacturing_lab_map'

module Year2024
  module Day6
    class RoutePredictionTest < Test::Unit::TestCase
      def setup
        @input_path = File.join(File.dirname(__FILE__), './input.txt')
        @manufacturing_lab_map = Year2024::Day6::ManufacturingLabMap.new(@input_path)
        @manufacturing_lab_map.scan
        @route_prediction = Year2024::Day6::RoutePrediction.new(@manufacturing_lab_map)
      end

      def test_initialization
        assert_equal(@route_prediction.manufacturing_lab_map, @manufacturing_lab_map)
      end

      def test_obstacle?
        assert(@route_prediction.obstacle?('#'))
        refute(@route_prediction.obstacle?('.'))
        refute(@route_prediction.obstacle?(nil))
      end

      def test_out_of_mapped_area?
        assert(@route_prediction.out_of_mapped_area?([11, 11]))
        assert(@route_prediction.out_of_mapped_area?([9, 11]))
        refute(@route_prediction.out_of_mapped_area?([9, 9]))
      end

      def test_find_next_direction
        assert_equal(@route_prediction.find_next_direction(:up, '.'), :up)
        assert_equal(@route_prediction.find_next_direction(:up, nil), :up)
        assert_equal(@route_prediction.find_next_direction(:up, '#'), :right)
        assert_equal(@route_prediction.find_next_direction(:right, '.'), :right)
        assert_equal(@route_prediction.find_next_direction(:right, nil), :right)
        assert_equal(@route_prediction.find_next_direction(:right, '#'), :down)
      end

      def test_find_next_position
        assert_equal(@route_prediction.find_next_position([9, 9], :down), [10, 9])
        assert_equal(@route_prediction.find_next_position([9, 9], :up), [8, 9])
        assert_equal(@route_prediction.find_next_position([9, 9], :right), [9, 10])
        assert_equal(@route_prediction.find_next_position([9, 9], :left), [9, 8])
      end

      def test_predict
        expectation = [
          [6, 4], [5, 4], [4, 4], [3, 4], [2, 4],
          [1, 4], [1, 5], [1, 6], [1, 7], [1, 8],
          [2, 8], [3, 8], [4, 8], [5, 8], [6, 8],
          [6, 7], [6, 6], [6, 5], [6, 4], [6, 3], [6, 2], [5, 2],
          [4, 2], [4, 3], [4, 4], [4, 5], [4, 6],
          [5, 6], [6, 6], [7, 6],
          [8, 6], [8, 5], [8, 4], [8, 3], [8, 2], [8, 1],
          [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7], [8, 7], [9, 7]
        ]

        assert_equal(@route_prediction.predict, expectation)
      end
    end
  end
end
