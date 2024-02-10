require_relative 'component'
# require 'byebug'

module Day10
  class LandScape
    attr_reader :input_path, :map, :starting_point, :width
    attr_accessor :current_point

    def initialize(input_path)
      @input_path = input_path
      @map = load_map
    end

    def load_map
      lines.each.with_index.reduce([]) do |r, (line, row_idx)|
        component_chars = line.scan(/[\w&.|\-]/)
        @width = component_chars.count

        r <<
          component_chars.map.with_index do |c, char_idx|
            if c == 'S'
              @starting_point = [row_idx, char_idx]
              @current_point = [row_idx, char_idx]
            end

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

        if tmp_row_idx < 0 || tmp_char_idx < 0 || tmp_row_idx >= total_lines || tmp_char_idx >= width
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
      history = {}
      move_count = 0
      prev_point = nil

      loop do
        # if starting point, then get the next point randomly
        # if not the starting point, find the next point base on the adjacent components
        # if the possible next points are more than 1 then raise error (because the way pipes are all 1 way route)
        # if the possible next points are blank then also raise error
        # if the next point is the stating point (the loop is found), then stop
        history_key = current_point.join(',')
        break unless history[history_key].nil?

        history[history_key] = move_count
        puts "#{history_key} => #{move_count}"

        next_point =
          if current_component.starting_point?
            current_component.adjacent_components.sample.location
          else
            possible_next_components = current_component.adjacent_components.select { |c| c.location != prev_point }
            raise "Found more than 1 possible next component" if possible_next_components.count > 1
            raise "Loop not found, stopped at #{current_point.join(',')}" if possible_next_components.count < 1

            possible_next_components.first.location
          end

        prev_point = current_point
        @current_point = next_point
        move_count += 1
      end

      history
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