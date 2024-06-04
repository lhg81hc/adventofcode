require 'test/unit'
require_relative '../../../year2022/day5/rearrangement_procedure'
require_relative '../../../year2022/day5/rearrangement_step'

module Year2022
  module Day5
    class RearrangementProcedureTest < Test::Unit::TestCase
      def setup
        @stacks = [%w[Z N], %w[M C D], ['P']]
        @rearrangement_strings = [
          'move 1 from 2 to 1',
          'move 3 from 1 to 3',
          'move 2 from 2 to 1',
          'move 1 from 1 to 2'
        ]

        @rearrangement_steps = @rearrangement_strings.map { |str| Year2022::Day5::RearrangementStep.new(str) }
        @rearrangement_procedure = Year2022::Day5::RearrangementProcedure.new(@stacks, @rearrangement_steps)
      end

      def test_perform
        assert_equal([['C'], ['M'], %w[P D N Z]], @rearrangement_procedure.perform)
      end
    end
  end
end
