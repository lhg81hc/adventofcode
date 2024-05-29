module Day2
  class Round
    SHAPE_VALUES = { rock: 0, paper: 1, scissors: 2 }.freeze

    def initialize(str)
      @str = str
    end

    def opponent_selected_char
      raise NotImplementedError
    end

    def self_selected_char
      raise NotImplementedError
    end

    def self_selected_shape
      raise NotImplementedError
    end

    def opponent_selected_shape
      raise NotImplementedError
    end

    # 0 means draw, -1 means opponent wins, 1 means you win
    def outcome
      return 0 if self_selected_shape == opponent_selected_shape

      opponent_selected_shape_value = SHAPE_VALUES[opponent_selected_shape]
      self_selected_shape_value = SHAPE_VALUES[self_selected_shape]

      if (opponent_selected_shape_value + 1) % 3 == self_selected_shape_value
        1
      else
        -1
      end
    end

    def outcome_to_s
      return 'Draw' if outcome.zero?
      return 'Opponent wins' if outcome.negative?

      'You win'
    end

    def score_by_selected_shape
      SHAPE_VALUES[self_selected_shape] + 1
    end

    def score_by_outcome
      return 0 if outcome.negative?
      return 3 if outcome.zero?

      6 # if you win
    end

    def score
      score_by_outcome + score_by_selected_shape
    end
  end
end