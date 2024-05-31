require_relative '../input_parser'
require_relative '../max_calories_finder'

module Day1
  module Part1
    class Answer
      def self.run
        new.run
      end

      def run
        puts "The most Calories that an Elf is carrying: #{max_calories_finder.find_max}"
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
