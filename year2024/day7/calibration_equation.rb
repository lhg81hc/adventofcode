module Year2024
  module Day7
    class CalibrationEquation
      PLUS_OPERATOR = '+'.freeze
      MULTIPLICATION_OPERATOR = '*'.freeze
      CONCATENATION_OPERATOR = '||'.freeze

      FIRST_TWO_OPERATORS = [
        PLUS_OPERATOR,
        MULTIPLICATION_OPERATOR
      ].freeze

      ALL_THREE_OPERATORS = [
        PLUS_OPERATOR,
        MULTIPLICATION_OPERATOR,
        CONCATENATION_OPERATOR
      ].freeze

      attr_reader :str

      def initialize(str)
        @str = str
      end

      def test_value
        @test_value ||= str.split(': ')[0]&.to_i
      end

      def operands
        @operands ||= str.split(': ')[1].split(' ').map(&:to_i)
      end

      def adjustable_using_two_operators?
        all_possible_operations_using_brute_force([], FIRST_TWO_OPERATORS, 1).any? do |operation|
          evaluate_operations_without_precedence_rules(operation) == test_value
        end
      end

      def adjustable_using_three_operators?
        all_possible_operations_using_brute_force([], ALL_THREE_OPERATORS, 1).any? do |operation|
          evaluate_operations_without_precedence_rules(operation) == test_value
        end
      end

      def evaluate_operations_without_precedence_rules(operation)
        result = operation.first

        operation.each_with_index do |e, idx|
          if idx.zero?
            result = e
          elsif idx.odd? # it's an operator index
            result = evaluate_operation(result, operation[idx + 1], e)
          end
        end

        result
      end

      def evaluate_operation(left_operand, right_operand, operator)
        case operator
        when '+', '*'
          left_operand.send(operator, right_operand)
        when '||'
          evaluate_concatenate_operation(left_operand, right_operand)
        else
          raise ArgumentError, "Invalid operator #{operator}"
        end
      end

      def evaluate_concatenate_operation(left_operand, right_operand)
        if right_operand <= 10
          left_operand * 10 + (right_operand % 10)
        else
          left_operand * (10 ** (right_operand / 10)) + right_operand
        end
      end

      def all_possible_operations_using_brute_force(r, given_operators, operator_idx)
        return r if operator_idx > operands.length - 1

        t =
          if operator_idx == 1
            given_operators.map do |operator|
              [operands[operator_idx - 1], operator, operands[operator_idx]]
            end
          else
            r.inject([]) do |result, operation|
              given_operators.each do |operator|
                operation_dup = operation.dup
                operation_dup << operator
                operation_dup << operands[operator_idx]

                result << operation_dup
              end

              result
            end
          end

        all_possible_operations_using_brute_force(t, given_operators, operator_idx + 1)
      end
    end
  end
end
