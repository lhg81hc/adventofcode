require 'test/unit'
require_relative '../../../year2024/day1/radix_sort_extension'

module Year2024
  module Day1
    class RadixSortExtensionTest < Test::Unit::TestCase
      using RadixSortExtension

      def test_radix_sort!
        assert_equal([-1, 170, -35, 45, 75, 90, -802, -24, 2, 66].radix_sort!, [-802, -35, -24, -1, 2, 45, 66, 75, 90, 170])
        assert_equal([3, 4, 2, 1, 6, 7].radix_sort!, [1, 2, 3, 4, 6, 7])
      end
    end
  end
end
