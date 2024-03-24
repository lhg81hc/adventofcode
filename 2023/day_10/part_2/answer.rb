require_relative '../land_scape'
require_relative '../loop_finder'

module Day10
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
        puts "The number of tiles that are enclosed by the main loop #{loop_finder.total_points_inside_main_loop}"
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
