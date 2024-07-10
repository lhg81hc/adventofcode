require 'test/unit'
require_relative '../../../year2022/day11/monkey_parser'
require_relative '../../../year2022/day11/keep_away_game'

module Year2022
  module Day11
    class KeepAwayGameTest < Test::Unit::TestCase
      def setup
        lines_0 = [
          'Monkey 0:',
          '  Starting items: 79, 98',
          '  Operation: new = old * 19',
          '  Test: divisible by 23',
          '    If true: throw to monkey 2',
          '    If false: throw to monkey 3'
        ]

        lines_1 = [
          'Monkey 1:',
          '   Starting items: 54, 65, 75, 74',
          '   Operation: new = old + 6',
          '   Test: divisible by 19',
          '     If true: throw to monkey 2',
          '     If false: throw to monkey 0'
        ]

        lines_2 = [
          ' Monkey 2:',
          '   Starting items: 79, 60, 97',
          '   Operation: new = old * old',
          '   Test: divisible by 13',
          '     If true: throw to monkey 1',
          '     If false: throw to monkey 3'
        ]

        lines_3 = [
          ' Monkey 3:',
          '   Starting items: 74',
          '   Operation: new = old + 3',
          '   Test: divisible by 17',
          '     If true: throw to monkey 0',
          '     If false: throw to monkey 1'
        ]

        @monkey_0 = Year2022::Day11::MonkeyParser.parse(lines_0, true)
        @monkey_1 = Year2022::Day11::MonkeyParser.parse(lines_1, true)
        @monkey_2 = Year2022::Day11::MonkeyParser.parse(lines_2, true)
        @monkey_3 = Year2022::Day11::MonkeyParser.parse(lines_3, true)
        @game = Year2022::Day11::KeepAwayGame.new([@monkey_0, @monkey_1, @monkey_2, @monkey_3])
      end

      def test_play_several_rounds!
        @game.play_several_rounds!(20)

        assert_equal(101, @monkey_0.total_inspections)
        assert_equal(95, @monkey_1.total_inspections)
        assert_equal(7, @monkey_2.total_inspections)
        assert_equal(105, @monkey_3.total_inspections)
      end
    end
  end
end
