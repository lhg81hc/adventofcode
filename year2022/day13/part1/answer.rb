require_relative '../input_parser'

module Year2022
  module Day13
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          pairs = Year2022::Day13::InputParser.parse(input_path)

          sum =
            pairs.each.with_index.inject(0) do |s, (pair, index)|
              if pair.right_order?
                s += index + 1
                puts "Pair #{index + 1}: Right Order"
              else
                puts "Pair #{index + 1}: Wrong Order"
              end

              s
            end

          puts "The sum of the indices of those pairs: #{sum}"
        end

        def input_path
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
