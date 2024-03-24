require_relative 'component'

module Day10
  class LandScape
    attr_reader :input_path, :s_point, :map_width

    def initialize(input_path)
      @input_path = input_path
    end

    def component_table
      @component_table ||=
        lines.each.with_index.reduce([]) do |r, (line, row_idx)|
          component_chars = line.scan(/[\w&.|\-]/)
          @map_width ||= component_chars.count

          r <<
            component_chars.map.with_index do |c, char_idx|
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

        if tmp_row_idx < 0 || tmp_char_idx < 0 || tmp_row_idx >= map_height || tmp_char_idx >= map_width
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

    def map_height
      @map_height ||= lines.length
    end

    def starting_point
      @starting_point ||=
        begin
          s = nil

          component_table.each do |row|
            row.each do |row_item|
              if row_item.starting_point?
                s = row_item.location
                break
              end
            end
          end

          s
        end
    end

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
        current_component = component_table.dig(current_point[0], current_point[1])
        move_count += 1
      end

      puts history
      history
    end

    def point_in_polygon?(point)
      x, y = point
      inside = false

      for i in (0..(polygon_coordinates.length - 1)) do
        j = i.zero? ? polygon_coordinates.length - 1 : i - 1

        xi = polygon_coordinates[i][0]
        yi = polygon_coordinates[i][1]
        xj = polygon_coordinates[j][0]
        yj = polygon_coordinates[j][1]

        intersect = ((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi)
        inside = !inside if intersect
      end

      inside
    end
    #
    # def inside_map?(point = [])
    #   !map.dig(point[0], point[1]).nil?
    # end
    #
    # def on_the_main_loop_boundary?(point = [])
    #   hash_key = point.join(',')
    #   !main_loop[hash_key].nil?
    # end
    #
    # def position_compare_to_main_loop(point = [])
    #   # -1 means outside of the main loop
    #   # 0 means on the main loop boundary
    #   # 1 means inside of the main loop
    #   return -1 unless inside_map?(point)
    #   return 0 if on_the_main_loop_boundary?(point)
    #
    #   row_idx = point[0]
    #   char_idx = point[1]
    #   loop_points_on_the_same_row = main_loop.select { |position, _c| position.start_with?("#{row_idx},") }
    #   return -1 if loop_points_on_the_same_row.empty?
    #
    #   # https://en.wikipedia.org/wiki/Point_in_polygon#Ray_casting_algorithm
    #   # From the starting point go NORTH-EAST
    #   # Count the appearance of '|', '-', '7' and 'L'
    #   intersection_points = []
    #   diagonal_intersection_points = 0
    #   loop do
    #     row_idx -= 1
    #     char_idx += 1
    #     break if row_idx < 0 || char_idx > map_width - 1
    #     next if main_loop["#{row_idx},#{char_idx}"].nil?
    #
    #     diagonal_component = map.dig(row_idx, char_idx)
    #     if ['|', '-', 'L', '7'].include?(diagonal_component.char)
    #       diagonal_intersection_points += 1
    #       intersection_points << [row_idx, char_idx]
    #     end
    #   end
    #
    #   puts "#{point.join(',')}"
    #   puts "intersection points: #{intersection_points}"
    #   puts "-------------------"
    #   puts "\n"
    #
    #   diagonal_intersection_points.odd? ? 1 : -1
    # end
  end
end