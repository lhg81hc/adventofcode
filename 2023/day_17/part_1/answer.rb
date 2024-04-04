require_relative '../input_parser'
require_relative '../min_heat_loss_path_finder'

module Day17
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      def self.run
        new.run
      end

      def run
        path_finder.find_all_paths
        # puts path_finder.find_minimum_heat_lost_path.map { |l| "[#{l.join(',')}]" }
        # puts_energized_contraption(visited_locations)
      end

      def heat_loss_map
        @heat_loss_map ||= Day17::InputParser.new(input_path).heat_loss_map
      end

      def path_finder
        @path_finder ||= Day17::MinHeatLossPathFinder.new(heat_loss_map)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
