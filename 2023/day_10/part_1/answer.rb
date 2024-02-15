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
        main_loop = land_scape.main_loop
        puts "The number of steps along the loop to get from the starting position to the point farthest from the starting position: #{main_loop.keys.count / 2}"
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
