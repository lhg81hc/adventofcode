require 'test/unit'
require_relative '../../../year2022/day8/input_parser'

module Year2022
  module Day6
    class InputParserTest < Test::Unit::TestCase
      def setup
        @filepath = File.join(File.dirname(__FILE__), './input.txt')
        @input_parser = Year2022::Day8::InputParser.new(@filepath)
      end

      def test_parse
        grid = @input_parser.parse

        assert_equal(25, grid.total_trees)
        assert_equal(5, grid.trees.length)
        assert_equal(5, grid.trees[0].length)

        top_left_tree = grid.trees[0][0]
        assert_equal('0,0', top_left_tree.to_s)
        assert_equal(3, top_left_tree.height)
        assert(top_left_tree.on_top_edge?)
        assert(top_left_tree.on_left_edge?)

        top_right_tree = grid.trees[0][4]
        assert_equal('4,0', top_right_tree.to_s)
        assert_equal(3, top_right_tree.height)
        assert(top_right_tree.on_top_edge?)
        assert(top_right_tree.on_right_edge?)

        bottom_right_tree = grid.trees[4][4]
        assert_equal('4,4', bottom_right_tree.to_s)
        assert_equal(0, bottom_right_tree.height)
        assert(bottom_right_tree.on_bottom_edge?)
        assert(bottom_right_tree.on_right_edge?)

        bottom_left_tree = grid.trees[4][0]
        assert_equal('0,4', bottom_left_tree.to_s)
        assert_equal(3, bottom_left_tree.height)
        assert(bottom_left_tree.on_bottom_edge?)
        assert(bottom_left_tree.on_left_edge?)
      end
    end
  end
end
