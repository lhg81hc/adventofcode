require_relative '../contraption'
require_relative '../light_beam_path'

module Day16
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      def self.run
        new.run
      end

      def run
        light_beam_path = Day16::LightBeamPath.new(contraption)
        visited_locations_and_directions = light_beam_path.path(0, 0, 'right')

        visited_locations = {}
        visited_locations_and_directions.keys.each do |k|
          visited_locations[k.split.first] = true
        end

        puts_energized_contraption(visited_locations)
      end

      def contraption
        @contraption ||= Day16::Contraption.new(input_path)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end

      def puts_energized_contraption(visited_locations)
        contraption.grid.each do |grid_row|
          line =
            grid_row.map do |component|
              if visited_locations["#{component.location.y},#{component.location.x}"]
                '#'
              else
                '.'
              end
            end

          puts line.join
        end

        puts "Total number of energized tiles: #{visited_locations.keys.count}"
      end
    end
  end
end
