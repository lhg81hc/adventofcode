require 'test/unit'
require './2022/day1/max_calories_finder'

module Day1
  class MaxCaloriesFinderTest < Test::Unit::TestCase
    def setup
      @calories_group = [[1, 2, 9], [4, 18], [17]]
      @max_calories_finder = Day1::MaxCaloriesFinder.new(@calories_group)
    end

    def test_find_max
      assert_equal(22, @max_calories_finder.find_max)
    end
  end
end
