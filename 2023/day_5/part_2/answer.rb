require_relative '../seeds_parser'
require_relative '../category_map_table'

module Day5
  module Part2
    class Answer
      INPUT_FILE = "../input.txt"

      attr_reader :result

      def initialize
        @result = []
        @min_location = nil
      end

      def self.run
        new.run
      end

      def run
        ranges_of_seed_numbers.map do |range_of_seed_numbers|
          seed_to_soil_ranges = seed_to_soil_map.find_destination_ranges(range_of_seed_numbers)

          soil_to_fertilizer_ranges =
            seed_to_soil_ranges.map { |range| soil_to_fertilizer_map.find_destination_ranges(range) }.flatten

          fertilizer_to_water_ranges =
            soil_to_fertilizer_ranges.map { |range| fertilizer_to_water_map.find_destination_ranges(range) }.flatten

          water_to_light_ranges =
            fertilizer_to_water_ranges.map { |range| water_to_light_map.find_destination_ranges(range) }.flatten

          light_to_temperature_ranges =
            water_to_light_ranges.map { |range| light_to_temperature_map.find_destination_ranges(range) }.flatten

          temperature_to_humidity_ranges =
            light_to_temperature_ranges.map { |range| temperature_to_humidity_map.find_destination_ranges(range) }.flatten

          humidity_to_location_ranges =
            temperature_to_humidity_ranges.map { |range| humidity_to_location_map.find_destination_ranges(range) }.flatten

          temp_min = humidity_to_location_ranges.sort_by { |r| r.begin }.first.begin

          if @min_location.nil?
            @min_location = temp_min
          else
            if temp_min < @min_location
              @min_location = temp_min
            end
          end
        end

        puts "The lowest location number that corresponds to any of the initial seed numbers: #{@min_location}"
      end

      def ranges_of_seed_numbers
        @ranges_of_seed_numbers ||= seed_parser.ranges_of_seed_numbers
      end

      def seed_parser
        @seed_parser ||= Day5::SeedsParser.new(lines[0])
      end

      def lines
        @lines ||= input_file.readlines
      end

      def input_file
        @input_file ||= File.open(input_path)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end

      [
        'seed-to-soil',
        'soil-to-fertilizer',
        'fertilizer-to-water',
        'water-to-light',
        'light-to-temperature',
        'temperature-to-humidity',
        'humidity-to-location'
      ].each do |name|
        underscored_name = name.gsub('-', '_')
        method_name = "#{underscored_name}_map"

        define_method(method_name) do
          var_name = "@#{underscored_name}".to_sym
          instance_variable_get(var_name) ||
            instance_variable_set(
              var_name,
              begin
                t = []
                start = false
                lines.each do |line|
                  if line.include?(name)
                    start = true
                    next
                  end

                  if start
                    break if line.strip.empty?
                    t << line
                  end
                end

                Day5::CategoryMapTable.new(name, t)
              end
            )
        end
      end
    end
  end
end
