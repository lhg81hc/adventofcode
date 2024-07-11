module Year2022
  module Day11
    class KeepAwayGame
      attr_reader :monkeys

      def initialize(monkeys)
        @monkeys = monkeys
      end

      def monkey_map
        @monkey_map ||= monkeys.each_with_object({}) do |monkey, map|
          map[monkey.name] = monkey
          map
        end
      end

      def play!
        monkeys.each do |monkey|
          monkey.inspect_and_throw_all_holding_items!(absolute_limit).each do |next_item_value, next_monkey_name|
            next_monkey = monkey_map[next_monkey_name]
            next_monkey.catch_item(next_item_value)
          end
        end
      end

      def absolute_limit
        @absolute_limit ||= monkeys.inject(1) { |p, monkey| p *= monkey.rule.divisible_by }
      end
    end
  end
end
