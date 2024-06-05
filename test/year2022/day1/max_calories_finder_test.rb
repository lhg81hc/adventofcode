require 'test/unit'
require_relative '../../../year2022/day1/max_calories_finder'

module Day1
  class MaxCaloriesFinderTest < Test::Unit::TestCase
    def setup
      @calories_group = [[4, 18], [11, 6], [10], [3, 8], [1, 2, 9], [5, 7]]
      @max_calories_finder = Day1::MaxCaloriesFinder.new(@calories_group)
    end

    def test_find_max
      assert_equal(22, @max_calories_finder.find_max)
    end

    def test_find_top_three
      assert_equal([12, 22, 17], @max_calories_finder.find_top_three)
    end
  end
end
