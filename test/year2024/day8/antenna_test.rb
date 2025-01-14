require 'test/unit'
require_relative '../../../year2024/day8/antenna'

module Year2024
  module Day8
    class AntennaTest < Test::Unit::TestCase
      def setup
        @frequency = 'a'
        @row_index = 10
        @char_index = 9
        @antenna = Year2024::Day8::Antenna.new(@frequency, @row_index, @char_index)
      end

      def test_initialization
        assert_equal(@antenna.frequency, 'a')
        assert_equal(@antenna.row_index, 10)
        assert_equal(@antenna.char_index, 9)
      end
    end
  end
end
