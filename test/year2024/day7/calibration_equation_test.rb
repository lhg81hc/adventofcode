require 'test/unit'
require_relative '../../../year2024/day7/calibration_equation'

module Year2024
  module Day7
    class CalibrationEquationTest < Test::Unit::TestCase
      def setup
        @str = '515788378563: 534 195 972'
        @calibration_equation = Year2024::Day7::CalibrationEquation.new(@str)
      end

      def test_initialization
        assert_equal(@calibration_equation.str, '515788378563: 534 195 972')
      end

      def test_test_value
        assert_equal(@calibration_equation.test_value, 515788378563)
      end

      def test_operands
        assert_equal(@calibration_equation.operands, [534, 195, 972])
      end

      def test_all_possible_operations_using_brute_force
        operators = ['+', '*']

        expectation = [
          [534, "+", 195, "+", 972],
          [534, "+", 195, "*", 972],
          [534, "*", 195, "+", 972],
          [534, "*", 195, "*", 972]
        ]
        assert_equal(@calibration_equation.all_possible_operations_using_brute_force([], operators, 1), expectation)

        operators = ['+', '*', '||']

        expectation = [
          [534, "+", 195, "+", 972],
          [534, "+", 195, "*", 972],
          [534, "+", 195, "||", 972],
          [534, "*", 195, "+", 972],
          [534, "*", 195, "*", 972],
          [534, "*", 195, "||", 972],
          [534, "||", 195, "+", 972],
          [534, "||", 195, "*", 972],
          [534, "||", 195, "||", 972]
        ]
        assert_equal(@calibration_equation.all_possible_operations_using_brute_force([], operators, 1), expectation)
      end

      def test_evaluate_operation_without_precedence_rules
        assert_equal(@calibration_equation.evaluate_operations_without_precedence_rules([534, "+", 195, "+", 972, "+", 49]), 1750)
        assert_equal(@calibration_equation.evaluate_operations_without_precedence_rules([6, "*", 8, "||", 6, "*", 15]), 7290)
      end

      def test_adjustable_using_two_operators?
        refute(@calibration_equation.adjustable_using_two_operators?)

        another_calibration_equation = Year2024::Day7::CalibrationEquation.new('3267: 81 40 27')
        assert(another_calibration_equation.adjustable_using_two_operators?)
      end

      def test_adjustable_using_three_operators?
        refute(@calibration_equation.adjustable_using_three_operators?)

        another_calibration_equation = Year2024::Day7::CalibrationEquation.new('3267: 81 40 27')
        assert(another_calibration_equation.adjustable_using_three_operators?)

        another_calibration_equation = Year2024::Day7::CalibrationEquation.new('7290: 6 8 6 15')
        assert(another_calibration_equation.adjustable_using_three_operators?)

        # another_calibration_equation = Year2024::Day7::CalibrationEquation.new('88045337: 4 7 80 453 37')
        # assert(another_calibration_equation.adjustable_using_three_operators?)
      end
    end
  end
end
