require 'test/unit'
require_relative '../../../year2024/day1/similarity_score_finder'

module Year2024
  module Day1
    class SimilarityScoreFinderTest < Test::Unit::TestCase
      def setup
        @first_list = [3, 4, 2, 1, 3, 3]
        @second_list = [4, 3, 5, 3, 9, 3]

        @similarity_score_finder = Year2024::Day1::SimilarityScoreFinder.new(@first_list, @second_list)
      end

      def test_initialization
        assert_equal(@similarity_score_finder.first_list, [3, 4, 2, 1, 3, 3])
        assert_equal(@similarity_score_finder.second_list, [4, 3, 5, 3, 9, 3])
      end

      def test_score
        assert_equal(@similarity_score_finder.score, 31)
      end
    end
  end
end