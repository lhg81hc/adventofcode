module Day7
  class HandValueComparison
    # The array order is also the strength of each card
    #
    # Eg:
    # '2' is at index 0 and it is the weakest
    # 'A' is at index 13 and it is the strongest
    CARD_RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']

    attr_reader :val_1st, :val_2nd

    def initialize(val_1st, val_2nd)
      @val_1st = val_1st
      @val_2nd = val_2nd
    end

    def self.compare(first_hand, second_hand)
      new(first_hand, second_hand).compare
    end

    def compare
      if val_1st.score > val_2nd.score
        1
      elsif val_1st.score < val_2nd.score
        -1
      else
        card_by_card_comparison
      end
    end

    def card_by_card_comparison
      r = 0

      val_1st.card_ranks.each.with_index do |rank, idx|
        strength_1st = CARD_RANKS.find_index(rank)
        strength_2nd = CARD_RANKS.find_index(val_2nd.card_ranks[idx])

        if strength_1st > strength_2nd
          r = 1
          break
        elsif strength_1st < strength_2nd
          r = -1
          break
        end
      end

      r
    end
  end
end
