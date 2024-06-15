require 'test/unit'
require_relative '../../../year2022/day9/knot'

module Year2022
  module Day9
    class KnotTest < Test::Unit::TestCase
      class ValidInput < KnotTest
        def setup
          @char_index = 10
          @line_index = 5
          @ordinal_number = 1

          @second_knot = Year2022::Day9::Knot.new(10, 5, 2)
          @third_knot = Year2022::Day9::Knot.new(10, 6, 3)
          @fourth_knot = Year2022::Day9::Knot.new(7, 7, 4)
          @knot = Year2022::Day9::Knot.new(@char_index, @line_index, @ordinal_number, @third_knot, @second_knot)
        end

        def test_touching_with_adjacent_knots?
          assert(@knot.touching_with_adjacent_knots?)
        end

        def test_last_location_and_location_and_location=
          assert_equal([10, 5], @knot.location)
          assert_equal(nil, @knot.last_location)

          @knot.location = [4, 4]
          assert_equal([4, 4], @knot.location)
          assert_equal([10, 5], @knot.last_location)
        end

        def test_to_s
          assert_equal('1', @knot.to_s)
        end

        def test_distance_to_another
          assert_equal(0, @knot.distance_to_another(@second_knot))
          assert_equal(1, @knot.distance_to_another(@third_knot))
          assert_equal(3, @knot.distance_to_another(@fourth_knot))
        end

        def test_overlapping_with_another?
          assert(@knot.overlapping_with_another?(@second_knot))
          refute(@knot.overlapping_with_another?(@third_knot))
          refute(@knot.overlapping_with_another?(@fourth_knot))
        end

        def test_touching_another?
          assert(@knot.touching_another?(@second_knot))
          assert(@knot.touching_another?(@third_knot))
          refute(@knot.touching_another?(@fourth_knot))
        end

        def test_horizontal_distance_to_another
          assert_equal(0, @knot.horizontal_distance_to_another(@second_knot))
          assert_equal(0, @knot.horizontal_distance_to_another(@third_knot))
          assert_equal(3, @knot.horizontal_distance_to_another(@fourth_knot))
        end

        def test_vertical_distance_to_another
          assert_equal(0, @knot.vertical_distance_to_another(@second_knot))
          assert_equal(1, @knot.vertical_distance_to_another(@third_knot))
          assert_equal(2, @knot.vertical_distance_to_another(@fourth_knot))
        end
      end
    end
  end
end
