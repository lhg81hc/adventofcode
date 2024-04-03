require_relative 'line_parser'
require_relative 'heat_loss_map'

module Day17
  class InputParser
    attr_reader :filepath

    Line = Struct.new(:index, :value)

    def initialize(filepath)
      @filepath = filepath
    end

    def heat_loss_map
      @heat_loss_map ||=
        begin
          new_heat_lost_map = HeatLossMap.new
          line_idx = 0
          triplet = [nil]

          File.foreach(filepath) do |str|
            triplet << Line.new(line_idx, str.strip)
            line_idx += 1

            if triplet.length == 3
              new_heat_lost_map.blocks << Day17::LineParser.new(triplet).city_blocks
              triplet.shift
            end
          end

          if triplet.length > 0 && triplet.length < 3
            while triplet.length < 3
              triplet << nil
            end

            new_heat_lost_map.blocks << Day17::LineParser.new(triplet).city_blocks
          end

          new_heat_lost_map
        end
    end
  end
end
