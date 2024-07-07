require 'test/unit'
require_relative '../../../year2022/day11/monkey'
require_relative '../../../year2022/day11/rule'
require_relative '../../../year2022/day11/operation'

module Year2022
  module Day11
    class MonkeyTest < Test::Unit::TestCase
      def setup
        @rule = Year2022::Day11::Rule.new(23, '2', '3')
        @operation = Year2022::Day11::Operation.new('*', 19)
        @monkey = Year2022::Day11::Monkey.new(
          '0',
          [79, 98],
          @operation,
          @rule,
        )
      end

      def test_catch_item
        assert_equal([79, 98], @monkey.holding_items)
        @monkey.catch_item(100)
        assert_equal([79, 98, 100], @monkey.holding_items)
      end

      def test_inspect_and_throw_all_holding_items!
        assert_equal([[1501, '3'], [1862, '3']], @monkey.inspect_and_throw_all_holding_items!)

        @monkey.catch_item(46)
        assert_equal([[874, '2']], @monkey.inspect_and_throw_all_holding_items!)

        @monkey.catch_item(2022)
        assert_equal([[18, '3']], @monkey.inspect_and_throw_all_holding_items!(200))

        @monkey.catch_item(2022)
        @monkey.relieved = true
        assert_equal([[6, '3']], @monkey.inspect_and_throw_all_holding_items!(200))
      end
    end
  end
end
