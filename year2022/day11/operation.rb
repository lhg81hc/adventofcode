module Year2022
  module Day11
    class Operation
      OLD_OPERAND = 'old'.freeze
      MULTIPLICATION_OPERATOR = '*'.freeze
      ADDITION_OPERATOR = '+'.freeze

      attr_reader :arithmetic_operator, :arithmetic_operand, :relieved

      def initialize(arithmetic_operator, arithmetic_operand)
        @arithmetic_operator = arithmetic_operator
        @arithmetic_operand = arithmetic_operand
      end

      def type
        case arithmetic_operator
        when MULTIPLICATION_OPERATOR
          :multiplication
        when ADDITION_OPERATOR
          :addition
        else
          raise ArgumentError, "Unknown operator #{arithmetic_operator}"
        end
      end

      def multiplication?
        type == :multiplication
      end

      def addition?
        type == :addition
      end

      def square?
        multiplication? && arithmetic_operand == OLD_OPERAND
      end

      def next_value(curr_value)
        if square?
          curr_value * curr_value
        else
          curr_value.send(arithmetic_operator, arithmetic_operand)
        end
      end
    end
  end
end
