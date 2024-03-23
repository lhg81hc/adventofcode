require_relative 'line_parser'

module Day3
  class SchematicParser
    NUMBER_CHARS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].freeze

    attr_reader :filepath

    Line = Struct.new(:index, :value)

    def initialize(filepath)
      @filepath = filepath
    end

    def numbers
      @numbers ||=
        begin
          line_idx = 0
          triplet = [nil]

          list =
            File.foreach(filepath).inject([]) do |r, str|
              triplet << Line.new(line_idx, str.strip)
              line_idx += 1

              if triplet.length == 3
                r += Day3::LineParser.new(triplet).numbers
                triplet.shift
              end

              r
            end

          if triplet.length > 0 && triplet.length < 3
            while triplet.length < 3
              triplet << nil
            end

            list += Day3::LineParser.new(triplet).numbers
          end

          list
        end
    end

    def part_numbers
      @part_numbers ||= numbers.select { |n| n.adjacent_chars.any? { |c| !c.nil? && c.value != '.' } }
    end
  end
end
