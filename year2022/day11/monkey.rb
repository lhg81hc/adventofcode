module Year2022
  module Day11
    class Monkey
      RELIEVED_SCALE = 3

      attr_reader :name, :operation, :rule, :total_inspections
      attr_accessor :holding_items, :relieved

      def initialize(name, holding_items, operation, rule, relieved = false)
        @name = name
        @holding_items = holding_items
        @operation = operation
        @rule = rule
        @relieved = relieved
        @total_inspections = 0
      end

      def catch_item(item)
        @holding_items << item
      end

      def inspect_and_throw_all_holding_items!(absolute_limit = nil)
        l = []
        item_value = @holding_items.shift

        while item_value
          @total_inspections += 1
          l << inspect_and_throw_item(item_value, absolute_limit)
          item_value = @holding_items.shift
        end

        l
      end

      private

      def inspect_and_throw_item(item_value, absolute_limit = nil)
        next_item_value = next_item_value_after_inspect(item_value, absolute_limit)
        next_monkey_name = rule.next_monkey_name(next_item_value)

        [next_item_value, next_monkey_name]
      end

      def next_item_value_after_inspect(item_value, absolute_limit = nil)
        v = operation.next_value(item_value)
        v = v % absolute_limit unless absolute_limit.nil?
        v = v / RELIEVED_SCALE if relieved
        v
      end
    end
  end
end
