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

      def play_several_rounds!(number_of_rounds, print_round_result: false)
        number_of_rounds.times do |n|
          round_number = n + 1

          play_one_round!
          puts_round_result(round_number) if printable_round(round_number) && print_round_result
        end
      end

      def play_one_round!
        monkeys.each do |monkey|
          monkey.inspect_and_throw_all_holding_items!(absolute_limit).each do |next_item_value, next_monkey_name|
            next_monkey = monkey_map[next_monkey_name]
            next_monkey.catch_item(next_item_value)
          end
        end
      end

      def puts_round_result(round_number)
        puts "== After round #{round_number} =="

        monkeys.each do |monkey|
          puts "Monkey #{monkey.name} inspected items #{monkey.total_inspections} times."
        end

        puts "\n"
      end

      def absolute_limit
        @absolute_limit ||= monkeys.inject(1) { |p, monkey| p *= monkey.rule.divisible_by }
      end

      def printable_round(round_number)
        round_number == 1 || (round_number == 20) || (round_number % 1000).zero?
      end
    end
  end
end
