require 'test/unit'
require './year2022/day2/second_strategy'

module Year2022
  module Day2
    class SecondStrategyTest < Test::Unit::TestCase
      def setup
        @str = 'C Z'
        @second_strategy = Year2022::Day2::SecondStrategy.new(@str)
      end

      def test_opponent_selected_char
        assert_equal('C', @second_strategy.opponent_selected_char)
      end

      def test_opponent_selected_shape
        assert_equal(:scissors, @second_strategy.opponent_selected_shape)
      end

      def test_outcome_char
        assert_equal('Z', @second_strategy.outcome_char)
      end

      def test_outcome
        assert_equal(1, @second_strategy.outcome)
      end

      def test_outcome_to_s
        assert_equal('You win', @second_strategy.outcome_to_s)
      end

      def test_self_selected_shape
        assert_equal(:rock, @second_strategy.self_selected_shape)
      end

      def test_score_by_selected_shape
        assert_equal(1, @second_strategy.score_by_selected_shape)
      end

      def test_score_by_outcome
        assert_equal(6, @second_strategy.score_by_outcome)
      end

      def test_score
        assert_equal(7, @second_strategy.score)
      end
    end
  end
end
