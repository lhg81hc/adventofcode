require 'test/unit'
require_relative '../../../year2022/day9/rope'
require_relative '../../../year2022/day9/knot'

module Year2022
  module Day9
    class RopeTest < Test::Unit::TestCase
      class HeadCoversTail < RopeTest
        def setup
          @head = Year2022::Day9::Knot.new(1, 1, '1')
          @second_knot = Year2022::Day9::Knot.new(1, 2, '2')
          @third_knot = Year2022::Day9::Knot.new(1, 3, '3')

          @rope = Year2022::Day9::Rope.new(@head)
          @rope.append_knot(@second_knot)
        end

        def test_head
          assert_equal(@head, @rope.head)
        end

        # def test_current_head_location
        #   assert_equal([1, 1], @rope.current_head_location)
        # end

        def test_append_knot
          assert_equal(@second_knot, @rope.tail)

          @rope.append_knot(@third_knot)

          assert_equal(@third_knot, @rope.tail)
          assert_equal(@third_knot, @second_knot.next_knot)
          assert_equal(@second_knot, @third_knot.prev_knot)
          assert_nil(@third_knot.next_knot)
          # assert_equal(@second_knot, @third_knot.prev_knot)
        end

        def test_find_knot_by_location
          assert_equal(@head, @rope.find_knot_by_location([1, 1]))
          assert_equal(@second_knot, @rope.find_knot_by_location([1, 2]))
        end

        def test_move
          @rope.append_knot(@third_knot)

          @rope.move('U')
          assert_equal([1, 2], @head.location)
          assert_equal([1, 2], @second_knot.location)
          assert_equal([1, 3], @third_knot.location)

          @rope.move('U')
          assert_equal([1, 3], @head.location)
          assert_equal([1, 2], @second_knot.location)
          assert_equal([1, 3], @third_knot.location)

          @rope.move('U')
          assert_equal([1, 4], @head.location)
          assert_equal([1, 3], @second_knot.location)
          assert_equal([1, 3], @third_knot.location)

          # @rope.move('U')
          # assert_equal([1, 5], @head.location)
          # assert_equal([1, 4], @second_knot.location)
          # assert_equal([1, 3], @third_knot.location)
          #
          # @rope.move('U')
          # assert_equal([1, 6], @head.location)
          # assert_equal([1, 5], @second_knot.location)
          # assert_equal([1, 4], @third_knot.location)
        end
      end
    end
  end
end
