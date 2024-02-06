require_relative 'hand_value_comparison'

module Day7
  class HandComparison
    # The array order is also the strength of each card
    #
    # Eg:
    # '2' is at index 0 and it is the weakest
    # 'A' is at index 13 and it is the strongest
    JOKER_INCLUDED_CARD_RANKS = ['J', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'Q', 'K', 'A']

    attr_reader :first_hand, :second_hand, :joker_included

    def initialize(first_hand, second_hand, joker_included = false)
      @first_hand = first_hand
      @second_hand = second_hand
      @joker_included = joker_included
    end

    def self.compare(first_hand, second_hand, joker_included = false)
      new(first_hand, second_hand, joker_included).compare
    end

    def compare
      if joker_included
        compare_best_possible
      else
        compare_value
      end
    end

    def compare_value
      Day7::HandValueComparison.new(first_hand.hand_value, second_hand.hand_value).compare
    end

    def compare_best_possible
      if first_hand.highest_possible_score > second_hand.highest_possible_score
        1
      elsif first_hand.highest_possible_score < second_hand.highest_possible_score
        -1
      else
        card_by_card_comparison
      end
    end

    def card_by_card_comparison
      r = 0

      first_hand.card_ranks.each.with_index do |rank, idx|
        strength_1st = JOKER_INCLUDED_CARD_RANKS.find_index(rank)
        strength_2nd = JOKER_INCLUDED_CARD_RANKS.find_index(second_hand.card_ranks[idx])

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
