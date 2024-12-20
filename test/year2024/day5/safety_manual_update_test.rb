require 'test/unit'
require_relative '../../../year2024/day5/safety_manual_update'

module Year2024
  module Day2
    class SafetyManualUpdateTest < Test::Unit::TestCase
      def setup
        @str = '75,47,61,53,29'
        @safety_manual_update = Year2024::Day5::SafetyManualUpdate.new(@str)
      end

      def test_initialization
        assert_equal(@safety_manual_update.str, '75,47,61,53,29')
      end

      def test_page_numbers
        assert_equal(@safety_manual_update.page_numbers, ['75', '47', '61', '53', '29'])
      end

      def test_page_pairs
        expectation = [
          ['75', '47'],
          ['75', '61'],
          ['75', '53'],
          ['75', '29'],
          ['47', '61'],
          ['47', '53'],
          ['47', '29'],
          ['61', '53'],
          ['61', '29'],
          ['53', '29'],
        ]
        assert_equal(@safety_manual_update.page_pairs, expectation)
      end

      def test_middle_page_number
        assert_equal(@safety_manual_update.middle_page_number, '61')
      end
    end
  end
end
