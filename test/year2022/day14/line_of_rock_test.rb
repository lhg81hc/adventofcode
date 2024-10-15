require 'test/unit'
require_relative '../../../year2022/day14/line_of_rock'
require_relative '../../../year2022/day14/point'

module Year2022
  module Day14
    class LineOfRockTest < Test::Unit::TestCase
      def setup
        @starting_point = Year2022::Day14::Point.new('525,75')
        @ending_point = Year2022::Day14::Point.new('525,77')
        @line_of_rock = Year2022::Day14::LineOfRock.new(@starting_point, @ending_point)
      end

      def test_initialization
        assert_equal(@starting_point, @line_of_rock.starting_point)
        assert_equal(@ending_point, @line_of_rock.ending_point)
      end
    end
  end
end
