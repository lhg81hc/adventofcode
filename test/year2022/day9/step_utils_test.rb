require 'test/unit'
require_relative '../../../year2022/day9/rope'

module Year2022
  module Day9
    class StepUtilsTest < Test::Unit::TestCase
      def setup
        @head = Year2022::Day9::RopeKnot.new(1, 1, :head)
        @tail = Year2022::Day9::RopeKnot.new(1, 1, :tail)
        @rope = Year2022::Day9::Rope.new(@head, @tail)
      end

      def test_current_head_location
        assert_equal([1, 1], @rope.current_head_location)
      end

      def test_move_up
        assert_equal([1, 1], @rope.head.location)
        assert_equal([1, 1], @rope.tail.location)

        @rope.move('U')

        assert_equal([1, 2], @rope.head.location)
        assert_equal([1, 1], @rope.tail.location)

        @rope.move('U')

        assert_equal([1, 3], @rope.head.location)
        assert_equal([1, 2], @rope.tail.location)
      end

      def test_move_down
        assert_equal([1, 1], @rope.head.location)
        assert_equal([1, 1], @rope.tail.location)

        @rope.move('D')

        assert_equal([1, 0], @rope.head.location)
        assert_equal([1, 1], @rope.tail.location)

        @rope.move('D')

        assert_equal([1, -1], @rope.head.location)
        assert_equal([1, 0], @rope.tail.location)
      end

      def test_move_left
        assert_equal([1, 1], @rope.head.location)
        assert_equal([1, 1], @rope.tail.location)

        @rope.move('L')

        assert_equal([0, 1], @rope.head.location)
        assert_equal([1, 1], @rope.tail.location)

        @rope.move('L')

        assert_equal([-1, 1], @rope.head.location)
        assert_equal([0, 1], @rope.tail.location)
      end

      def test_move_right
        assert_equal([1, 1], @rope.head.location)
        assert_equal([1, 1], @rope.tail.location)

        @rope.move('R')

        assert_equal([2, 1], @rope.head.location)
        assert_equal([1, 1], @rope.tail.location)

        @rope.move('R')

        assert_equal([3, 1], @rope.head.location)
        assert_equal([2, 1], @rope.tail.location)
      end
    end
  end
end
