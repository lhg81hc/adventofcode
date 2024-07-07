module Year2022
  module Day11
    class Rule
      attr_reader :divisible_by, :next_monkey_if_true, :next_monkey_if_false

      def initialize(divisible_by, next_monkey_if_true, next_monkey_if_false)
        @divisible_by = divisible_by
        @next_monkey_if_true = next_monkey_if_true
        @next_monkey_if_false = next_monkey_if_false
      end

      def next_monkey_name(item_value)
        (item_value % divisible_by).zero? ? next_monkey_if_true : next_monkey_if_false
      end
    end
  end
end
