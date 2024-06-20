require 'test/unit'
require_relative '../../../year2022/day9/rope'
require_relative '../../../year2022/day9/knot'

module Year2022
  module Day9
    class RopeTest < Test::Unit::TestCase
      def setup
        @head = Year2022::Day9::Knot.new(0, 0, 'H')
        @second_knot = Year2022::Day9::Knot.new(1, 2, '2')
        @rope = Year2022::Day9::Rope.new(@head)
      end

      def test_head
        assert_equal(@head, @rope.head)
      end

      def test_append_knot
        assert_equal(@head, @rope.tail)

        @rope.append_knot(@second_knot)
        assert_equal(@second_knot, @rope.tail)
        assert_equal(@second_knot, @head.next_knot)
        assert_equal(@head, @second_knot.prev_knot)
        assert_nil(@second_knot.next_knot)
      end

      def test_move_when_2_knots
        tail = Year2022::Day9::Knot.new(0, 0, 'T')
        @rope.append_knot(tail)

        assert_equal(2, @rope.length)

        4.times { @rope.move('R') }
        assert_equal([4, 0], @rope.head.location)
        assert_equal([3, 0], @rope.tail.location)

        4.times { @rope.move('U') }
        assert_equal([4, 4], @rope.head.location)
        assert_equal([4, 3], @rope.tail.location)

        3.times { @rope.move('L') }
        assert_equal([1, 4], @rope.head.location)
        assert_equal([2, 4], @rope.tail.location)
      end

      def test_move
        (1..9).each do |i|
          new_knot = Year2022::Day9::Knot.new(0, 0, i.to_s)
          @rope.append_knot(new_knot)
        end

        assert_equal(10, @rope.length)
        assert_equal([0, 0], @rope.head.location)
        assert_equal([0, 0], @rope.tail.location)

        5.times { @rope.move('R') }
        assert_equal([5, 0], @rope.head.location)
        assert_equal([0, 0], @rope.tail.location)

        8.times { @rope.move('U') }
        assert_equal([5, 8], @rope.head.location)
        assert_equal([0, 0], @rope.tail.location)
      end
    end
  end
end
