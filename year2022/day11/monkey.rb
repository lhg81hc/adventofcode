module Year2022
  module Day11
    class Monkey
      attr_reader :name, :arithmetic_operator, :arithmetic_operand, :divisible_by,
                  :next_monkey_if_false, :next_monkey_if_true, :total_inspections
      attr_accessor :holding_items, :relieved

      def initialize(name, holding_items, arithmetic_operator, arithmetic_operand, divisible_by, next_monkey_if_true, next_monkey_if_false, relieved = true)
        @name = name
        @holding_items = holding_items
        @arithmetic_operator = arithmetic_operator
        @arithmetic_operand = arithmetic_operand
        @divisible_by = divisible_by
        @next_monkey_if_true = next_monkey_if_true
        @next_monkey_if_false = next_monkey_if_false
        @total_inspections = 0
        @relieved = relieved
      end

      def catch_item(item)
        @holding_items << item
      end

      def next_item_value_after_inspect(item_index)
        item_value = holding_items[item_index]
        operand = arithmetic_operand == 'old' ? item_value : arithmetic_operand

        next_item_value =
          case arithmetic_operator
          when '+'
            item_value + operand
          when '-'
            item_value - operand
          when '*'
            item_value * operand
          when '/'
            item_value / operand
          else
            raise ArgumentError, "Invalid operator #{arithmetic_operator}"
          end

        relieved ? next_item_value / 3 : next_item_value
      end

      def to_monkey_name(value)
        (value % divisible_by).zero? ? next_monkey_if_true : next_monkey_if_false
      end

      def inspect_and_throw_item(item_index)
        next_item_value = next_item_value_after_inspect(item_index)
        next_monkey_name = to_monkey_name(next_item_value)

        [next_item_value, next_monkey_name]
      end

      def inspect_and_throw_all_holding_items!
        l =
          holding_items.map.with_index do |_item, item_index|
            @total_inspections += 1
            inspect_and_throw_item(item_index)
          end

        @holding_items = []

        l
      end
    end
  end
end
