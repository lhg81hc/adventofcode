require_relative 'line_parser'

module Day17
  class HeatLossMapParser
    attr_reader :filepath

    Line = Struct.new(:index, :value)

    def initialize(filepath)
      @filepath = filepath
    end

    def map
      @map ||=
        begin
          line_idx = 0
          triplet = [nil]

          list =
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

            list << Day17::LineParser.new(triplet).city_blocks
          end

          list
        end
    end
  end
end
