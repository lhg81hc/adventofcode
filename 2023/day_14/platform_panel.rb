require_relative 'platform_panel_component'

module Day14
  class PlatformPanel
    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def rows
      @rows ||=
        begin
          lines.inject([]) do |r, line|
            line.each_char.with_index do |char, char_idx|
              r[char_idx] ||= []
              r[char_idx] << Day14::PlatformPanelComponent.new(char)
            end

            r
          end
        end
    end
  end
end
