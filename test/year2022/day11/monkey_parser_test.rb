require 'test/unit'
require_relative '../../../year2022/day11/monkey_parser'

module Year2022
  module Day11
    class MonkeyParserTest < Test::Unit::TestCase
      def setup
        @lines = [
          'Monkey 3:',
          '  Starting items: 74',
          '  Operation: new = old + 3',
          '  Test: divisible by 17',
          '    If true: throw to monkey 0',
          '    If false: throw to monkey 1'
        ]

        @lines2 = [
          'Monkey 7:',
          'Starting items: 94',
          'Operation: new = old * old',
          'Test: divisible by 19',
          'If true: throw to monkey 5',
          'If false: throw to monkey 6'
        ]

        @parser = Year2022::Day11::MonkeyParser.new(@lines)
        @parser2 = Year2022::Day11::MonkeyParser.new(@lines2)
      end

      def test_parse
        monkey = @parser.parse

        assert_equal('3', monkey.name)
        assert_equal([74], monkey.holding_items)
        assert_equal('+', monkey.arithmetic_operator)
        assert_equal(3, monkey.arithmetic_operand)
        assert_equal(17, monkey.divisible_by)
        assert_equal('0', monkey.next_monkey_if_true)
        assert_equal('1', monkey.next_monkey_if_false)

        monkey2 = @parser2.parse

        assert_equal('7', monkey2.name)
        assert_equal([94], monkey2.holding_items)
        assert_equal('*', monkey2.arithmetic_operator)
        assert_equal('old', monkey2.arithmetic_operand)
        assert_equal(19, monkey2.divisible_by)
        assert_equal('5', monkey2.next_monkey_if_true)
        assert_equal('6', monkey2.next_monkey_if_false)
      end
    end
  end
end
