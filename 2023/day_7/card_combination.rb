require_relative 'hand_value_comparison'
require_relative 'hand_value'

module Day7
  class CardCombination
    # The array order is also the strength of each card
    #
    # Eg:
    # '2' is at index 0 and it is the weakest
    # 'A' is at index 12 and it is the strongest
    JOKER_EXCLUDED_CARD_RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'Q', 'K', 'A']

    attr_reader :card_ranks

    def initialize(card_ranks)
      @card_ranks = card_ranks
    end

    def any_joker?
      card_ranks.any? { |rank| rank == 'J' }
    end

    def strongest_possible_combination
      @strongest_possible_combination ||=
        begin
          return card_ranks unless any_joker?

          sorted_combinations =
            possible_combinations.sort do |a, b|
              first_hand_value = Day7::HandValue.new(a)
              second_hand_value = Day7::HandValue.new(b)
              Day7::HandValueComparison.compare(first_hand_value, second_hand_value)
            end

          sorted_combinations.last
        end
    end

    def possible_combinations
      @possible_combinations ||=
        begin
          return [card_ranks] unless any_joker?

          number_of_jokers = card_ranks.tally['J']
          combinations = JOKER_EXCLUDED_CARD_RANKS.repeated_permutation(number_of_jokers).to_a
          combinations.map { |combination| card_ranks.map { |rank| rank == 'J' ? combination.shift : rank } }
        end
    end
  end
end
