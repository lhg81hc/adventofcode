require 'test/unit'
require_relative '../../../year2024/day4/word_search'

module Year2024
  module Day2
    class WordSearchTest < Test::Unit::TestCase
      def setup
        @input_path = File.join(File.dirname(__FILE__), './input.txt')
        @word_search = Year2024::Day4::WordSearch.new(@input_path)
      end

      def test_initialization
        assert_equal(@word_search.input_path.to_s, File.join(File.dirname(__FILE__), './input.txt'))
      end

      def test_scanned?
        refute(@word_search.scanned?)

        @word_search.scan

        assert(@word_search.scanned?)
      end

      def test_height
        assert_equal(@word_search.height, 0)

        @word_search.scan

        assert_equal(@word_search.height, 10)
      end

      def test_width
        assert_equal(@word_search.width, 0)

        @word_search.scan

        assert_equal(@word_search.width, 10)
      end

      def test_search_xmas
        assert_equal(@word_search.search_xmas, 18)
      end

      def test_search_x_mas
        assert_equal(@word_search.search_x_mas, 9)
      end
    end
  end
end
