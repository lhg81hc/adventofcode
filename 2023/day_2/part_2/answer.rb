require_relative '../game'

module Day2
  module Part2
    class Answer
      attr_reader :sum_of_power_of_all_sets

      def initialize
        @sum_of_power_of_all_sets = 0
      end

      def self.run
        new.run
      end

      def run
        File.open(input_path).each do |line|
          game = Day2::Game.new(line)
          puts game.the_power_of_the_set_of_cubes
          @sum_of_power_of_all_sets += game.the_power_of_the_set_of_cubes
        end

        puts "The sum of the power of these sets: #{sum_of_power_of_all_sets}"
      end

      def input_path
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
