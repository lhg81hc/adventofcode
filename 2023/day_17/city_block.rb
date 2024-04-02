module Day17
  class CityBlock
    attr_reader :line_idx, :char_idx, :heat_loss_amount
    attr_accessor :adjacent_blocks

    def initialize(line_idx, char_idx, heat_loss_amount, adjacent_blocks = [])
      @line_idx = line_idx
      @char_idx = char_idx
      @heat_loss_amount = heat_loss_amount
      @adjacent_blocks = adjacent_blocks
    end
  end
end
