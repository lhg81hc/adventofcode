require_relative '../sensor_system'

module Year2022
  module Day15
    module Part1
      class Answer
        ROW_IDX = 2000000

        def self.run
          new.run
        end

        def run
          sensor_system.deploy unless sensor_system.deployed?

          puts "In the row where y=#{ROW_IDX}, there are #{sensor_system.total_positions_on_row_cannot_contain_a_beacon(ROW_IDX)} positions where a beacon cannot be present"
        end

        def input_path
          File.join(File.dirname(__FILE__), '../input.txt')
        end

        def sensor_system
          @sensor_system ||= Year2022::Day15::SensorSystem.new(input_path)
        end
      end
    end
  end
end
