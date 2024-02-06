module Day7
  class CamelCardHandComparison
    # The array order is also the strength of each card
    #
    # Eg:
    # '2' is at index 0 and it is the weakest
    # 'A' is at index 13 and it is the strongest
    CARD_RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]

    attr_reader :first_hand, :second_hand

    def initialize(first_hand, second_hand)
      @first_hand = first_hand
      @second_hand = second_hand
    end

    def self.compare(first_hand, second_hand)
      new(first_hand, second_hand).compare
    end

    def compare
      if first_hand.score > second_hand.score
        1
      elsif first_hand.score < second_hand.score
        -1
      else
        card_by_card_comparison
      end
    end

    def card_by_card_comparison
      r = 0

      first_hand.cards.each.with_index do |card, idx|
        first_hand_card_rank = CARD_RANKS.find_index(card.rank)
        second_hand_card_rank = CARD_RANKS.find_index(second_hand.cards[idx].rank)

        if first_hand_card_rank > second_hand_card_rank
          r = 1
          break
        elsif first_hand_card_rank < second_hand_card_rank
          r = -1
          break
        end
      end

      r
    end
  end
end
