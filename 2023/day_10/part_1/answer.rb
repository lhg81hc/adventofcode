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
        loop do

        end
        %w(up down left right).each do |direction|
          land_scape.current_point = land_scape.starting_point
          current_component = land_scape.current_component.dup

          land_scape.move(direction)


        end
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
