require_relative '../land_scape'

module Day10
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      def initialize
      end

      def self.run
        new.run
      end

      def run
        history = land_scape.find_loop
        puts "The number of steps along the loop to get from the starting position to the point farthest from the starting position: #{history.keys.count / 2}"
      end

      def land_scape
        @land_scape ||= LandScape.new(input_path)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
