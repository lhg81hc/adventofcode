module Day17
  class CityBlock
    attr_reader :line_idx, :char_idx, :heat_loss_amount, :adjacent_blocks

    def initialize(line_idx, char_idx, heat_loss_amount, adjacent_blocks = [])
      @line_idx = line_idx
      @char_idx = char_idx
      @heat_loss_amount = heat_loss_amount
      @adjacent_blocks = adjacent_blocks
    end

    def location
      [line_idx, char_idx]
    end

    def name
      "#{line_idx},#{char_idx}"
    end

    def add_adjacent_block(block)
      @adjacent_blocks << block
    end
  end
end
