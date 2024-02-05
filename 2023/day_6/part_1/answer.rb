require_relative 'boat_race'

module Day6
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      attr_reader :total_margin_of_error

      def initialize
        @total_margin_of_error = nil
      end

      def self.run
        new.run
      end

      def run
        total_race = times.length

        @total_margin_of_error =
          (0..total_race - 1).
            map { |idx| Day6::Part1::BoatRace.new(times[idx], distances[idx]).winning_options.count }.
            inject(:*)

        puts "Margin of error you have: #{total_margin_of_error}"
      end

      def times
        @times ||= lines[0].scan(/\d+/).map(&:to_i)
      end

      def distances
        @distances ||= lines[1].scan(/\d+/).map(&:to_i)
      end

      def lines
        @lines ||= input_file.readlines
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
