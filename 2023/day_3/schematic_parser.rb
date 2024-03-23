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

    def star_symbols_map
      @star_symbols_map ||=
        part_numbers.inject({}) do |m, n|
          star_adjacent_characters = n.adjacent_chars.select { |ac| ac&.value == '*' }

          unless star_adjacent_characters.empty?
            star_adjacent_characters.each do |sac|
              m["#{sac.line_index},#{sac.char_index}"] ||= []
              m["#{sac.line_index},#{sac.char_index}"] << n
            end
          end

          m
        end
    end
  end
end
