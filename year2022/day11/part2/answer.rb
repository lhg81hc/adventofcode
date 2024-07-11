require_relative '../monkey_parser'
require_relative '../keep_away_game'

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
          number_of_rounds.times do |n|
            round_number = n + 1

            game.play!
            puts_round_result(round_number) if printable_round?(round_number)
          end

          puts "The level of monkey business after #{number_of_rounds} rounds of stuff-slinging simian shenanigans: " +
               "#{inspections[0] * inspections[1]}"
        end

        def game
          @game ||= Year2022::Day11::KeepAwayGame.new(monkeys)
        end

        def puts_round_result(round_number)
          puts "== After round #{round_number} =="

          monkeys.each { |monkey| puts "Monkey #{monkey.name} inspected items #{monkey.total_inspections} times." }

          puts "\n"
        end

        def printable_round?(round_number)
          round_number == 1 || round_number == 20 || (round_number % 1000).zero?
        end

        def inspections
          monkeys.map(&:total_inspections).sort.reverse
        end

        def monkeys
          @monkeys ||=
            begin
              l = []
              monkey_attribute_lines = []

              File.foreach(input_path) do |line|
                if line.strip.empty?
                  l << init_monkey(monkey_attribute_lines)
                  monkey_attribute_lines = []
                else
                  monkey_attribute_lines << line
                end
              end

              l << init_monkey(monkey_attribute_lines)
              l
            end
        end

        def init_monkey(monkey_attribute_lines)
          Year2022::Day11::MonkeyParser.parse(monkey_attribute_lines, false)
        end

        def input_path
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
