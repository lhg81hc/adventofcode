require_relative '../monkey_parser'

module Year2022
  module Day11
    module Part1
      class Answer
        def initialize
        end

        def self.run
          new.run
        end

        def run
          p monkeys.first.holding_items
          p monkeys.last.holding_items
        end

        def monkeys
          @monkeys ||=
            begin
              m = []
              monkey_attribute_lines = []

              File.foreach(input_path) do |line|
                if line.strip.empty?
                  m << Year2022::Day11::MonkeyParser.parse(monkey_attribute_lines.dup)
                  monkey_attribute_lines = []
                else
                  monkey_attribute_lines << line
                end
              end

              m << Year2022::Day11::MonkeyParser.parse(monkey_attribute_lines)
              m
            end
        end

        def input_path
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
