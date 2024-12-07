require 'test/unit'
require_relative '../../../year2024/day1/distance_finder'

module Year2024
  module Day1
    class DistanceFinderTest < Test::Unit::TestCase
      def setup
        @first_list = [3, 4, 2, 1, 3, 3]
        @second_list = [4, 3, 5, 3, 9, 3]

        @distance_finder = Year2024::Day1::DistanceFinder.new(@first_list, @second_list)
      end

      def test_initialization
        assert_equal(@distance_finder.first_list, [3, 4, 2, 1, 3, 3])
        assert_equal(@distance_finder.second_list, [4, 3, 5, 3, 9, 3])
      end

      def test_sorted_first_list
        assert_equal(@distance_finder.sorted_first_list, [1, 2, 3, 3, 3, 4])
        assert_equal(@distance_finder.sorted_second_list, [3, 3, 3, 4, 5, 9])
      end

      def test_distance
        assert_equal(@distance_finder.distance, 11)
      end
    end
  end
end
