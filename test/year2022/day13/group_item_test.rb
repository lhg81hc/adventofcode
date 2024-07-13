require 'test/unit'
require_relative '../../../year2022/day13/stand_alone_item'
require_relative '../../../year2022/day13/group_item'

module Year2022
  module Day13
    class GroupItemTest < Test::Unit::TestCase
      def setup
        @item = Year2022::Day13::StandAloneItem.new(10)
        @group_item = Year2022::Day13::GroupItem.new([@item])
      end

      def test_initialization
        assert_equal([@item], @group_item.stand_alone_items)
      end

      def test_add_item
        another_item = Year2022::Day13::StandAloneItem.new(69)
        @group_item.add_item(another_item)

        assert_equal([@item, another_item], @group_item.stand_alone_items)
      end
    end
  end
end
