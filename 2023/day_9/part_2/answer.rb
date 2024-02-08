require_relative '../history'

module Day9
  module Part2
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
          @sum += history.prediction_of_the_new_left_most
        end

        puts "The sum of all extrapolated values: #{sum}"
      end

      def input_file
        @input_file ||= File.open(input_path)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end