require 'test/unit'
require_relative '../../../year2022/day2/first_strategy'

module Year2022
  module Day2
    class FirstStrategyTest < Test::Unit::TestCase
      def setup
        @str = 'A X'
        @first_strategy = Year2022::Day2::FirstStrategy.new(@str)
      end

      def test_opponent_selected_char
        assert_equal('A', @first_strategy.opponent_selected_char)
      end

      def test_self_selected_char
        assert_equal('X', @first_strategy.self_selected_char)
      end

      def test_self_selected_shape
        assert_equal(:rock, @first_strategy.self_selected_shape)
      end

      def test_opponent_selected_shape
        assert_equal(:rock, @first_strategy.opponent_selected_shape)
      end

      def test_outcome
        assert_equal(0, @first_strategy.outcome)
      end

      def test_outcome_to_s
        assert_equal('Draw', @first_strategy.outcome_to_s)
      end

      def test_score_by_selected_shape
        assert_equal(1, @first_strategy.score_by_selected_shape)
      end

      def test_score_by_outcome
        assert_equal(3, @first_strategy.score_by_outcome)
      end

      def test_score
        assert_equal(4, @first_strategy.score)
      end
    end
  end
end
