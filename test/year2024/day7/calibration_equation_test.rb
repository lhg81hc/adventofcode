require 'test/unit'
require_relative '../../../year2024/day7/calibration_equation'

module Year2024
  module Day7
    class CalibrationEquationTest < Test::Unit::TestCase
      def setup
        @str = '515788378563: 534 195 972 49'
        @calibration_equation = Year2024::Day7::CalibrationEquation.new(@str)
      end

      def test_initialization
        assert_equal(@calibration_equation.str, '515788378563: 534 195 972 49')
      end

      def test_test_value
        assert_equal(@calibration_equation.test_value, 515788378563)
      end

      def test_operands
        assert_equal(@calibration_equation.operands, [534, 195, 972, 49])
      end

      def test_all_possible_operations_using_brute_force
        expectation = [
          [534, "+", 195],
          [534, "*", 195]
        ]
        assert_equal(@calibration_equation.all_possible_operations_using_brute_force([], [534, 195], 1), expectation)

        expectation = [
          [534, "+", 195, "+", 972],
          [534, "+", 195, "*", 972],
          [534, "*", 195, "+", 972],
          [534, "*", 195, "*", 972]
        ]
        assert_equal(@calibration_equation.all_possible_operations_using_brute_force([], [534, 195, 972], 1), expectation)
      end

      def test_possible_operations_using_brute_force
        expectation = [
          [534, "+", 195, "+", 972, "+", 49],
          [534, "+", 195, "+", 972, "*", 49],
          [534, "+", 195, "*", 972, "+", 49],
          [534, "+", 195, "*", 972, "*", 49],
          [534, "*", 195, "+", 972, "+", 49],
          [534, "*", 195, "+", 972, "*", 49],
          [534, "*", 195, "*", 972, "+", 49],
          [534, "*", 195, "*", 972, "*", 49]
        ]
        assert_equal(@calibration_equation.possible_operations_using_brute_force, expectation)
      end

      def test_evaluate_operation_without_precedence_rules
        assert_equal(@calibration_equation.evaluate_operation_without_precedence_rules([534, "+", 195, "+", 972, "+", 49]), 1750)
      end

      def test_adjustable?
        refute(@calibration_equation.adjustable?)

        another_calibration_equation = Year2024::Day7::CalibrationEquation.new('3267: 81 40 27')
        assert(another_calibration_equation.adjustable?)
      end
    end
  end
end
