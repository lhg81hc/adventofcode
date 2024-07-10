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
          game.play_several_rounds!(number_of_rounds, print_round_result: true)

          puts "The level of monkey business after #{number_of_rounds} rounds of stuff-slinging simian shenanigans: " +
               "#{inspections[0] * inspections[1]}"
        end

        def game
          @game ||= Year2022::Day11::KeepAwayGame.new(monkeys)
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
