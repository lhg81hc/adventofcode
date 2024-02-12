require_relative 'component'

module Day10
  class LandScape
    attr_reader :input_path, :map, :s_point, :width

    def initialize(input_path)
      @input_path = input_path
      @map = load_map
    end

    def load_map
      lines.each.with_index.reduce([]) do |r, (line, row_idx)|
        component_chars = line.scan(/[\w&.|\-]/)
        @width ||= component_chars.count

        r <<
          component_chars.map.with_index do |c, char_idx|
            @s_point = [row_idx, char_idx] if c == 'S'
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

    def find_main_loop
      find_loop(starting_point: s_point)
    end

    def find_closest_left_pipe(starting_point: [])
      current_point = starting_point
      current_component = map.dig(current_point[0], current_point[1])
      return nil if current_component.nil?

      current_row_idx = starting_point[0]
      current_char_idx = starting_point[1]

      (current_char_idx - 1).downto(0).each do |char_idx|
        tmp_component = map.dig(current_row_idx, char_idx)

        if tmp_component.nil?
          return nil
        elsif tmp_component.ground?
          next
        elsif tmp_component.pipe? || tmp_component.starting_point?
          return [current_row_idx, char_idx]
        else
          return nil
        end
      end

      nil
    end

    def find_loop(starting_point: [])
      current_point = starting_point
      current_component = map.dig(current_point[0], current_point[1])
      return nil unless !current_component.nil? && (current_component.pipe? || current_component.starting_point?)

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

        next_point =
          if prev_point.nil?
            sample = current_component.adjacent_components.sample
            return nil if sample.nil?

            sample.location
          else
            possible_next_components = current_component.adjacent_components.select { |c| c.location != prev_point }
            raise "Found more than 1 possible next component" if possible_next_components.count > 1
            # raise "Loop not found, stopped at #{current_point.join(',')}" if possible_next_components.count < 1
            return nil if possible_next_components.count < 1

            possible_next_components.first.location
          end

        prev_point = current_point
        current_point = next_point
        current_component = map.dig(current_point[0], current_point[1])
        move_count += 1
      end

      history
    end
  end
end