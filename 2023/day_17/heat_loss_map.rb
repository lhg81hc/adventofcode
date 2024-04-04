module Day17
  class HeatLossMap
    attr_accessor :blocks

    def initialize(blocks = [])
      @blocks = blocks
    end

    def find_block_by_location(location)
      blocks[location[0]][location[1]]
    end

    def width
      blocks.first.length
    end

    def height
      blocks.length
    end

    def last_row_index
      height - 1
    end

    def last_col_index
      width - 1
    end
  end
end
