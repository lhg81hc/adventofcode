require_relative '../input_parser'

module Day1
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        max = carrying_calories.first.sum
        carrying_calories.each do |calories|
          sum_of_calories = calories.sum
          max = sum_of_calories if max < sum_of_calories
        end

        puts "The most Calories that an Elf is carrying: #{max}"
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
