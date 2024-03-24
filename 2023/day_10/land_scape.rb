require_relative 'component'

module Day10
  class LandScape
    attr_reader :input_path, :s_point, :map_width

    def initialize(input_path)
      @input_path = input_path
    end

    def component_table
      @component_table ||=
        lines.each.with_index.reduce([]) do |r, (line, row_idx)|
          component_chars = line.scan(/[\w&.|\-]/)
          @map_width ||= component_chars.count

          r <<
            component_chars.map.with_index do |c, char_idx|
              component = Day10::Component.new(c, [row_idx, char_idx])
              component.adjacent_components = find_connected_components(component)
              component
            end
          r
        end
    end

    def find_connected_components(component)
      component.poles.inject([]) do |r, pole|
        location = component.location

        row_idx = location[0]
        char_idx = location[1]

        tmp_row_idx = pole.axis == 'y' ? row_idx - pole.value : row_idx
        tmp_char_idx = pole.axis == 'x' ? char_idx + pole.value : char_idx

        if tmp_row_idx < 0 || tmp_char_idx < 0 || tmp_row_idx >= map_height || tmp_char_idx >= map_width
          r
        else
          adjacent_char = lines[tmp_row_idx][tmp_char_idx]
          adjacent_component = Day10::Component.new(adjacent_char, [tmp_row_idx, tmp_char_idx])

          connectable =
            adjacent_component.poles.any? do |other_pole|
              other_pole.axis == pole.axis && (other_pole.value + pole.value).zero?
            end

          r << adjacent_component if connectable
          r
        end
      end
    end

    def input_file
      @input_file ||= File.open(input_path)
    end

    def lines
      @lines ||= input_file.readlines
    end

    def map_height
      @map_height ||= lines.length
    end

    def starting_point
      @starting_point ||=
        begin
          s = nil

          component_table.each do |row|
            row.each do |row_item|
              if row_item.starting_point?
                s = row_item.location
                break
              end
            end
          end

          s
        end
    end

  end
end
