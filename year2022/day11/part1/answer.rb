require_relative '../monkey_parser'

module Year2022
  module Day11
    module Part1
      class Answer
        attr_reader :number_of_rounds

        def initialize
          @number_of_rounds = 20
          @round_result = []
        end

        def self.run
          new.run
        end

        def run
          (1..number_of_rounds).each do |n|
            play_a_keep_away_round
            puts_round_result(n)
          end

          puts "The level of monkey business after 20 rounds of stuff-slinging simian shenanigans: #{find_two_highest_numbers_of_inspections[0] * find_two_highest_numbers_of_inspections[1]}"
        end

        def play_a_keep_away_round
          monkeys.each do |_monkey_name, monkey|
            monkey.inspect_and_throw_all_holding_items!.each do |next_item_value, next_monkey_name|
              next_monkey = monkeys[next_monkey_name]
              next_monkey.catch_item(next_item_value)
            end
          end
        end

        def puts_round_result(round_number)
          puts "== After round #{round_number} =="

          monkeys.each do |monkey_name, monkey|
            puts "Monkey #{monkey_name} inspected items #{monkey.total_inspections} times."
          end

          puts "\n"
        end

        def monkeys
          @monkeys ||=
            begin
              m = {}
              monkey_attribute_lines = []

              File.foreach(input_path) do |line|
                if line.strip.empty?
                  monkey = Year2022::Day11::MonkeyParser.parse(monkey_attribute_lines.dup)
                  m[monkey.name] = monkey
                  monkey_attribute_lines = []
                else
                  monkey_attribute_lines << line
                end
              end

              monkey = Year2022::Day11::MonkeyParser.parse(monkey_attribute_lines.dup)
              m[monkey.name] = monkey
              m
            end
        end


        def find_two_highest_numbers_of_inspections
          heap = []

          monkeys.values.each do |monkey|
            total_inspections = monkey.total_inspections

            if heap.length == 2
              next unless total_inspections > heap.first

              heap.shift
              heap.append(total_inspections)
            else
              heap.append(total_inspections)
            end

            index = heap.length - 1

            while index > 0 && heap[(index - 1) / 2] > heap[index]
              heap[(index - 1) / 2], heap[index] = heap[index], heap[(index - 1) / 2]
              index = (index - 1) / 2
            end
          end

          heap
        end

        def input_path
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
