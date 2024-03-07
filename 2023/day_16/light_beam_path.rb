module Day16
  class LightBeamPath
    attr_reader :contraption

    def initialize(contraption)
      @contraption = contraption
    end

    def path(start_col_idx, start_row_idx, start_direction)
      @visited = {}
      @stack = []
      @last_visited = { row_idx: start_col_idx, col_idx: start_row_idx, direction: start_direction }
      @loop_count = 0
      @done = false

      until @done
        build_reflection_path(@last_visited[:row_idx], @last_visited[:col_idx], @last_visited[:direction])
      end

      @visited
    end

    # Idea:
    # 1. Add the current location and direction to visited list
    # 2. Call #reflections to get the next locations and directions
    # 3. Filter the location and direction that have been visited (#reflection() can lead to loop)
    # 4. If the #reflection returns an array, then add the current component to the stack and recursively check the return values first
    # 5. After finish checking return values recursively, pop the latest component from the stack and recheck
    # 6. The base case is when the @stack is empty
    def build_reflection_path(row_idx, col_idx, direction)
      @visited[node_value(row_idx, col_idx, direction)] = true

      curr_component = contraption.grid[row_idx][col_idx]
      next_locations_and_directions =
        reflections(curr_component, direction).select do |h|
          @visited[node_value(h[:row_idx], h[:col_idx], h[:direction])].nil?
        end

      if next_locations_and_directions.empty?
        next_component = @stack.pop

        if next_component.nil?
          @done = true
          return nil
        end
      else
        @stack << { row_idx: row_idx, col_idx: col_idx, direction: direction } if next_locations_and_directions.length > 1
        next_component = next_locations_and_directions.first
      end

      @last_visited = { row_idx: next_component[:row_idx], col_idx: next_component[:col_idx], direction: next_component[:direction] }
      @loop_count += 1
      return nil if @loop_count % 1000 == 0

      build_reflection_path(next_component[:row_idx], next_component[:col_idx], next_component[:direction])
    end

    def reflections(curr_component, beam_arriving_dir)
      curr_component.departing_directions(beam_arriving_dir).inject([]) do |r, departing_dir|
        next_row_idx, next_col_idx = neighbor_location_by_direction(curr_component.location.y, curr_component.location.x, departing_dir)

        if (next_col_idx >= 0 && next_row_idx >= 0) && (next_col_idx <= contraption.width - 1) && (next_row_idx <= contraption.height - 1)
          r << { row_idx: next_row_idx, col_idx: next_col_idx, direction: departing_dir }
        end

        r
      end
    end

    def neighbor_location_by_direction(curr_row_idx, curr_col_idx, direction)
      case direction
      when 'up'
        [curr_row_idx - 1, curr_col_idx]
      when 'down'
        [curr_row_idx + 1, curr_col_idx]
      when 'left'
        [curr_row_idx, curr_col_idx - 1]
      when 'right'
        [curr_row_idx, curr_col_idx + 1]
      else
        raise "Invalid direction #{direction}"
      end
    end

    def node_value(row_idx, col_idx, direction)
      "#{row_idx},#{col_idx} #{direction}"
    end
  end
end
