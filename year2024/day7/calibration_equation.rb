require 'pry'

module Year2024
  module Day7
    class CalibrationEquation
      PLUS_OPERATOR = '+'.freeze
      MULTIPLICATION_OPERATOR = '*'.freeze

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

      def adjustable?
        all_possible_operations_using_brute_force([], operands, 1).each do |operation|
          return true if evaluate_operation_without_precedence_rules(operation) == test_value
        end

        false
      end

      def evaluate_operation_without_precedence_rules(operation)
        (0..operation.length - 1).inject(0) do |result, idx|
          if idx.zero?
            result += operation[idx]
          elsif idx.even?
            operator = operation[idx - 1]
            operand = operation[idx]
            result = result.send(operator, operand)
          end
          result
        end
      end

      def possible_operations_using_brute_force
        all_possible_operations_using_brute_force([], operands, 1)
      end

      def all_possible_operations_using_brute_force(r, given_operands, operator_count)
        return r if operator_count > given_operands.length - 1

        t =
          if operator_count == 1
            [PLUS_OPERATOR, MULTIPLICATION_OPERATOR].map do |operator|
              [given_operands[operator_count - 1], operator, given_operands[operator_count]]
            end
          else
            r.inject([]) do |result, operation|
              [PLUS_OPERATOR, MULTIPLICATION_OPERATOR].each do |operator|
                operation_dup = operation.dup
                operation_dup << operator
                operation_dup << given_operands[operator_count]

                result << operation_dup
              end

              result
            end
          end

        all_possible_operations_using_brute_force(t, given_operands, operator_count + 1)
      end
    end
  end
end
