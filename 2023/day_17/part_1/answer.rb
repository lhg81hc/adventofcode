require_relative '../heat_loss_map_parser'

module Day17
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      def self.run
        new.run
      end

      def run
        puts heat_loss_map_parser.map.first.last.heat_loss_amount
        # puts_energized_contraption(visited_locations)
      end

      def heat_loss_map_parser
        @heat_loss_map_parser ||= Day17::HeatLossMapParser.new(input_path)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
