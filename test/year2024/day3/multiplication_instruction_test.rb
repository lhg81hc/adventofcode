require 'test/unit'
require_relative '../../../year2024/day3/multiplication_instruction'

module Year2024
  module Day2
    class MultiplicationInstructionTest < Test::Unit::TestCase
      def setup
        @str = 'mul(32,64)'
        @multiplication_instruction = Year2024::Day3::MultiplicationInstruction.new(@str)
      end

      def test_initialization
        assert_equal(@multiplication_instruction.str, 'mul(32,64)')
      end

      def test_valid?
        assert(@multiplication_instruction.valid?)

        invalid_str = 'mul(32,64]'
        @multiplication_instruction = Year2024::Day3::MultiplicationInstruction.new(invalid_str)
        refute(@multiplication_instruction.valid?)
      end

      def test_operands
        assert_equal(@multiplication_instruction.operands, [32, 64])
      end

      def test_left_operand
        assert_equal(@multiplication_instruction.left_operand, 32)
      end

      def test_right_operand
        assert_equal(@multiplication_instruction.right_operand, 64)
      end

      def test_result
        assert_equal(@multiplication_instruction.result, 2048)
      end
    end
  end
end
