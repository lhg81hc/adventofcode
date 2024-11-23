require_relative '../sensor_system'

module Year2022
  module Day15
    module Part2
      class Answer
        ROW_IDX = 2000000

        def self.run
          new.run
        end

        def run
          sensor_system.deploy unless sensor_system.deployed?

          sensor_system.sensors.each do |sensor|
            p sensor.coordinate_of_maximum_reachable_points
          end
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
