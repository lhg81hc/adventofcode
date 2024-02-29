require_relative 'component_position'
require_relative 'platform_panel_component'

module Day14
  class PlatformPanel
    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def components
      @components ||=
        begin
          lines.each.with_index.inject([]) do |r, (line, line_idx)|
            line.each_char.with_index do |char, char_idx|
              position = Day14::ComponentPosition.new(char_idx, line_idx)
              r << Day14::PlatformPanelComponent.new(char, position)
            end

            r
          end
        end
    end

    def width
      @width ||= rows.first.length
    end

    def height
      @height ||= cols.first.length
    end

    def rows
      components.inject([]) do |r, component|
        idx = component.position.y

        r[idx] ||= []
        insert_at = r[idx].bsearch_index { |c| c.position.x >= component.position.x } || r[idx].size
        r[idx].insert(insert_at, component)

        r
      end
    end

    def cols
      components.inject([]) do |r, component|
        idx = component.position.x

        r[idx] ||= []
        insert_at = r[idx].bsearch_index { |c| c.position.y >= component.position.y } || r[idx].size
        r[idx].insert(insert_at, component)

        r
      end
    end
  end
end
