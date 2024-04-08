require_relative 'city_block'

module Day17
  class MinHeatLossPathFinder
    attr_reader :heat_lost_map

    def initialize(heat_lost_map)
      @heat_lost_map = heat_lost_map
      @count = 0
    end

    # Idea:
    #
    # Start at the starting point.
    # For each of the four possible directions (up, down, left, right), try moving in that direction.
    # If moving in that direction leads to the ending point, return the path taken.
    # If moving in that direction does not lead to the ending point, backtrack to the previous position and try a different direction.
    # Repeat steps 2-4 until the ending point is reached or all possible paths have been explored.
    def find_all_paths
      current_path = []
      paths = []

      find_path(current_path, paths, start_location)

      # paths.each do |path|
      #   puts path.map do |location|
      #     location.join(',')
      #   end.join(' ')
      # end
    end

    def find_path(current_path, paths, curr_location)
      return if @count > 2000
      @count += 1

      # Base case: if m == last row and n == last col
      if curr_location == goal_location
        current_path.map { |location| location.join(',') }.join(' ')
        paths << current_path
        return true
      end

      curr_block = heat_lost_map.find_block_by_location(curr_location)
      next_locations = next_valid_locations(current_path, curr_block)

      next_locations.each do |next_location|
        current_path << curr_location
        find_path(current_path, paths, next_location)
        current_path.pop

        # current_path << curr_location
        #
        # if find_path(current_path, next_location)
        #   puts "found"
        #   puts "#{current_path.map { |t| "[#{t.join(',')}]" }.join(" ")}"
        #   return nil
        #   # puts "pop #{curr_location.join(',')}"
        # end
        #
        # current_path.pop
      end


      # visited[curr_block.name] = nil
    end

    def next_valid_locations(current_path, curr_block)
      # last_three_locations = [current_path[-3], current_path[-2], current_path[-1]].compact
      last_visited_location = current_path[-1]
      most_recent_locations = [current_path[-2], current_path[-1], curr_block.location].compact
      possible_locations = curr_block.adjacent_blocks.map(&:location)

      puts "current_path: #{current_path.map { |t| "[#{t.join(',')}]" }.join(" ")}"
      puts "current location: [#{curr_block.line_idx},#{curr_block.char_idx}]"

      possible_locations = possible_locations.select { |l| !current_path.include?(l) }
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
  end
end
