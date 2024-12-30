require_relative '../route_prediction'
require_relative '../manufacturing_lab_map'

module Year2024
  module Day6
    module Part1
      class Answer
        def self.run
          new.run
        end

        def run
          prediction = route_prediction.predict

          puts 'The number of distinct positions the guard will visit before ' \
               "leaving the mapped area: #{prediction.visited_positions.count}"
        end

        def route_prediction
          @route_prediction ||=
            begin
              manufacturing_lab_map.scan unless manufacturing_lab_map.scanned?

              Year2024::Day6::RoutePrediction.new(
                manufacturing_lab_map.two_d_map,
                manufacturing_lab_map.current_guard_position,
                manufacturing_lab_map.current_guard_direction
              )
            end
        end

        def manufacturing_lab_map
          @manufacturing_lab_map ||= Year2024::Day6::ManufacturingLabMap.new(filepath)
        end

        def filepath
          File.join(File.dirname(__FILE__), '../input.txt')
        end
      end
    end
  end
end
