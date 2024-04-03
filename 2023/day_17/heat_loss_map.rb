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
  end
end
