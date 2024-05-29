require_relative 'round'

module Day2
  class SecondStrategy < Round
    OPPONENT_OPTIONS = { 'A' => :rock, 'B' => :paper, 'C' => :scissors }
    SHAPES = %i[rock paper scissors].freeze

    def opponent_selected_char
      @str[0]
    end

    def opponent_selected_shape
      OPPONENT_OPTIONS[opponent_selected_char]
    end

    def outcome_char
      @str[-1]
    end

    # 0 means draw, -1 means opponent wins, 1 means you win
    def outcome
      return -1 if outcome_char == 'X'
      return 0 if outcome_char == 'Y'
      return 1 if outcome_char == 'Z'

      raise ArgumentError
    end

    def self_selected_shape
      return opponent_selected_shape if outcome.zero?

      opponent_selected_shape_value = SHAPE_VALUES[opponent_selected_shape]

      self_selected_shape_value =
        if outcome.negative?
          opponent_selected_shape_value - 1
        else
          (opponent_selected_shape_value + 1) % 3
        end

      SHAPES[self_selected_shape_value]
    end
  end
end
