require_relative 'hiking_trail_map'
require_relative 'map_component'

module Day23
  class HikingTrailMapParser
    attr_accessor :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def self.parse(filepath)
      new(filepath).parse
    end

    def parse
      hiking_trail_map = Day23::HikingTrailMap.new

      File.foreach(filepath).with_index do |line, line_idx|
        line.strip.each_char.with_index do |char, char_idx|
          map_component = Day23::MapComponent.new(line_idx, char_idx, char)
          hiking_trail_map.add_map_component(map_component)
        end
      end

      hiking_trail_map
    end
  end
end
