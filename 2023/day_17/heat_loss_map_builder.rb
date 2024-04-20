require_relative 'city_block'
require_relative 'heat_loss_map'

module Day17
  class HeatLossMapBuilder
    attr_accessor :filepath

    def initialize(filepath)
      @filepath = filepath
    end

    def self.build(filepath)
      new(filepath).build
    end

    def build
      heat_loss_map = Day17::HeatLossMap.new

      File.foreach(filepath).with_index do |line, line_idx|
        line.strip.each_char.with_index do |char, char_idx|
          city_block = Day17::CityBlock.new(line_idx, char_idx, char.to_i)
          heat_loss_map.add_city_block(city_block)
        end
      end

      heat_loss_map
    end
  end
end
