require_relative '../input_parser'
require_relative '../max_calories_finder'

module Day1
  module Part2
    class Answer
      def self.run
        new.run
      end

      def run
        top_three_most_calories = max_calories_finder.find_top_three
        puts "The top three Elves carrying the most Calories: #{top_three_most_calories.join(" + ")} = #{top_three_most_calories.sum}"
      end

      def calories_group
        Day1::InputParser.parse(filepath)
      end

      def max_calories_finder
        @max_calories_finder ||= Day1::MaxCaloriesFinder.new(calories_group)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
