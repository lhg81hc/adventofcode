require_relative '../land_scape'
require_relative '../loop_finder'

module Day10
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      def self.run
        new.run
      end

      def run
        puts "The number of steps along the loop to get from the starting
              position to the point farthest from the starting position: #{loop_finder.main_loop.length / 2}"
      end

      def land_scape
        @land_scape ||= Day10::LandScape.new(input_path)
      end

      def loop_finder
        @loop_finder ||= Day10::LoopFinder.new(land_scape)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
