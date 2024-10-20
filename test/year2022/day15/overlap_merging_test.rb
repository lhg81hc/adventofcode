require 'test/unit'
require_relative '../../../year2022/day15/overlap_merging'

module Year2022
  module Day15
    class OverlapMergingTest < Test::Unit::TestCase
      def setup
        @object = Object.new
        @object.extend(OverlapMerging)
      end

      def test_merge_overlap
        arr = [[1, 3], [2, 4], [6, 8], [9, 10]]
        another_arr = [[6, 8], [1, 9], [2, 4], [4, 7]]

        assert_equal([[1, 4], [6, 8], [9, 10]], @object.merge_overlap(arr))
        assert_equal([[1, 3], [2, 4], [6, 8], [9, 10]], arr)
        assert_equal([[1, 9]], @object.merge_overlap(another_arr))
        assert_equal([[6, 8], [1, 9], [2, 4], [4, 7]], another_arr)
      end

      def test_merge_overlap!
        arr = [[1, 3], [2, 4], [6, 8], [9, 10]]
        another_arr = [[6, 8], [1, 9], [2, 4], [4, 7]]

        assert_equal([[1, 4], [6, 8], [9, 10]], @object.merge_overlap!(arr))
        assert_equal([[1, 4], [6, 8], [9, 10]], arr)
        assert_equal([[1, 9]], @object.merge_overlap!(another_arr))
        assert_equal([[1, 9]], another_arr)
      end
    end
  end
end
