module Year2024
  module Day3
    class MultiplicationInstruction
      RE_PATTERN = /mul\(\d+,\d+\)/

      attr_reader :str

      def initialize(str)
        @str = str
      end

      def left_operand
        @left_oprand ||= operands[0]
      end

      def right_operand
        @right_operand ||= operands[1]
      end

      def result
        left_operand * right_operand
      end

      def operands
        raise ArgumentError, "Invalid instruction" unless valid?

        str.scan(/\d+/).map(&:to_i)
      end

      def valid?
        !str.empty? && str.scan(RE_PATTERN).length == 1
      end
    end
  end
end
