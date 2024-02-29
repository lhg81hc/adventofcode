require_relative 'platform_panel'
require_relative 'platform_panel_component'

module Day14
  class PlatformPanelController
    attr_reader :platform_panel

    def initialize(platform_panel)
      @platform_panel = platform_panel
    end

    def tilt_north
      dup = platform_panel.dup
      dup.rows.map! { |row| tilt_row_north(row) }

      dup
    end

    private

    def tilt_row_north(row)
      row_dup = row.dup

      1.upto(row_dup.length - 1).each do |i|
        component = row_dup[i]

        if component.can_roll?
          stopped_index = i

          (i - 1).downto(0).each do |j|
            prev_component = row_dup[j]

            if prev_component.rock?
              break
            else
              stopped_index = j
            end
          end
          if stopped_index != i
            row_dup[stopped_index] = component
            row_dup[i] = Day14::PlatformPanelComponent.new('.')
          end
        else
          next
        end
      end

      row_dup
    end
  end
end
