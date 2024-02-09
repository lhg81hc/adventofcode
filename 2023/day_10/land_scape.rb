require_relative 'component'
require 'byebug'

module Day10
  class LandScape
    DIRECTIONS = %w(up down left right)

    attr_reader :input_path, :map, :starting_point, :width
    attr_accessor :current_point

    def initialize(input_path)
      @input_path = input_path
      @map = load_map
    end

    def load_map
      puts 'Loading map...'
      @map =
        lines.each.with_index.reduce([]) do |r, (line, row_idx)|
          component_chars = line.scan(/[\w&.|\-]/)
          @width = component_chars.length

          r <<
            component_chars.map.with_index do |c, char_idx|
              if c == 'S'
                @starting_point = [row_idx, char_idx]
                @current_point = [row_idx, char_idx]
              end
              component = Day10::Component.new(c, row_idx, char_idx)
              component.adjacent_components = find_connected_components(row_idx, char_idx)
              component
            end
          r
        end
      puts "Loaded!"
    end

    def find_connected_components(row_idx, char_idx)
      [[-1, 0], [1, 0], [0, -1], [0, 1]].inject([]) do |r, (y_diff, x_diff)|
        tmp_row_idx = row_idx + y_diff
        tmp_char_idx = char_idx + x_diff
        adjacent_char = lines&.[](tmp_row_idx)&.[](tmp_char_idx)

        if tmp_row_idx < 0 || tmp_char_idx < 0 || tmp_row_idx >= total_lines || tmp_char_idx >= width
          r
        else
          placeholder = Day10::Component.new(adjacent_char, tmp_row_idx, tmp_char_idx)

          if placeholder.poles.any? { |p| (p.axis == 'y' && p.value == y_diff) || (p.axis == 'x' && p.value + x_diff == 0) }
            r << placeholder
            r
          else
            r
          end
        end
      end
    end

    def input_file
      @input_file ||= File.open(input_path)
    end

    def lines
      @lines ||= input_file.readlines
    end

    def total_lines
      @total_lines ||= lines.length
    end

    def current_row
      current_point[0]
    end

    def current_char_idx
      current_point[1]
    end

    def current_component
      @current_component = map.dig(current_row, current_char_idx)
    end

    def find_loop
      history = []
      loop do
        history << current_point
        current_point =
        break if current_component.starting_point?
      end
    end
    # def move(direction)
    #   case direction
    #   when 'up'
    #     move_up
    #   when 'down'
    #     move_down
    #   when 'left'
    #     move_left
    #   when 'right'
    #     move_right
    #   else
    #     raise "Unknown direction #{direction}"
    #   end
    # end
    #
    # def move_up
    #   top_adjacent_row = map[current_point[0] - 1]
    #
    #   if top_adjacent_row.nil?
    #     false
    #   else
    #     @current_point = [current_point[0] - 1, current_point[1]]
    #     true
    #   end
    # end
    #
    # def move_down
    #   bottom_adjacent_row = map[current_point[0] + 1]
    #
    #   if bottom_adjacent_row.nil?
    #     false
    #   else
    #     @current_point = [current_point[0] + 1, current_point[1]]
    #     true
    #   end
    # end
    #
    # def move_left
    #   left_adjacent_component_idx = current_point[1] - 1
    #
    #   if left_adjacent_component_idx < 0
    #     false
    #   else
    #     @current_point = [current_point[0], current_point[1] - 1]
    #     true
    #   end
    # end
    #
    # def move_right
    #   right_adjacent_component_idx = current_point[1] + 1
    #
    #   if right_adjacent_component_idx > width - 1
    #     false
    #   else
    #     @current_point = [current_point[0], current_point[1] + 1]
    #     true
    #   end
    # end
  end
end