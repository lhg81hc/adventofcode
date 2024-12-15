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

      def test_search
        assert_equal(@word_search.search, 18)
      end
    end
  end
end
