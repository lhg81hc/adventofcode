require 'test/unit'
require_relative '../../../year2022/day14/line_of_rock'
require_relative '../../../year2022/day14/rock'

module Year2022
  module Day14
    class LineOfRockTest < Test::Unit::TestCase
      def setup
        @first_rock = Year2022::Day14::Rock.new('525,75')
        @last_rock = Year2022::Day14::Rock.new('525,77')
        @line_of_rock = Year2022::Day14::LineOfRock.new(@first_rock, @last_rock)
      end

      def test_initialization
        assert_equal(@first_rock, @line_of_rock.first_rock)
        assert_equal(@last_rock, @line_of_rock.last_rock)
      end

      def test_points
        assert_equal([[525, 75], [525, 76], [525, 77]], @line_of_rock.points)
      end
    end
  end
end
