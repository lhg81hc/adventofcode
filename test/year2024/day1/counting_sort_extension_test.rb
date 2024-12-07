require 'test/unit'
require_relative '../../../year2024/day1/counting_sort_extension'

module Year2024
  module Day1
    class CountingSortExtensionTest < Test::Unit::TestCase
      using CountingSortExtension

      def test_radix_sort!
        assert_equal([2, 5, 3, 0, 2, 3, 0, 3].counting_sort!, [0, 0, 2, 2, 3, 3, 3, 5])
      end
    end
  end
end
