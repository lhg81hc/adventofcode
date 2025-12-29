require 'test/unit'
require_relative '../../../year2025/day2/product_id_ranges'

module Year2025
  module Day2
    class ProductIdRangesTest < Test::Unit::TestCase
      def setup
        @first_production_id_ranges = Year2025::Day2::ProductIdRanges.new('38593856-38593862')
        @second_production_id_ranges = Year2025::Day2::ProductIdRanges.new('998-1012')
      end

      def test_initialization
        assert_equal(@first_production_id_ranges.first_id, 38593856)
        assert_equal(@first_production_id_ranges.last_id, 38593862)
        assert_equal(@second_production_id_ranges.first_id, 998)
        assert_equal(@second_production_id_ranges.last_id, 1012)
      end

      def test_invalid_ids
        assert_equal(@first_production_id_ranges.mirrored_ids, [38593859])
        assert_equal(@second_production_id_ranges.mirrored_ids, [1010])
      end
    end
  end
end