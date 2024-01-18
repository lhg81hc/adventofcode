require_relative '../seeds_parser'
require_relative '../category_map_builder'

module Day5
  module Part1
    class Answer
      INPUT_FILE = "../input.txt"

      attr_reader :result

      def initialize
        @result = []
      end

      def self.run
        new.run
      end

      def run
        locations =
          seeds.map do |seed|
            soil = seed_to_soil_map.find_destination(seed)
            fertilizer = soil_to_fertilizer_map.find_destination(soil)
            water = fertilizer_to_water_map.find_destination(fertilizer)
            light = water_to_light_map.find_destination(water)
            temperature = light_to_temperature_map.find_destination(light)
            humidity = temperature_to_humidity_map.find_destination(temperature)
            location = humidity_to_location_map.find_destination(humidity)
            location
          end

        puts "The lowest location number that corresponds to any of the initial seed numbers: #{locations.min}"
      end

      def seeds
        @seeds ||= Day5::SeedsParser.new(lines[0]).seeds
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

                Day5::CategoryMapBuilder.build(name, t)
              end
            )
        end
      end
    end
  end
end
