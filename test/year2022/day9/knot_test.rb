require 'test/unit'
require_relative '../../../year2022/day9/knot'

module Year2022
  module Day9
    class KnotTest < Test::Unit::TestCase
      class ValidInput < KnotTest
        def setup
          @char_index = 10
          @line_index = 5
          @name = 1

          @second_knot = Year2022::Day9::Knot.new(10, 5, 2)
          @third_knot = Year2022::Day9::Knot.new(10, 6, 3)
          @fourth_knot = Year2022::Day9::Knot.new(7, 7, 4)
          @knot = Year2022::Day9::Knot.new(@char_index, @line_index, @name, @third_knot, @second_knot)
        end

        def test_location_and_location=
          assert_equal([10, 5], @knot.location)

          @knot.location = [4, 4]
          assert_equal([4, 4], @knot.location)
        end

        def test_to_s
          assert_equal('1', @knot.to_s)
        end

        def test_overlapping_with_another_knot?
          assert(@knot.overlapping_with_another_knot?(@second_knot))
          refute(@knot.overlapping_with_another_knot?(@third_knot))
          refute(@knot.overlapping_with_another_knot?(@fourth_knot))
        end

        def test_horizontal_distance_to_another_knot
          assert_equal(0, @knot.horizontal_distance_to_another_knot(@second_knot))
          assert_equal(0, @knot.horizontal_distance_to_another_knot(@third_knot))
          assert_equal(3, @knot.horizontal_distance_to_another_knot(@fourth_knot))
        end

        def test_vertical_distance_to_another_knot
          assert_equal(0, @knot.vertical_distance_to_another_knot(@second_knot))
          assert_equal(1, @knot.vertical_distance_to_another_knot(@third_knot))
          assert_equal(2, @knot.vertical_distance_to_another_knot(@fourth_knot))
        end

        def test_next_location_by_direction
          assert_equal([10, 6], @knot.next_location_by_direction('U'))
          assert_equal([10, 4], @knot.next_location_by_direction('D'))
          assert_equal([9, 5], @knot.next_location_by_direction('L'))
          assert_equal([11, 5], @knot.next_location_by_direction('R'))
        end

        def test_next_location_to_follow_head_knot
          head_knot = Year2022::Day9::Knot.new(10, 5, 'H')
          assert_equal([10, 5], @knot.next_location_to_follow_head_knot(head_knot))

          # Horizontal differences
          head_knot = Year2022::Day9::Knot.new(8, 5, 'H')
          assert_equal([9, 5], @knot.next_location_to_follow_head_knot(head_knot))

          head_knot = Year2022::Day9::Knot.new(12, 5, 'H')
          assert_equal([11, 5], @knot.next_location_to_follow_head_knot(head_knot))

          # vertical differences
          head_knot = Year2022::Day9::Knot.new(10, 3, 'H')
          assert_equal([10, 4], @knot.next_location_to_follow_head_knot(head_knot))

          head_knot = Year2022::Day9::Knot.new(10, 7, 'H')
          assert_equal([10, 6], @knot.next_location_to_follow_head_knot(head_knot))

          # touching
          head_knot = Year2022::Day9::Knot.new(11, 6, 'H')
          assert_equal([10, 5], @knot.next_location_to_follow_head_knot(head_knot))

          # diagonal differences
          head_knot = Year2022::Day9::Knot.new(12, 6, 'H')
          assert_equal([11, 6], @knot.next_location_to_follow_head_knot(head_knot))

          head_knot = Year2022::Day9::Knot.new(9, 3, 'H')
          assert_equal([9, 4], @knot.next_location_to_follow_head_knot(head_knot))

          head_knot = Year2022::Day9::Knot.new(12, 7, 'H')
          assert_raises(ArgumentError) { @knot.next_location_to_follow_head_knot(head_knot) }
        end
      end
    end
  end
end
