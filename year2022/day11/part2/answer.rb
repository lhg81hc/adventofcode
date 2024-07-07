require_relative '../monkey_parser'

module Year2022
  module Day11
    module Part1
      class Answer
        attr_reader :number_of_rounds

        def initialize
          @number_of_rounds = 10000
        end

        def self.run
          new.run
        end

        def run
          play_game
          inspections = monkeys.values.map(&:total_inspections).sort.reverse
          puts "The level of monkey business after #{number_of_rounds} rounds of stuff-slinging simian shenanigans: " +
                 "#{inspections[0] * inspections[1]}"
        end

        def play_game
          number_of_rounds.times do |n|
            play_a_keep_away_round
            puts_round_result(n + 1)
          end
        end

        def puts_round_result(round_number)
          puts "== After round #{round_number} =="

          monkeys.each do |monkey_name, monkey|
            puts "Monkey #{monkey_name} inspected items #{monkey.total_inspections} times."
          end

          puts "\n"
        end

        def play_a_keep_away_round
          monkeys.each do |_monkey_name, monkey|
            monkey.inspect_and_throw_all_holding_items!(absolute_limit).each do |next_item_value, next_monkey_name|
              next_monkey = monkeys[next_monkey_name]
              next_monkey.catch_item(next_item_value)
            end
          end
        end

        def monkeys
          @monkeys ||=
            begin
              m = {}
              monkey_attribute_lines = []

              File.foreach(input_path) do |line|
                if line.strip.empty?
                  add_monkey(m, monkey_attribute_lines)
                  monkey_attribute_lines = []
                else
                  monkey_attribute_lines << line
                end
              end

              add_monkey(m, monkey_attribute_lines)
              m
            end
        end

        def absolute_limit
          @absolute_limit ||=
            monkeys.values.inject(1) do |p, monkey|
              p *= monkey.rule.divisible_by
              p
            end
        end

        def add_monkey(list, monkey_attribute_lines)
          monkey = Year2022::Day11::MonkeyParser.parse(monkey_attribute_lines, false)
          list[monkey.name] = monkey
        end

        def input_path
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
