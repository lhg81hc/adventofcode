require 'forwardable'
require_relative './route_prediction'

module Year2024
  module Day6
    class LoopCausingPositionFinder
      attr_reader :manufacturing_lab_map, :route_prediction

      def initialize(manufacturing_lab_map)
        @manufacturing_lab_map = manufacturing_lab_map
        @manufacturing_lab_map.scan unless @manufacturing_lab_map.scanned?
        @route_prediction =
          Year2024::Day6::RoutePrediction.new(
            manufacturing_lab_map.two_d_map,
            manufacturing_lab_map.current_guard_position,
            manufacturing_lab_map.current_guard_direction
          )
      end

      def visited_positions
        visited_positions = @route_prediction.predict.visited_positions
        visited_positions.slice!(0) # Exclude starting position
        visited_positions
      end

      def search(with_log: false)
        visited_positions.each_with_object([]) do |position, r|
          new_prediction = @route_prediction.predict_after_placing_new_obstacle(position)
          log = "Try [#{position.join(', ')}] --> Not valid"

          if new_prediction.loop_found
            r << position
            log = "Try [#{position.join(', ')}] --> New obstruction would cause loop"
          end

          puts log if with_log
        end
      end
    end
  end
end
