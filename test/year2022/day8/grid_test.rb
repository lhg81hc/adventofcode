require 'test/unit'
require_relative '../../../year2022/day8/grid'
require_relative '../../../year2022/day8/tree'

module Year2022
  module Day6
    class GridTest < Test::Unit::TestCase
      def setup
        @grid = Year2022::Day8::Grid.new
      end

      def test_add_tree_and_total_trees
        assert_equal([], @grid.trees)

        new_tree = Year2022::Day8::Tree.new(0, 0, 3)
        @grid.add_tree(0, 0, new_tree)

        assert_equal(1, @grid.total_trees)
        assert_equal(new_tree, @grid.trees[0][0])
        assert_equal(1, @grid.trees[0].compact.length)

        new_tree = Year2022::Day8::Tree.new(1, 10, 9)
        @grid.add_tree(10, 1, new_tree)

        assert_equal(2, @grid.total_trees)
        assert_equal(new_tree, @grid.trees[10][1])
        assert_equal(1, @grid.trees[10].compact.length)
      end

      def test_row
        assert_equal(nil, @grid.row(0))

        first_tree = Year2022::Day8::Tree.new(0, 0, 3)
        @grid.add_tree(0, 0, first_tree)

        assert_equal(1, @grid.row(0).length)
        assert_equal([first_tree], @grid.row(0))

        second_tree = Year2022::Day8::Tree.new(1, 0, 3)
        @grid.add_tree(0, 1, second_tree)

        assert_equal(2, @grid.row(0).length)
        assert_equal([first_tree, second_tree], @grid.row(0))
      end

      def test_column
        assert_equal(nil, @grid.column(1))

        first_tree = Year2022::Day8::Tree.new(1, 0, 5)
        @grid.add_tree(0, 1, first_tree)

        assert_equal(1, @grid.column(1).length)
        assert_equal([first_tree], @grid.column(1))

        second_tree = Year2022::Day8::Tree.new(1, 1, 3)
        @grid.add_tree(1, 1, second_tree)

        assert_equal(2, @grid.row(0).length)
        assert_equal([first_tree, second_tree], @grid.column(1))
      end
    end
  end
end
