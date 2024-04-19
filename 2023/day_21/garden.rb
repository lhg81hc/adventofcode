module Day21
  class Garden
    attr_accessor :two_d_map

    def initialize(two_d_map = [])
      @two_d_map = two_d_map
    end

    def add_component(component)
      @two_d_map[component.line_idx] ||= []
      @two_d_map[component.line_idx][component.char_idx] = component

      update_adjacent_components(component)
    end

    def update_adjacent_components(component)
      adjacent_components =
        adjacent_locations(component.line_idx, component.char_idx).inject([]) do |r, l|
          adjacent_component = two_d_map.dig(l[0], l[1])
          r << adjacent_component if adjacent_component
          r
        end

      adjacent_components.each do |adjacent_component|
        adjacent_component.add_adjacent_component(component)
        component.add_adjacent_component(adjacent_component)
      end
    end

    def adjacent_locations(line_idx, char_idx)
      locations =
        [
          [line_idx - 1, char_idx],
          [line_idx + 1, char_idx],
          [line_idx, char_idx - 1],
          [line_idx, char_idx + 1],
        ]

      locations.select { |l| l[0] >= 0 && l[1] >= 0 }
    end

    def find_component_by_char(char)
      found = nil

      two_d_map.each do |line|
        line.each do |component|
          return component if component.char == char
        end
      end

      found
    end

    def height
      two_d_map.length
    end

    def width
      two_d_map.first&.length || 0
    end
  end
end
