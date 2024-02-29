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
      dup.cols.each { |col| tilt_col_north!(col) }

      dup
    end

    def tilt_north!
      platform_panel.cols.each { |col| tilt_col_north!(col) }
    end

    private

    def tilt_col_north!(col)
      1.upto(col.length - 1).each { |i| roll_rock_north(col, i) }
    end

    def roll_rock_north(col, idx)
      component = col[idx]
      return unless component.can_roll?

      stopped_index = idx

      (idx - 1).downto(0).each do |j|
        prev_component = col[j]

        if prev_component.rock?
          break
        else
          stopped_index = j
        end
      end

      if stopped_index != idx
        found = col[stopped_index]
        tmp = component.dup
        component.position = found.position
        found.char = '.'
        found.position = tmp.position

        col[stopped_index] = component
        col[idx] = found
      end
    end
  end
end
