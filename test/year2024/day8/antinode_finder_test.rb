require 'test/unit'
require_relative '../../../year2024/day8/diagram'
require_relative '../../../year2024/day8/antenna'

module Year2024
  module Day8
    class AntinodeFinderTest < Test::Unit::TestCase
      def setup
        @input_path = File.join(File.dirname(__FILE__), './input.txt')
        @diagram = Year2024::Day8::Diagram.new(@input_path)
      end
      #
      # def test_initialization
      #   assert_equal(@antinode_finder.antennas, [@first_antenna, @second_antenna, @third_antenna])
      # end

      def test_antinode_location
        antenna = Year2024::Day8::Antenna.new('0', 2, 5)
        another_antenna = Year2024::Day8::Antenna.new('0', 1, 8)

        assert_equal(@diagram.antinode_location(antenna, another_antenna), [3, 2])
        assert_equal(@diagram.antinode_location(another_antenna, antenna), [0, 11])

        antenna = Year2024::Day8::Antenna.new('0', 3, 7)
        another_antenna = Year2024::Day8::Antenna.new('0', 4, 7)
        assert_equal(@diagram.antinode_location(antenna, another_antenna), [2, 7])
        assert_equal(@diagram.antinode_location(another_antenna, antenna), [5, 7])

        antenna = Year2024::Day8::Antenna.new('0', 3, 7)
        another_antenna = Year2024::Day8::Antenna.new('0', 3, 5)
        assert_equal(@diagram.antinode_location(antenna, another_antenna), [3, 9])
        assert_equal(@diagram.antinode_location(another_antenna, antenna), [3, 3])

        antenna = Year2024::Day8::Antenna.new('0', 4, 4)
        another_antenna = Year2024::Day8::Antenna.new('0', 4, 4)
        assert_equal(@diagram.antinode_location(antenna, another_antenna), [4, 4])
      end

      def test_find_antinode_locations_by_frequency
        expectation = Set.new(["0,11", "3,2", "5,6", "7,0", "1,3", "4,9", "0,6", "6,3", "2,10", "5,1"])
        assert_equal(@diagram.find_antinode_locations_by_frequency('0'), expectation)
      end
    end
  end
end
