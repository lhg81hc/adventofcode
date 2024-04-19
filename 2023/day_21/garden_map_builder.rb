require_relative 'garden'
require_relative 'garden_component'

module Day21
  class GardenMapBuilder
    attr_reader :filepath, :garden_map

    def initialize(filepath)
      @filepath = filepath
      @garden_map = Day21::Garden.new
    end

    def self.build(filepath)
      new(filepath).build
    end

    def build
      File.foreach(filepath).with_index do |line, line_idx|
        line.strip.each_char.with_index do |char, char_idx|
          @garden_map.add_component(Day21::GardenComponent.new(char, line_idx, char_idx))
        end
      end

      garden_map
    end
  end
end
