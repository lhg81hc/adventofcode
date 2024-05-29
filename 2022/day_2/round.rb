module Day2
  class Round
    OPPONENT_OPTIONS = { 'A' => :rock, 'B' => :paper, 'C' => :scissors }
    SELF_OPTIONS = { 'X' => :rock, 'Y' => :paper, 'Z' => :scissors }
    SHAPES = {
      rock: {
        value: 0,
        score: 1
      },
      paper: {
        value: 1,
        score: 2
      },
      scissors: {
        value: 2,
        score: 3
      },
    }

    def initialize(str)
      @str = str
    end

    def opponent_selected_char
      @str[0]
    end

    def self_selected_char
      @str[-1]
    end

    def self_selected_shape
      SELF_OPTIONS[self_selected_char]
    end

    def opponent_selected_shape
      OPPONENT_OPTIONS[opponent_selected_char]
    end

    # 0 means draw, -1 means opponent wins, 1 means you win
    def outcome
      return 0 if self_selected_shape == opponent_selected_shape

      opponent_selected_shape_value = SHAPES[opponent_selected_shape][:value]
      self_selected_shape_value = SHAPES[self_selected_shape][:value]

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
      SHAPES[self_selected_shape][:score]
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