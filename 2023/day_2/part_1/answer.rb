require_relative '../game'

module Day2
  module Part1
    class Answer
      attr_reader :sum

      def initialize
        @sum = 0
      end

      def self.run
        new.run
      end

      def run
        File.open(input_path).each do |line|
          game = Day2::Game.new(line)
          @sum += game.id if game.possible?
        end

        puts "The sum of the IDs of possible games: #{sum}"
      end

      def input_path
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end
