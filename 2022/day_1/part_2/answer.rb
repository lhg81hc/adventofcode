require_relative '../input_parser'

module Day1
  module Part2
    class Answer
      def self.run
        new.run
      end

      def run
        top_three_most_calories = [-1, -1, carrying_calories.first.sum]

        carrying_calories.each do |calories|
          sum_of_calories = calories.sum
          if sum_of_calories > top_three_most_calories[0]
            top_three_most_calories[0] = sum_of_calories
            top_three_most_calories.sort!
          end
        end

        p "The most Calories that an Elf is carrying: #{top_three_most_calories.sum}"
      end

      def carrying_calories
        @carrying_calories ||= Day1::InputParser.parse(filepath)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
