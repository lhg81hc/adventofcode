require_relative 'land_scape'
require 'forwardable'

module Day10
  class LoopFinder
    extend Forwardable

    attr_reader :land_scape

    def initialize(land_scape)
      @land_scape = land_scape
    end

    def_delegators :land_scape, :component_table, :starting_point

    def main_loop
      @main_loop ||= find_loop(starting_point: starting_point)
    end

    def find_loop(starting_point: [])
      current_point = starting_point
      current_component = component_table.dig(current_point[0], current_point[1])
      return nil unless !current_component.nil? && (current_component.pipe? || current_component.starting_point?)

      history = {}
      move_count = 0
      prev_point = nil

      loop do
        # if starting point, then get the next point randomly
        # if not the starting point, find the next point base on the adjacent components
        # if the possible next points are more than 1 then raise error (because the way pipes are all 1 way route)
        # if the possible next points are blank then also raise error
        # if the next point is the starting point (the loop is found), then stop
        history_key = current_point.join(',')
        break unless history[history_key].nil?

        history[history_key] = move_count

        next_point =
          if prev_point.nil?
            sample = current_component.adjacent_components.sample
            return nil if sample.nil?

            sample.location
          else
            possible_next_components = current_component.adjacent_components.select { |c| c.location != prev_point }
            raise "Found more than 1 possible next component" if possible_next_components.count > 1
            return nil if possible_next_components.count < 1

            possible_next_components.first.location
          end

        prev_point = current_point
        current_point = next_point
        current_component = component_table.dig(current_point[0], current_point[1])
        move_count += 1
      end

      history.map { |k, _v| k.split(',').map(&:to_i) }
    end

    def total_points_inside_main_loop
      (0..component_table.length - 1).inject(0) do |c, line_idx|
        row = component_table[line_idx]

        (0..row.length - 1).each do |char_idx|
          curr_component = component_table.dig(line_idx, char_idx)

          if main_loop.find { |location| location == curr_component.location }
            puts "[#{curr_component.location.join(',')}] is on the main loop"
          elsif point_inside_main_loop?(curr_component.location)
            c += 1
            puts "[#{curr_component.location.join(',')}] is inside"
          else
            puts "[#{curr_component.location.join(',')}] is outside"
          end
        end

        c
      end
    end

    def point_inside_main_loop?(point)
      x, y = point
      inside = false

      for i in (0..(main_loop.length - 1)) do
        j = i.zero? ? main_loop.length - 1 : i - 1

        xi = main_loop[i][0]
        yi = main_loop[i][1]
        xj = main_loop[j][0]
        yj = main_loop[j][1]

        intersect = ((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi)
        inside = !inside if intersect
      end

      inside
    end
  end
end
