require_relative 'contraption_component'
require_relative 'contraption_component_location'

module Day16
  class Contraption
    attr_reader :input_path

    def initialize(input_path)
      @input_path = input_path
    end

    def grid
      @grid ||=
        begin
          File.open(input_path).each_with_index.inject([]) do |r, (line, line_idx)|
            r[line_idx] = []

            line.strip.each_char.with_index do |char, char_idx|
              component_location = Day16::ContraptionComponentLocation.new(char_idx, line_idx)
              component = Day16::ContraptionComponent.new(component_location, char)
              r[line_idx] << component
            end

            r
          end
        end
    end

    def width
      @width ||= grid.first.length
    end

    def height
      @height ||= grid.length
    end
  end
end