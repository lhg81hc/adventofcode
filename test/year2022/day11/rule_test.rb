require 'test/unit'
require_relative '../../../year2022/day11/rule'

module Year2022
  module Day11
    class RuleTest < Test::Unit::TestCase
      def setup
        @rule = Year2022::Day11::Rule.new(19, '1', '3')
      end

      def test_next_monkey_name
        assert_equal('3', @rule.next_monkey_name(20))
        assert_equal('1', @rule.next_monkey_name(361))
      end
    end
  end
end
