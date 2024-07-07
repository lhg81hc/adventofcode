require 'test/unit'
require_relative '../../../year2022/day11/operation.rb'

module Year2022
  module Day11
    class OperationTest < Test::Unit::TestCase
      def setup
        @operation_multiplication = Year2022::Day11::Operation.new('*', 3)
        @operation_addition = Year2022::Day11::Operation.new('+', 5)
        @operation_square = Year2022::Day11::Operation.new('*', 'old')
      end

      def test_initialization
        assert_equal '*', @operation_multiplication.arithmetic_operator
        assert_equal 3, @operation_multiplication.arithmetic_operand
        assert_equal '+', @operation_addition.arithmetic_operator
        assert_equal 5, @operation_addition.arithmetic_operand
      end

      def test_type
        assert_equal :multiplication, @operation_multiplication.type
        assert_equal :addition, @operation_addition.type
        assert_raises(ArgumentError) { Operation.new('-', 2).type }
      end

      def test_multiplication?
        assert @operation_multiplication.multiplication?
        refute @operation_addition.multiplication?
      end

      def test_addition?
        assert @operation_addition.addition?
        refute @operation_multiplication.addition?
      end

      def test_square?
        assert @operation_square.square?
        refute @operation_multiplication.square?
        refute @operation_addition.square?
      end

      def test_next_value
        assert_equal 9, @operation_multiplication.next_value(3)
        assert_equal 8, @operation_addition.next_value(3)
        assert_equal 16, @operation_square.next_value(4)
      end
    end
  end
end
