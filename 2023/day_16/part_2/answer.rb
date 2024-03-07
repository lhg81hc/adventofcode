require_relative '../contraption'
require_relative '../light_beam_path'

module Day16
  module Part2
    class Answer
      INPUT_FILE = '../input.txt'

      def self.run
        new.run
      end

      def run
        best_configuration = {}
        largest_number_of_energized_tiles = 0

        directions_and_edges.each do |direction, edge|
          edge.each do |component|
            visited_locations_and_directions = light_beam_path.path(component.location.y, component.location.x, direction)

            visited_locations = {}
            visited_locations_and_directions.keys.each do |k|
              visited_locations[k.split.first] = true
            end

            number_of_energized_tiles = visited_locations.keys.count
            puts "#{component.location.y},#{component.location.x} #{direction} --> #{number_of_energized_tiles}"

            if number_of_energized_tiles > largest_number_of_energized_tiles
              largest_number_of_energized_tiles = number_of_energized_tiles
              best_configuration = { row_idx: component.location.y, col_idx: component.location.x, direction: direction }
            end
          end
        end

        puts "The initial beam configuration that energizes the largest number of tiles: #{best_configuration[:row_idx]},#{best_configuration[:col_idx]} #{best_configuration[:direction]}"
        puts "The highest possible number of energized tiles: #{largest_number_of_energized_tiles}"
      end

      def directions_and_edges
        {
          'down' => contraption.top_row,
          'up' => contraption.bottom_row,
          'right' => contraption.leftmost_column,
          'left' => contraption.rightmost_column
        }
      end

      def light_beam_path
        @light_beam_path ||= Day16::LightBeamPath.new(contraption)
      end

      def contraption
        @contraption ||= Day16::Contraption.new(input_path)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end
    end
  end
end
