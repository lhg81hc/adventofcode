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

        @two_d_map = @manufacturing_lab_map.two_d_map
        @starting_position = @manufacturing_lab_map.current_guard_position
        @starting_direction = @manufacturing_lab_map.current_guard_direction
        @route_prediction = Year2024::Day6::RoutePrediction.new(@two_d_map, @starting_position, @starting_direction)
      end

      def test_initialization
        assert_equal(@route_prediction.two_d_map, @two_d_map)
        assert_equal(@route_prediction.starting_position, @starting_position)
        assert_equal(@route_prediction.starting_direction, @starting_direction)
      end

      def test_obstacle?
        assert(@route_prediction.obstacle?('#'))
        refute(@route_prediction.obstacle?('.'))
        refute(@route_prediction.obstacle?(nil))
      end

      def test_out_of_mapped_area?
        assert(@route_prediction.out_of_mapped_area?([-1, 11]))
        assert(@route_prediction.out_of_mapped_area?([11, 11]))
        assert(@route_prediction.out_of_mapped_area?([9, 11]))
        refute(@route_prediction.out_of_mapped_area?([9, 9]))
      end

      def test_get_position_directly_in_front_of_current_position
        current_position = [9, 9]

        assert_equal(@route_prediction.get_position_directly_in_front_of_current_position(current_position, :down), [10, 9])
        assert_equal(@route_prediction.get_position_directly_in_front_of_current_position(current_position, :up), [8, 9])
        assert_equal(@route_prediction.get_position_directly_in_front_of_current_position(current_position, :right), [9, 10])
        assert_equal(@route_prediction.get_position_directly_in_front_of_current_position(current_position, :left), [9, 8])
      end

      def test_get_object_directly_in_front_of_current_position
        current_position = [9, 5]

        assert_equal(@route_prediction.get_object_directly_in_front_of_current_position(current_position, :down), nil)
        assert_equal(@route_prediction.get_object_directly_in_front_of_current_position(current_position, :up), '.')
        assert_equal(@route_prediction.get_object_directly_in_front_of_current_position(current_position, :right), '#')
        assert_equal(@route_prediction.get_object_directly_in_front_of_current_position(current_position, :left), '.')
      end


      def test_get_next_position_and_direction
        assert_equal(@route_prediction.get_next_position_and_direction([7, 1], :up), [[7, 2], :right])
        assert_equal(@route_prediction.get_next_position_and_direction([6, 4], :up), [[5, 4], :up])
        assert_equal(@route_prediction.get_next_position_and_direction([9, 5], :right), [[10, 5], :down])
        assert_equal(@route_prediction.get_next_position_and_direction([8, 1], :left), [[7, 1], :up])
      end
      #
      # def test_find_next_position
      #   current_position = [9, 9]
      #
      #   assert_equal(@route_prediction.find_next_position(current_position, :down), [10, 9])
      #   assert_equal(@route_prediction.find_next_position(current_position, :up), [8, 9])
      #   assert_equal(@route_prediction.find_next_position(current_position, :right), [9, 10])
      #   assert_equal(@route_prediction.find_next_position(current_position, :left), [9, 8])
      # end
      #
      # def test_find_find_object_directly_in_front
      #   current_position = [9, 5]
      #
      #   assert_equal(@route_prediction.find_object_directly_in_front(current_position, :down), nil)
      #   assert_equal(@route_prediction.find_object_directly_in_front(current_position, :up), '.')
      #   assert_equal(@route_prediction.find_object_directly_in_front(current_position, :right), '#')
      #   assert_equal(@route_prediction.find_object_directly_in_front(current_position, :left), '.')
      # end

      def test_predict_when_no_loop_found
        routes = [
          { :position => [6, 4], :direction => :up },
          { :position => [5, 4], :direction => :up },
          { :position => [4, 4], :direction => :up },
          { :position => [3, 4], :direction => :up },
          { :position => [2, 4], :direction => :up },
          { :position => [1, 4], :direction => :up },
          { :position => [1, 5], :direction => :right },
          { :position => [1, 6], :direction => :right },
          { :position => [1, 7], :direction => :right },
          { :position => [1, 8], :direction => :right },
          { :position => [2, 8], :direction => :down },
          { :position => [3, 8], :direction => :down },
          { :position => [4, 8], :direction => :down },
          { :position => [5, 8], :direction => :down },
          { :position => [6, 8], :direction => :down },
          { :position => [6, 7], :direction => :left },
          { :position => [6, 6], :direction => :left },
          { :position => [6, 5], :direction => :left },
          { :position => [6, 4], :direction => :left },
          { :position => [6, 3], :direction => :left },
          { :position => [6, 2], :direction => :left },
          { :position => [5, 2], :direction => :up },
          { :position => [4, 2], :direction => :up },
          { :position => [4, 3], :direction => :right },
          { :position => [4, 4], :direction => :right },
          { :position => [4, 5], :direction => :right },
          { :position => [4, 6], :direction => :right },
          { :position => [5, 6], :direction => :down },
          { :position => [6, 6], :direction => :down },
          { :position => [7, 6], :direction => :down },
          { :position => [8, 6], :direction => :down },
          { :position => [8, 5], :direction => :left },
          { :position => [8, 4], :direction => :left },
          { :position => [8, 3], :direction => :left },
          { :position => [8, 2], :direction => :left },
          { :position => [8, 1], :direction => :left },
          { :position => [7, 1], :direction => :up },
          { :position => [7, 2], :direction => :right },
          { :position => [7, 3], :direction => :right },
          { :position => [7, 4], :direction => :right },
          { :position => [7, 5], :direction => :right },
          { :position => [7, 6], :direction => :right },
          { :position => [7, 7], :direction => :right },
          { :position => [8, 7], :direction => :down },
          { :position => [9, 7], :direction => :down }
        ]

        visited_positions =
          [
            [6, 4], [5, 4], [4, 4], [3, 4], [2, 4], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8], [2, 8], [3, 8], [4, 8],
            [5, 8], [6, 8], [6, 7], [6, 6], [6, 5], [6, 3], [6, 2], [5, 2], [4, 2], [4, 3], [4, 5], [4, 6], [5, 6],
            [7, 6], [8, 6], [8, 5], [8, 4], [8, 3], [8, 2], [8, 1], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 7],
            [8, 7], [9, 7]
          ]

        loop_found = false

        assert_equal(@route_prediction.predict, Year2024::Day6::RoutePrediction::Prediction.new(routes, visited_positions, loop_found))
      end

      def test_prediction_when_loop_found
        @two_d_map = @manufacturing_lab_map.two_d_map
        @two_d_map[6][3] = '#'
        @starting_position = @manufacturing_lab_map.current_guard_position
        @starting_direction = @manufacturing_lab_map.current_guard_direction
        @route_prediction = Year2024::Day6::RoutePrediction.new(@two_d_map, @starting_position, @starting_direction)

        routes = [
          { :position => [6, 4], :direction => :up },
          { :position => [5, 4], :direction => :up },
          { :position => [4, 4], :direction => :up },
          { :position => [3, 4], :direction => :up },
          { :position => [2, 4], :direction => :up },
          { :position => [1, 4], :direction => :up },
          { :position => [1, 5], :direction => :right },
          { :position => [1, 6], :direction => :right },
          { :position => [1, 7], :direction => :right },
          { :position => [1, 8], :direction => :right },
          { :position => [2, 8], :direction => :down },
          { :position => [3, 8], :direction => :down },
          { :position => [4, 8], :direction => :down },
          { :position => [5, 8], :direction => :down },
          { :position => [6, 8], :direction => :down },
          { :position => [6, 7], :direction => :left },
          { :position => [6, 6], :direction => :left },
          { :position => [6, 5], :direction => :left },
          { :position => [6, 4], :direction => :left },
          { :position => [5, 4], :direction => :up }
        ]

        visited_positions =
          [
            [6, 4], [5, 4], [4, 4], [3, 4], [2, 4], [1, 4], [1, 5], [1, 6], [1, 7], [1, 8], [2, 8], [3, 8], [4, 8],
            [5, 8], [6, 8], [6, 7], [6, 6], [6, 5]
          ]

        loop_found = true

        assert_equal(@route_prediction.predict, Year2024::Day6::RoutePrediction::Prediction.new(routes, visited_positions, loop_found))
      end
    end
  end
end
