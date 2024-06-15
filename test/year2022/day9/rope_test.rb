require 'test/unit'
require_relative '../../../year2022/day9/rope'

module Year2022
  module Day9
    class RopeTest < Test::Unit::TestCase
      class HeadCoversTail < RopeTest
        def setup
          @first_knot = Year2022::Day9::Knot.new(1, 1, '1')
          @second_knot = Year2022::Day9::Knot.new(1, 2, '2')
          @third_knot = Year2022::Day9::Knot.new(1, 3, '3')

          @rope = Year2022::Day9::Rope.new([@first_knot, @second_knot, @third_knot])
        end

        def test_head
          assert_equal(@first_knot, @rope.head)
        end

        def test_tail
          assert_equal(@third_knot, @rope.tail)
        end

        def test_current_head_location
          assert_equal([1, 1], @rope.current_head_location)
        end

        def test_next_head_location
          assert_equal([1, 2], @rope.next_head_location('U'))
          assert_equal([1, 0], @rope.next_head_location('D'))
          assert_equal([0, 1], @rope.next_head_location('L'))
          assert_equal([2, 1], @rope.next_head_location('R'))
        end

        def test_move
          @rope.move('U')
          assert_equal([1, 2], @rope.knots[0].location)
          assert_equal([1, 2], @rope.knots[1].location)
          assert_equal([1, 3], @rope.knots[2].location)

          @rope.move('U')
          assert_equal([1, 3], @rope.knots[0].location)
          assert_equal([1, 2], @rope.knots[1].location)
          assert_equal([1, 3], @rope.knots[2].location)

          @rope.move('U')
          assert_equal([1, 4], @rope.knots[0].location)
          assert_equal([1, 3], @rope.knots[1].location)
          assert_equal([1, 3], @rope.knots[2].location)

          @rope.move('U')
          assert_equal([1, 5], @rope.knots[0].location)
          assert_equal([1, 4], @rope.knots[1].location)
          assert_equal([1, 3], @rope.knots[2].location)

          @rope.move('U')
          assert_equal([1, 6], @rope.knots[0].location)
          assert_equal([1, 5], @rope.knots[1].location)
          assert_equal([1, 4], @rope.knots[2].location)
        end
      end
    end
  end
end
