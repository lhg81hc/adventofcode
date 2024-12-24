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
          count = 0
          memoize = {}

          route_prediction.predict.each do |position|
            if memoize[position.join(',')].nil?
              memoize[position.join(',')] = true
              count += 1
            end
          end

          puts "The number of distinct positions the guard will visit before leaving the mapped area: #{count}"
        end

        def route_prediction
          @route_prediction ||= Year2024::Day6::RoutePrediction.new(manufacturing_lab_map)
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
