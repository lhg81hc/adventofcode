require_relative 'city_block'

module Day17
  class MinHeatLossPathFinder
    attr_reader :heat_lost_map

    def initialize(heat_lost_map)
      @heat_lost_map = heat_lost_map
    end

    def find_all_paths

    end

    def minimum_heat_lost(last_three_locations, m, n)
      if n < 0 || m < 0
        max_possible_heat_lost
      elsif n.zero? && m.zero?
        heat_lost_map.find_block_by_location(start_location).heat_loss_amount
      else
        curr_block = heat_lost_map.find_block_by_location([m, n])
        curr_block.heat_loss_amount + [

        ].min
      end
      last_three_locations = []
      curr_block = heat_lost_map.find_block_by_location(start_location)

      next_valid_locations(last_three_locations, curr_block)
    end

    def next_valid_locations(last_three_locations, curr_block)
      last_location = last_three_locations[-1]
      possible_locations = curr_block.adjacent_blocks.map { |b| [b.line_idx, b.char_idx] }

      # puts "last_location: [#{last_location.join(',')}]"
      # puts "possible_locations: #{possible_locations.map { |l| "[#{l.join(', ')}]" }.join(' ')}"
      possible_locations = possible_locations.select { |l| l != last_location } if last_location
      possible_locations = possible_locations.select { |l| l[0] != last_location[0] } if three_horizontal_consecutive_blocks?(last_three_locations)
      possible_locations = possible_locations.select { |l| l[1] != last_location[1] } if three_vertical_consecutive_blocks?(last_three_locations)
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
        heat_lost_map.height - 1,
        heat_lost_map.width - 1
      ]
    end

    def max_possible_heat_lost
      @max_possible_heat_lost ||= 9 * heat_lost_map.height * heat_lost_map.width
    end
  end
end
