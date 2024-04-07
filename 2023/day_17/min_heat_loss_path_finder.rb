require_relative 'city_block'

module Day17
  class MinHeatLossPathFinder
    attr_reader :heat_lost_map

    def initialize(heat_lost_map)
      @heat_lost_map = heat_lost_map
      @count = 0
    end

    # Idea:
    # Start in the TOP LEFT block
    # If all possible paths have been tried return true
    # Try all possible next blocks
    #   If the block is valid for next move
    #     Then mark this [row, column] as part of the solution and recursively check if this block leads to a solution.
    #       If the current block is a part of a solution then return true.
    #       If the current block doesn’t lead to a solution then unmark this [row, column] then backtrack and try other blocks.
    #       If all blocks have been tried and valid solution is not found return false to trigger backtracking.
    def find_all_paths
      traversal_history = []
      find_paths(traversal_history, start_location)

    end

    def find_minimum_heat_loss_path

    end

    def find_paths(traversal_history, curr_location)
      return if @count > 1000
      @count += 1

      # Base case: if m == last row and n == last col
      # if curr_location == goal_location
      #   return true
      # end

      curr_block = heat_lost_map.find_block_by_location(curr_location)
      next_locations = next_valid_locations(traversal_history, curr_block)

      if next_locations.any? { |l| l == goal_location }
        puts "found"
        puts "#{traversal_history.map { |t| "[#{t.join(',')}]" }.join(" ")}"
        return true
      end

      next_locations.each do |next_location|
        traversal_history << curr_location
        return true if find_paths(traversal_history, next_location)
        traversal_history.pop
      end

      false
    end

    def next_valid_locations(traversal_history, curr_block)
      # last_three_locations = [traversal_history[-3], traversal_history[-2], traversal_history[-1]].compact
      last_visited_location = traversal_history[-1]
      most_recent_locations = [traversal_history[-2], traversal_history[-1], curr_block.location].compact
      possible_locations = curr_block.adjacent_blocks.map { |b| [b.line_idx, b.char_idx] }

      puts "traversal_history: #{traversal_history.map { |t| "[#{t.join(',')}]" }.join(" ")}"
      puts "current location: [#{curr_block.line_idx},#{curr_block.char_idx}]"

      possible_locations = possible_locations.select { |l| !traversal_history.include?(l) }
      possible_locations = possible_locations.select { |l| l[0] != last_visited_location[0] } if three_horizontal_consecutive_blocks?(most_recent_locations)
      possible_locations = possible_locations.select { |l| l[1] != last_visited_location[1] } if three_vertical_consecutive_blocks?(most_recent_locations)
      puts "possible_locations: #{possible_locations.map { |l| "[#{l.join(', ')}]" }.join(' ')}"
      puts "\n"
      possible_locations
    end

    def three_horizontal_consecutive_blocks?(last_three_locations)
      return false unless last_three_locations.length == 3

      last_three_locations[0][0] == last_three_locations[1][0] &&
        last_three_locations[0][0] == last_three_locations[2][0]
    end

    def three_vertical_consecutive_blocks?(last_three_locations)
      return false unless last_three_locations.length == 3

      last_three_locations[0][1] == last_three_locations[1][1] &&
        last_three_locations[0][1] == last_three_locations[2][1]
    end

    def start_location
      @start_location ||= [0, 0]
    end

    def goal_location
      @goal_location ||= [
        heat_lost_map.last_row_index,
        heat_lost_map.last_col_index,
      ]
    end

    def max_possible_heat_lost
      @max_possible_heat_lost ||= 9 * heat_lost_map.height * heat_lost_map.width
    end

    def dijkstra(source_name)
      dist = {}
      q = []

      vertices.each do |vertex|
        dist[vertex.name] = Float::INFINITY
        q << vertex
      end

      dist[source_name] = 0

      until q.empty?
        min = nil
        u_idx = nil

        q.each.with_index do |vertex, idx|
          if min.nil?
            min = dist[vertex.name]
            u_idx = idx
            next
          end

          if dist[vertex.name] < min
            min = dist[vertex.name]
            u_idx = idx
          end
        end

        u = q.delete_at(u_idx)

        u.neighbors.each.with_index do |neighbor, neighbor_idx|
          next unless q.find { |v| v.name == neighbor.name }
          alt = dist[u.name] + u.weights[neighbor_idx]

          if alt < dist[neighbor.name]
            dist[neighbor.name] = alt
          end
        end
      end

      dist
    end
  end
end
