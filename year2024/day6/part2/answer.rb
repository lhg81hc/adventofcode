require_relative '../loop_causing_position_finder'
require_relative '../manufacturing_lab_map'

module Year2024
  module Day6
    module Part2
      class Answer
        def self.run
          new.run
        end

        def run
          finder = Year2024::Day6::LoopCausingPositionFinder.new(manufacturing_lab_map)

          loop_causing_positions = finder.search(with_log: true)

          puts "\nThe total position that would cause loop if obstruction is placed: #{loop_causing_positions.count}"
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
