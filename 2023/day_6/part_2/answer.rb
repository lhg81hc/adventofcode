require_relative '../boat_race'

module Day6
  module Part2
    class Answer
      INPUT_FILE = '../input.txt'

      def initialize
      end

      def self.run
        new.run
      end

      def run
        boat_race = Day6::BoatRace.new(time, distance)
        puts "time: #{boat_race.time}"
        puts "recorded distance: #{boat_race.record_distance}"
        min_hold_duration_to_win = boat_race.min_hold_duration_to_win
        max_hold_duration_to_win = boat_race.max_hold_duration_to_win

        puts "Number of ways can you beat the record: #{(min_hold_duration_to_win..max_hold_duration_to_win).count}"
      end

      def time
        @time ||= lines[0].scan(/\d+/).join.to_i
      end

      def distance
        @distance ||= lines[1].scan(/\d+/).join.to_i
      end

      def lines
        @line ||= input_file.readlines
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