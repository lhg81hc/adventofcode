require 'test/unit'
require_relative '../../../year2022/day9/rope'

module Year2022
  module Day9
    class RopeTest < Test::Unit::TestCase
      class HeadCoversTail < RopeTest
        def setup
          @head = Year2022::Day9::RopeKnot.new(1, 1, :head)
          @tail = Year2022::Day9::RopeKnot.new(1, 1, :tail)
          @rope = Year2022::Day9::Rope.new(@head, @tail)
        end

        def test_length
          assert_equal(0, @rope.length)
        end

        def test_head_covers_tail?
          assert(@rope.head_covers_tail?)
        end

        def test_two_ends_overlapping?
          assert(@rope.two_ends_overlapping?)
        end

        def test_two_ends_touching?
          assert(@rope.two_ends_touching?)
        end

        def horizontal_diff_between_head_and_tail
          assert_equal(0, @rope.horizontal_diff_between_head_and_tail)
        end

        def vertical_diff_between_head_and_tail
          assert_equal(0, @rope.vertical_diff_between_head_and_tail)
        end
      end

      class HeadNextToTail < RopeTest
        def setup
          @head = Year2022::Day9::RopeKnot.new(-2, -1, :head)
          @tail = Year2022::Day9::RopeKnot.new(-1, -1, :tail)
          @rope = Year2022::Day9::Rope.new(@head, @tail)
        end

        def test_length
          assert_equal(1, @rope.length)
        end

        def test_head_covers_tail?
          refute(@rope.head_covers_tail?)
        end

        def test_two_ends_overlapping?
          refute(@rope.two_ends_overlapping?)
        end

        def test_two_ends_touching?
          assert(@rope.two_ends_touching?)
        end

        def horizontal_diff_between_head_and_tail
          assert_equal(1, @rope.horizontal_diff_between_head_and_tail)
        end

        def vertical_diff_between_head_and_tail
          assert_equal(0, @rope.vertical_diff_between_head_and_tail)
        end
      end

      class HeadFarAwayFromTail < RopeTest
        def setup
          @head = Year2022::Day9::RopeKnot.new(-2, -1, :head)
          @tail = Year2022::Day9::RopeKnot.new(0, 0, :tail)
          @rope = Year2022::Day9::Rope.new(@head, @tail)
        end

        def test_length
          assert_equal(2, @rope.length)
        end

        def test_head_covers_tail?
          refute(@rope.head_covers_tail?)
        end

        def test_two_ends_overlapping?
          refute(@rope.two_ends_overlapping?)
        end

        def test_two_ends_touching?
          refute(@rope.two_ends_touching?)
        end

        def horizontal_diff_between_head_and_tail
          assert_equal(2, @rope.horizontal_diff_between_head_and_tail)
        end

        def vertical_diff_between_head_and_tail
          assert_equal(1, @rope.vertical_diff_between_head_and_tail)
        end
      end
    end
  end
end
