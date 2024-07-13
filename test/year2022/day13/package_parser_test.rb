require 'test/unit'
require_relative '../../../year2022/day13/package_parser'
require_relative '../../../year2022/day13/stand_alone_item'
require_relative '../../../year2022/day13/group_item'

module Year2022
  module Day13
    class PackageParserTest < Test::Unit::TestCase
      def setup
        @parser = Year2022::Day13::PackageParser.new
      end

      def test_parse_with_only_integers_input
        result = @parser.parse('[1,1,3,1,1]')

        assert(result.is_a?(Array))
        assert_equal(5, result.length)

        first_item = result.first
        assert(first_item.is_a?(Year2022::Day13::StandAloneItem))
        assert_equal(1, first_item.value)
      end

      def test_parse_with_nested_non_empty_arrays_input
        result = @parser.parse('[[1],[2,3,4]]')
        assert_equal(2, result.length)

        last_item = result.last
        assert(last_item.is_a?(Year2022::Day13::GroupItem))
        assert_equal(3, last_item.stand_alone_items.length)
        assert_equal(2, last_item.stand_alone_items.first.value)
      end

      def test_parse_with_nested_empty_arrays_input
        result = @parser.parse('[[[]]]')
        assert_equal(1, result.length)

        group_item = result.first
        assert(group_item.is_a?(Year2022::Day13::GroupItem))
        assert_equal(1, group_item.stand_alone_items.length)

        nested_group_item = group_item.stand_alone_items.first
        assert(nested_group_item.is_a?(Year2022::Day13::GroupItem))
        assert_equal(0, nested_group_item.stand_alone_items.length)
      end

      def test_parse_with_complicated_input
        result = @parser.parse('[1,[2,[3,[4,[5,6,0]]]],8,10]')

        assert_equal(4, result.length)

        first_item = result.first
        assert(first_item.is_a?(Year2022::Day13::StandAloneItem))
        assert_equal(1, first_item.value)

        second_item = result[1]
        assert(second_item.is_a?(Year2022::Day13::GroupItem))
        assert_equal(2, second_item.stand_alone_items.length)

        last_item = result.last
        assert(last_item.is_a?(Year2022::Day13::StandAloneItem))
        assert_equal(10, last_item.value)
      end
    end
  end
end
