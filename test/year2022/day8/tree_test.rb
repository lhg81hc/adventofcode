require 'test/unit'
require_relative '../../../year2022/day8/tree'

module Year2022
  module Day6
    class TreeTest < Test::Unit::TestCase
      class TopEdgeTreeTest < TreeTest
        def setup
          @line_index = 0
          @char_index = 100
          @height = 5
          @tree = Year2022::Day8::Tree.new(@char_index, @line_index, @height)
        end

        def test_location
          assert_equal([100, 0], @tree.location)
        end

        def test_to_s
          assert_equal('100,0', @tree.to_s)
        end

        def test_on_left_edge?
          refute(@tree.on_left_edge?)
        end

        def test_on_top_edge?
          assert(@tree.on_top_edge?)
        end

        def test_around_the_edge?
          assert(@tree.around_the_edge?)
        end

        def test_on_bottom_edge?
          @tree.on_bottom_edge = true
          assert(@tree.on_bottom_edge?)

          @tree.on_bottom_edge = false
          refute(@tree.on_bottom_edge?)
        end

        def test_on_right_edge?
          @tree.on_right_edge = true
          assert(@tree.on_right_edge?)

          @tree.on_right_edge = false
          refute(@tree.on_right_edge?)
        end
      end

      class LeftEdgeTreeTest < TreeTest
        def setup
          @line_index = 88
          @char_index = 0
          @height = 22
          @tree = Year2022::Day8::Tree.new(@char_index, @line_index, @height)
        end

        def test_location
          assert_equal([0, 88], @tree.location)
        end

        def test_to_s
          assert_equal('0,88', @tree.to_s)
        end

        def test_on_left_edge?
          assert(@tree.on_left_edge?)
        end

        def test_on_top_edge?
          refute(@tree.on_top_edge?)
        end

        def test_around_the_edge?
          assert(@tree.around_the_edge?)
        end

        def test_on_bottom_edge?
          @tree.on_bottom_edge = true
          assert(@tree.on_bottom_edge?)

          @tree.on_bottom_edge = false
          refute(@tree.on_bottom_edge?)
        end

        def test_on_right_edge?
          @tree.on_right_edge = true
          assert(@tree.on_right_edge?)

          @tree.on_right_edge = false
          refute(@tree.on_right_edge?)
        end
      end
    end
  end
end
