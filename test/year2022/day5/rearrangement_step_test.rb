require 'test/unit'
require_relative '../../../year2022/day5/rearrangement_step'

module Year2022
  module Day5
    class RearrangementStepTest < Test::Unit::TestCase
      def setup
        @str = 'move 15 from 7 to 9'
        @rearrangement_step = Year2022::Day5::RearrangementStep.new(@str)
      end

      def test_parsed_numbers
        assert_equal([15, 7, 9], @rearrangement_step.parsed_numbers)
      end

      def test_number_of_crates
        assert_equal(15, @rearrangement_step.number_of_crates)
      end

      def test_from_stack_number
        assert_equal(7, @rearrangement_step.from_stack_number)
      end

      def test_to_stack_number
        assert_equal(9, @rearrangement_step.to_stack_number)
      end
    end
  end
end
