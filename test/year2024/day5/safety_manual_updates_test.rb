require 'test/unit'
require_relative '../../../year2024/day5/safety_manual_updates'
require_relative '../../../year2024/day5/safety_manual_update'
require_relative '../../../year2024/day5/page_ordering_rules'

module Year2024
  module Day2
    class SafetyManualUpdatesTest < Test::Unit::TestCase
      def setup
        @input_path = File.join(File.dirname(__FILE__), './input.txt')
        @safety_manual_updates = Year2024::Day5::SafetyManualUpdates.new(@input_path)
      end

      def test_initialization
        assert_equal(@safety_manual_updates.input_path.to_s, @input_path)
      end

      def test_updates
        assert_equal(@safety_manual_updates.updates.length, 6)
        assert(@safety_manual_updates.updates[0].is_a?(Year2024::Day5::SafetyManualUpdate))
        assert_equal(@safety_manual_updates.updates[0].str, '75,47,61,53,29')
        assert(@safety_manual_updates.updates[5].is_a?(Year2024::Day5::SafetyManualUpdate))
        assert_equal(@safety_manual_updates.updates[5].str, '97,13,75,29,47')
      end

      def test_page_ordering_rules
        assert(@safety_manual_updates.page_ordering_rules.is_a?(Year2024::Day5::PageOrderingRules))
      end

      def test_correct_order_updates
        correct_order_updates = @safety_manual_updates.correct_order_updates

        assert_equal(correct_order_updates.length, 3)
        assert(correct_order_updates[0].is_a?(Year2024::Day5::SafetyManualUpdate))
        assert_equal(correct_order_updates[0].str, '75,47,61,53,29')
        assert(correct_order_updates[2].is_a?(Year2024::Day5::SafetyManualUpdate))
        assert_equal(correct_order_updates[2].str, '75,29,13')
      end

      def test_incorrect_order_updates
        incorrect_order_updates = @safety_manual_updates.incorrect_order_updates

        assert_equal(incorrect_order_updates.length, 3)
        assert(incorrect_order_updates[0].is_a?(Year2024::Day5::SafetyManualUpdate))
        assert_equal(incorrect_order_updates[0].str, '75,97,47,61,53')
        assert(incorrect_order_updates[2].is_a?(Year2024::Day5::SafetyManualUpdate))
        assert_equal(incorrect_order_updates[2].str, '97,13,75,29,47')
      end
    end
  end
end
