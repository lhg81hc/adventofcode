require 'test/unit'
require_relative '../../../year2024/day8/diagram'

module Year2024
  module Day8
    class DiagramTest < Test::Unit::TestCase
      def setup
        @input_path = File.join(File.dirname(__FILE__), './input.txt')
        @diagram = Year2024::Day8::Diagram.new(@input_path)
      end

      def test_initialization
        assert_equal(@diagram.input_path.to_s, File.join(File.dirname(__FILE__), './input.txt'))
      end

      def test_antennas
        assert_equal(@diagram.antennas.length, 7)
        assert_equal(@diagram.antennas[0].frequency, '0')
        assert_equal(@diagram.antennas[-1].frequency, 'A')
      end

      def test_all_antenna_frequencies
        assert(@diagram.all_antenna_frequencies.is_a?(Set))
        assert_equal(@diagram.all_antenna_frequencies.to_a, %w[0 A])
      end

      def test_filter_antennas_by_frequency
        assert_equal(@diagram.filter_antennas_by_frequency('Z'), [])
        assert_equal(@diagram.filter_antennas_by_frequency('0').length, 4)
      end

      def test_width
        assert_equal(@diagram.width, nil)
        assert_equal(@diagram.antennas.length, 7)
        assert_equal(@diagram.width, 12)
      end

      def test_height
        assert_equal(@diagram.height, nil)
        assert_equal(@diagram.antennas.length, 7)
        assert_equal(@diagram.height, 12)
      end
    end
  end
end
