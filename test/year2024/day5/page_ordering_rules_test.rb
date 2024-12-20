require 'test/unit'
require_relative '../../../year2024/day5/page_ordering_rules'

module Year2024
  module Day2
    class PageOrderingRulesTest < Test::Unit::TestCase
      def setup
        @input_path = File.join(File.dirname(__FILE__), './input.txt')
        @page_ordering_rule = Year2024::Day5::PageOrderingRules.new(@input_path)
      end

      def test_initialization
        assert_equal(@page_ordering_rule.input_path.to_s, File.join(File.dirname(__FILE__), './input.txt'))
      end

      def test_rules
        assert(@page_ordering_rule.rules.is_a?(Hash))
        assert_equal(@page_ordering_rule.rules['47|53'], 1)
        assert_equal(@page_ordering_rule.rules['53|47'], -1)
        assert_equal(@page_ordering_rule.rules['53|13'], 1)
        assert_equal(@page_ordering_rule.rules['13|53'], -1)
        assert_nil(@page_ordering_rule.rules['1|2'])
      end

      def test_order
        assert_equal(@page_ordering_rule.order(97, 29), 1)
        assert_equal(@page_ordering_rule.order(61, 47), -1)
        assert_equal(@page_ordering_rule.order(88, 22), 0)
      end

      def test_right_order?
        assert(@page_ordering_rule.right_order?(97, 29))
        refute(@page_ordering_rule.right_order?(61, 47))
      end
    end
  end
end
