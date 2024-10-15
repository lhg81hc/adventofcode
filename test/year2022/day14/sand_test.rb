require 'test/unit'
require_relative '../../../year2022/day14/sand'

module Year2022
  module Day14
    class SandTest < Test::Unit::TestCase
      def setup
        @sand = Year2022::Day14::Sand.new
      end

      def test_initialization
        assert_equal([500, 0], @sand.coordinates)
      end

      def test_next_potential_coordinates
        # in case of starting position
        assert_equal([[500, 1], [499, 1], [501, 1]], @sand.next_potential_coordinates)

        # in case of custom position
        @sand.coordinates = [45, 67]
        assert_equal([[45, 68], [44, 68], [46, 68]], @sand.next_potential_coordinates)
      end

      def test_flew_into_abyss?
        @sand.flew_into_abyss = true
        assert(@sand.flew_into_abyss?)

        @sand.flew_into_abyss = false
        refute(@sand.flew_into_abyss?)
      end
    end
  end
end
