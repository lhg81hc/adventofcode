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

    def tilt_south!
      platform_panel.cols.each { |col| tilt_col_south!(col) }
    end

    def tilt_west!
      platform_panel.rows.each { |row| tilt_row_west!(row) }
    end

    def tilt_east!
      platform_panel.rows.each { |row| tilt_row_east!(row) }
    end

    def spin!
      tilt_north!
      tilt_west!
      tilt_south!
      tilt_east!
    end

    private

    def tilt_col_north!(col)
      1.upto(col.length - 1).each { |i| roll_rock(col, i, (i - 1).downto(0)) }
    end

    def tilt_col_south!(col)
      (col.length - 2).downto(0).each { |i| roll_rock(col, i, (i + 1).upto(col.length - 1)) }
    end

    def tilt_row_west!(row)
      1.upto(row.length - 1).each { |i| roll_rock(row, i, (i - 1).downto(0)) }
    end

    def tilt_row_east!(row)
      (row.length - 2).downto(0).each { |i| roll_rock(row, i, (i + 1).upto(row.length - 1)) }
    end

    def roll_rock(arr, start_index, roll_to_indexes)
      component = arr[start_index]
      return if component.nil? || !component.can_roll?

      stopped_index = start_index

      roll_to_indexes.each do |j|
        prev_component = arr[j]

        if prev_component.rock?
          break
        else
          stopped_index = j
        end
      end

      if stopped_index != start_index
        found = arr[stopped_index]
        tmp = component.dup
        component.position = found.position
        found.char = '.'
        found.position = tmp.position

        arr[stopped_index] = component
        arr[start_index] = found
      end
    end
  end
end
