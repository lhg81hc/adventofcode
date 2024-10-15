require 'test/unit'
require_relative '../../../year2022/day14/bresenham_line'

module Year2022
  module Day14
    class BresenhamLineTest < Test::Unit::TestCase
      def setup
        @object = Object.new
        @object.extend(BresenhamLine)
      end

      def test_plot_line
        assert_equal([[0, 1], [1, 1], [2, 2], [3, 2], [4, 3], [5, 3], [6, 4]], @object.plot_line(0, 1, 6, 4))
        assert_equal([[502, 119], [502, 120], [502, 121], [502, 122], [502, 123], [502, 124], [502, 125], [502, 126]], @object.plot_line(502, 119, 502, 126))
        assert_equal([[5, 7], [6, 7], [7, 7], [8, 7], [9, 7], [10, 7]], @object.plot_line(10, 7, 5, 7))
      end
    end
  end
end
