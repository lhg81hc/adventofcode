require 'forwardable'
require_relative 'hand_value'
require_relative 'card_combination'

module Day7
  class Hand
    extend Forwardable

    attr_reader :str, :bid

    def initialize(str, bid)
      @str = str
      @bid = bid
    end

    # 'AJJJ2' --> ['A', 'J', 'J', 'J', '2']
    def card_ranks
      @card_ranks ||= str.scan(/\w/)
    end

    def hand_value
      @hand_value ||= Day7::HandValue.new(card_ranks)
    end

    def card_combination
      @card_combination ||= Day7::CardCombination.new(card_ranks)
    end

    def strongest_possible_combination
      @strongest_possible_combination ||= card_combination.strongest_possible_combination
    end

    def strongest_possible_value
      @strongest_possible_value ||= Day7::HandValue.new(strongest_possible_combination)
    end

    def strongest_possible_type
      strongest_possible_value.type
    end

    def highest_possible_score
      strongest_possible_value.score
    end

    def_delegators :hand_value, :type, :score
  end
end