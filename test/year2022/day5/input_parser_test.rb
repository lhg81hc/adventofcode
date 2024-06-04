require 'test/unit'
require_relative '../../../year2022/day5/input_parser'

module Year2022
  module Day5
    class InputParserTest < Test::Unit::TestCase
      def setup
        @filepath = File.join(File.dirname(__FILE__), 'input.txt')
        @input_parser = Year2022::Day5::InputParser.new(@filepath)
      end

      def test_ordinal_numbers?
        assert(@input_parser.ordinal_numbers?('123'))
        assert(@input_parser.ordinal_numbers?(' 1  2  3'))
        refute(@input_parser.ordinal_numbers?('            [J]             [B] [W]'))
        refute(@input_parser.ordinal_numbers?(''))
        refute(@input_parser.ordinal_numbers?('move 3 from 2 to 1'))
      end

      def test_rearrangement_step?
        assert(@input_parser.rearrangement_step?('move 3 from 2 to 1'))
        assert(@input_parser.rearrangement_step?('move'))
        refute(@input_parser.rearrangement_step?(''))
        refute(@input_parser.rearrangement_step?('            [J]             [B] [W]'))
        refute(@input_parser.rearrangement_step?(' 1  2'))
      end

      def test_stack_columns?
        assert(@input_parser.stack_columns?('            [J]             [B] [W]'))
        assert(@input_parser.stack_columns?('[A]'))
        refute(@input_parser.stack_columns?('move 3 from 2 to 1'))
        refute(@input_parser.stack_columns?(''))
        refute(@input_parser.stack_columns?(' 1  2'))
      end

      def test_build_stacks
        line1 = '[Z] [M] [P]'
        line2 = '    [D]'
        line3 = '        [A]'

        assert_equal([], @input_parser.stacks)

        @input_parser.build_stacks(line1)
        assert_equal([['Z'], ['M'], ['P']], @input_parser.stacks)

        @input_parser.build_stacks(line2)
        assert_equal([['Z'], %w[D M], ['P']], @input_parser.stacks)

        @input_parser.build_stacks(line3)
        assert_equal([['Z'], %w[D M], %w[A P]], @input_parser.stacks)
      end

      def test_parse
        @input_parser.parse

        assert_equal([%w[Z N], %w[M C D], ['P']], @input_parser.stacks)
        assert(@input_parser.rearrangement_steps.first.is_a?(Year2022::Day5::RearrangementStep))
        assert_equal('move 1 from 2 to 1', @input_parser.rearrangement_steps.first.str)
        assert(@input_parser.rearrangement_steps.last.is_a?(Year2022::Day5::RearrangementStep))
        assert_equal('move 1 from 1 to 2', @input_parser.rearrangement_steps.last.str)
      end
    end
  end
end
