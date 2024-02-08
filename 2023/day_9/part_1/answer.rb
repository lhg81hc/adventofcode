require_relative '../history'

module Day9
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      attr_reader :sum

      def initialize
        @sum = 0
      end

      def self.run
        new.run
      end

      def run
        File.foreach(input_path) do |line|
          history = Day9::History.new(line)
          @sum += history.prediction_of_the_next_value
        end

        puts "The sum of all extrapolated values: #{sum}"
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
