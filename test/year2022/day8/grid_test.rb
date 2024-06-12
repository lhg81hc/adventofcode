require 'test/unit'
require_relative '../../../year2022/day8/grid'
require_relative '../../../year2022/day8/tree'

module Year2022
  module Day6
    class GridTest < Test::Unit::TestCase
      def setup
        @grid = Year2022::Day8::Grid.new
        @first_tree = Year2022::Day8::Tree.new(0, 0, 3)
        @second_tree = Year2022::Day8::Tree.new(1, 10, 9)

        @grid.add_tree(0, 0, @first_tree)
        @grid.add_tree(10, 1, @second_tree)
      end

      def test_add_tree
        assert_equal(@first_tree, @grid.trees[0][0])
        assert_equal(@second_tree, @grid.trees[10][1])
      end

      def test_total_trees
        assert_equal(2, @grid.total_trees)
      end

      def test_rows
        assert_equal([[@first_tree], nil, nil, nil, nil, nil, nil, nil, nil, nil, [nil, @second_tree]], @grid.rows)
      end

      def test_row
        assert_equal([@first_tree], @grid.row(0))
        assert_nil(@grid.row(1))
        assert_equal([nil, @second_tree], @grid.row(10))
        assert_nil(@grid.row(11))
      end

      def test_columns
        assert_equal(
          [
            [@first_tree, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, @second_tree]
          ], @grid.columns
        )
      end

      def test_column
        assert_equal([@first_tree, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil], @grid.column(0))
        assert_equal([nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, @second_tree], @grid.column(1))
        assert_nil(@grid.column(2))
        assert_nil(@grid.column(-1))
      end
    end
  end
end
