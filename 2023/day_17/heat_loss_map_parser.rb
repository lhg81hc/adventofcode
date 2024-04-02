require_relative 'line_parser'

module Day17
  class HeatLossMapParser
    attr_reader :filepath

    Line = Struct.new(:index, :value)

    def initialize(filepath)
      @filepath = filepath
    end

    def heat_loss_map
      @heat_loss_map ||=
        begin
          line_idx = 0
          triplet = [nil]

          map =
            File.foreach(filepath).inject([]) do |r, str|
              triplet << Line.new(line_idx, str.strip)
              line_idx += 1

              if triplet.length == 3
                r << Day17::LineParser.new(triplet).city_blocks
                triplet.shift
              end

              r
            end

          if triplet.length > 0 && triplet.length < 3
            while triplet.length < 3
              triplet << nil
            end

            map << Day17::LineParser.new(triplet).city_blocks
          end

          map
        end
    end
  end
end
