require_relative 'sensor'
require_relative 'beacon'
require_relative 'overlap_merging'

module Year2022
  module Day15
    class SensorSystem
      include OverlapMerging
      attr_reader :input_path, :sensors

      def initialize(input_path)
        @input_path = input_path
        @sensors = []
        @deployed = false
      end

      def deploy
        @sensors = []

        File.foreach(input_path) do |line|
          beacon = Beacon.new(*parse_closest_beacon_coordinates(line))
          sensor = Sensor.new(*parse_sensor_coordinates(line))
          sensor.closest_beacon = beacon

          @sensors << sensor
        end

        @deployed = true
      end

      def deployed?
        @deployed
      end

      def total_positions_on_row_cannot_contain_a_beacon(row_idx)
        raise ArgumentError unless row_idx.is_a?(Integer)

        # Gather the ranges that cover by all sensors on the given row
        ranges = covered_ranges_on_a_row(row_idx)
        # Merge the ranges together
        merged_ranges = merge_overlap(ranges)
        # Gather the x indexes that already occupied by sensors in order to exclude later
        occupied_x_indexes_on_current_row = occupied_x_indexes_on_row(row_idx)

        merged_ranges.inject(0) do |sum, range|
          c = 0

          occupied_x_indexes_on_current_row.delete_if do |x_index|
            c += 1 if x_index.between?(range.first, range.last)
            x_index.between?(range.first, range.last)
          end

          sum += (range.last - range.first + 1 - c)
          sum
        end
      end

      def occupied_x_indexes_on_row(row_idx)
        sensors.inject([]) do |arr, sensor|
          t = []
          t << sensor.x if sensor.y == row_idx
          t << sensor.closest_beacon_x if sensor.closest_beacon_y == row_idx

          arr |= t
          arr
        end
      end

      def covered_ranges_on_a_row(row_idx)
        sensors.filter_map do |sensor|
          r = sensor.covered_range_on_a_row(row_idx)
          [r.first, r.last] unless r.nil?
        end
      end

      private

      def parse_sensor_coordinates(line)
        sensor_coordinates_str = line.split(':')[0]

        x = sensor_coordinates_str.match(/x=([^;]*),/)[1].to_i
        y = sensor_coordinates_str.match(/y=([^;]*)/)[1].to_i

        [x,y]
      end

      def parse_closest_beacon_coordinates(line)
        closest_beacon_coordinates_str = line.split(':')[1]

        x = closest_beacon_coordinates_str.match(/x=([^;]*),/)[1].to_i
        y = closest_beacon_coordinates_str.match(/y=([^;]*)/)[1].to_i

        [x,y]
      end
    end
  end
end
