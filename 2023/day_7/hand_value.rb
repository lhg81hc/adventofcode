module Day7
  class HandValue
    TYPES = [:high_card, :one_pair, :two_pair, :three_of_a_kind, :full_house, :four_of_a_kind, :five_of_a_kind]

    attr_reader :card_ranks

    def initialize(card_ranks)
      @card_ranks = card_ranks
    end

    def type
      if five_of_a_kind?
        return :five_of_a_kind
      end

      if four_of_a_kind?
        return :four_of_a_kind
      end

      if full_house?
        return :full_house
      end

      if three_of_a_kind?
        return :three_of_a_kind
      end

      if two_pair?
        return :two_pair
      end

      if one_pair?
        return :one_pair
      end

      if high_card?
        return :high_card
      end

      nil
    end

    def score
      TYPES.find_index(type)
    end

    def five_of_a_kind?
      grouped_cards_by_rank.any? { |_k, v| v == 5 }
    end

    def four_of_a_kind?
      grouped_cards_by_rank.any? { |_k, v| v == 4 }
    end

    def full_house?
      grouped_cards_by_rank.any? { |_k, v| v == 3 } && grouped_cards_by_rank.any? { |_k, v| v == 2 }
    end

    def three_of_a_kind?
      grouped_cards_by_rank.any? { |_k, v| v == 3 } && !grouped_cards_by_rank.any? { |_k, v| v == 2 }
    end

    def two_pair?
      grouped_cards_by_rank.values.select { |v| v == 2 }.count == 2
    end

    def one_pair?
      values = grouped_cards_by_rank.values
      values.select { |v| v == 2 }.count == 1 && values.select { |v| v == 1 }.count == 3
    end

    def high_card?
      grouped_cards_by_rank.values.select { |v| v == 1 }.count == 5
    end

    # ['A', 'K', 'K', 'K', '2'] --> { 'A' => 1, 'K' => 3, '2' = 1 }
    def grouped_cards_by_rank
      @grouped_cards_by_rank ||= card_ranks.tally
    end
  end
end