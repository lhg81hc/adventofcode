require 'test/unit'
require_relative '../../../year2022/day13/pair'
require_relative '../../../year2022/day13/package_parser'

module Year2022
  module Day13
    class PairTest < Test::Unit::TestCase
      def setup
        @parser = Year2022::Day13::PackageParser.new

        @first_package = @parser.parse('[1,1,3,1,1]')
        @second_package = @parser.parse('[1,1,5,1,1]')

        @pair = Year2022::Day13::Pair.new(@first_package, @second_package)
      end

      def test_initialization
        assert_equal(@first_package, @pair.first_package)
        assert_equal(@second_package, @pair.second_package)
      end

      def test_compare_when_items_are_all_integers
        assert_equal(-1, @pair.compare)
      end

      def test_compare_when_right_package_runs_out_of_item_first
        left = @parser.parse('[7,7,7,7]')
        right = @parser.parse('[7,7,7]')
        another_pair = Year2022::Day13::Pair.new(left, right)

        assert_equal(1, another_pair.compare)
      end

      def test_compare_when_left_package_runs_out_of_item_first
        left = @parser.parse('[[4,4],4,4]')
        right = @parser.parse('[[4,4],4,4,4]')
        another_pair = Year2022::Day13::Pair.new(left, right)

        assert_equal(-1, another_pair.compare)
      end

      def test_compare_when_left_package_is_empty_but_right_package_is_not
        left = @parser.parse('[]')
        right = @parser.parse('[3]')
        another_pair = Year2022::Day13::Pair.new(left, right)

        assert_equal(-1, another_pair.compare)
      end

      def test_compare_when_items_are_mixed_of_complicated_nested_array_and_integers
        left = @parser.parse('[[1],[2,3,4]]')
        right = @parser.parse('[[1],4]')
        another_pair = Year2022::Day13::Pair.new(left, right)

        assert_equal(-1, another_pair.compare)

        left = @parser.parse('[9]')
        right = @parser.parse('[[8,7,6]]')
        @pair = Year2022::Day13::Pair.new(left, right)

        assert_equal(1, @pair.compare)

        left = @parser.parse('[[[]]]')
        right = @parser.parse('[[]]')
        @pair = Year2022::Day13::Pair.new(left, right)

        assert_equal(1, @pair.compare)

        left = @parser.parse('[1,[2,[3,[4,[5,6,7]]]],8,9]')
        right = @parser.parse('[1,[2,[3,[4,[5,6,0]]]],8,9]')
        @pair = Year2022::Day13::Pair.new(left, right)

        assert_equal(1, @pair.compare)
      end
    end
  end
end
