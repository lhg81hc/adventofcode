module Day17
  class CityBlock
    attr_reader :heat_loss_amount
    attr_accessor :adjacent_blocks

    def initialize(heat_loss_amount)
      # @line_idx = line_idx
      # @char_idx = char_idx
      @heat_loss_amount = heat_loss_amount
      @adjacent_blocks = []
    end
  end
end
