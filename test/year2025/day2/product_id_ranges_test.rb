require 'test/unit'
require_relative '../../../year2025/day2/product_id_ranges'

module Year2025
  module Day2
    class ProductIdRangesTest < Test::Unit::TestCase
      def setup
        @first_production_id_ranges = Year2025::Day2::ProductIdRanges.new('3299143-3378031')
        @second_production_id_ranges = Year2025::Day2::ProductIdRanges.new('998-1012')
      end

      def test_initialization
        assert_equal(@first_production_id_ranges.first_id, 3299143)
        assert_equal(@first_production_id_ranges.last_id, 3378031)
        assert_equal(@second_production_id_ranges.first_id, 998)
        assert_equal(@second_production_id_ranges.last_id, 1012)
      end

      def test_invalid_ids
        assert_equal(@first_production_id_ranges.invalid_ids, [])
        assert_equal(@second_production_id_ranges.invalid_ids, [])
      end
    end
  end
end