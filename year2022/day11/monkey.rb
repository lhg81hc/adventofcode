module Year2022
  module Day11
    class Monkey
      attr_reader :name, :holding_items, :arithmetic_operator, :arithmetic_operand, :divisible_by, :next_monkey_if_false, :next_monkey_if_true

      def initialize(name, holding_items, arithmetic_operator, arithmetic_operand, divisible_by, next_monkey_if_true, next_monkey_if_false)
        @name = name
        @holding_items = holding_items
        @arithmetic_operator = arithmetic_operator
        @arithmetic_operand = arithmetic_operand
        @divisible_by = divisible_by
        @next_monkey_if_true = next_monkey_if_true
        @next_monkey_if_false = next_monkey_if_false
      end
    end
  end
end
