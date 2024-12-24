require 'test/unit'
require_relative '../../../year2024/day5/safety_manual_update'
require_relative '../../../year2024/day5/page_ordering_rules'
require_relative '../../../year2024/day5/safety_manual_update_correction'

module Year2024
  module Day2
    class SafetyManualUpdateCorrectionTest < Test::Unit::TestCase
      def setup
        @str = '97,13,75,29,47'
        @safety_manual_update = Year2024::Day5::SafetyManualUpdate.new(@str)

        @input_path = File.join(File.dirname(__FILE__), './input.txt')
        @page_ordering_rules = Year2024::Day5::PageOrderingRules.new(@input_path)

        @correction = Year2024::Day5::SafetyManualUpdateCorrection.new(@safety_manual_update, @page_ordering_rules)
      end

      def test_initialization
        assert_equal(@correction.safety_manual_update, @safety_manual_update)
        assert_equal(@correction.page_ordering_rules, @page_ordering_rules)
      end

      def test_correctly_ordered_page_numbers
        assert_equal(@correction.correctly_ordered_page_numbers, ['97', '75', '47', '29', '13'])
      end

      def test_correctly_order_page_numbers_using_backtracking
        assert_equal(@correction.correctly_order_page_numbers_using_backtracking, ['97', '75', '47', '29', '13'])
      end
    end
  end
end
