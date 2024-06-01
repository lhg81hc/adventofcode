require 'test/unit'
require './2022/day2/first_strategy'

module Year2022
  module Day2
    class FirstStrategyTest < Test::Unit::TestCase
      def setup
        @str = 'A X'
        @first_strategy = ::Day2::FirstStrategy.new(@str)
      end

      def test_opponent_selected_char
        assert_equal('A', @first_strategy.opponent_selected_char)
      end

      def test_self_selected_char

      end

      def test_opponent_selected_shape

      end
    end
  end
end
