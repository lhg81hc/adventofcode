require 'test/unit'
require_relative '../../../year2022/day8/input_parser'

module Year2022
  module Day6
    class GridUtilsTest < Test::Unit::TestCase
      def setup
        @filepath = File.join(File.dirname(__FILE__), './input.txt')
        @gird = Year2022::Day8::InputParser.parse(@filepath)
      end

      def test_total_visible_trees_from_outside
        assert_equal(21, @gird.total_visible_trees_from_outside)
      end

      def test_highest_scenic_score
        assert_equal(8, @gird.highest_scenic_score)
      end
    end
  end
end
