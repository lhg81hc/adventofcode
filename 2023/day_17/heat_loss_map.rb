module Day17
  class HeatLossMap
    attr_accessor :two_d_map

    def initialize(two_d_map = [])
      @two_d_map = two_d_map
    end

    def add_city_block(city_block)
      @two_d_map[city_block.line_idx] ||= []
      @two_d_map[city_block.line_idx][city_block.char_idx] = city_block

      update_adjacent_blocks(city_block)
    end

    def update_adjacent_blocks(city_block)
      adjacent_blocks =
        adjacent_locations(city_block.line_idx, city_block.char_idx).inject([]) do |r, l|
          adjacent_block = two_d_map.dig(l[0], l[1])
          r << adjacent_block if adjacent_block
          r
        end


      adjacent_blocks.each do |adjacent_block|
        adjacent_block.add_adjacent_block(city_block)
        city_block.add_adjacent_block(adjacent_block)
      end
    end

    def adjacent_locations(line_idx, char_idx)
      locations =
        [
          [line_idx - 1, char_idx],
          [line_idx + 1, char_idx],
          [line_idx, char_idx - 1],
          [line_idx, char_idx + 1],
        ]

      locations.select { |l| l[0] >= 0 && l[1] >= 0 }
    end

    def find_block_by_location(location)
      two_d_map.dig(location[0], location[1])
    end

    def width
      two_d_map.last.length
    end

    def height
      two_d_map.length
    end

    def last_row_index
      height - 1
    end

    def last_col_index
      width - 1
    end
  end
end
