require 'test/unit'
require_relative '../../../year2022/day5/crane'
require_relative '../../../year2022/day5/rearrangement_step'

module Year2022
  module Day5
    class CraneTest < Test::Unit::TestCase
      def setup
        @stacks = [%w[Z N], %w[M C D], ['P']]
        @rearrangement_strings = [
          'move 1 from 2 to 1',
          'move 3 from 1 to 3',
          'move 2 from 2 to 1',
          'move 1 from 1 to 2'
        ]

        @rearrangement_steps = @rearrangement_strings.map { |str| Year2022::Day5::RearrangementStep.new(str) }
        @crane = Year2022::Day5::Crane.new(@stacks)
      end

      def test_move_one_by_one
        @crane.move_one_by_one(@rearrangement_steps[0])
        assert_equal([%w[Z N D], %w[M C], ['P']], @stacks)

        @crane.move_one_by_one(@rearrangement_steps[1])
        assert_equal([[], %w[M C], %w[P D N Z]], @stacks)

        @crane.move_one_by_one(@rearrangement_steps[2])
        assert_equal([%w[C M],[], %w[P D N Z]], @stacks)

        @crane.move_one_by_one(@rearrangement_steps[3])
        assert_equal([['C'],['M'], %w[P D N Z]], @stacks)
      end

      def test_move_multiple_at_once
        @crane.move_multiple_at_once(@rearrangement_steps[0])
        assert_equal([%w[Z N D], %w[M C], ['P']], @stacks)

        @crane.move_multiple_at_once(@rearrangement_steps[1])
        assert_equal([[], %w[M C], %w[P Z N D]], @stacks)

        @crane.move_multiple_at_once(@rearrangement_steps[2])
        assert_equal([%w[M C], [], %w[P Z N D]], @stacks)

        @crane.move_multiple_at_once(@rearrangement_steps[3])
        assert_equal([['M'], ['C'], %w[P Z N D]], @stacks)
      end
    end
  end
end
