require 'test/unit'
require '../year2022/day3/supply_item'

module Year2022
  module Day3
    class SupplyItemTest < Test::Unit::TestCase
      def setup
        @str1 = 't'
        @str2 = 'H'
        @supply_item1 = Year2022::Day3::SupplyItem.new(@str1)
        @supply_item2 = Year2022::Day3::SupplyItem.new(@str2)
      end

      def test_priority
        assert_equal(20, @supply_item1.priority)
        assert_equal(34, @supply_item2.priority)
      end

      def test_type_ordinal
        assert_equal(116, @supply_item1.type_ordinal)
        assert_equal(72, @supply_item2.type_ordinal)
      end

      def test_lowercase?
        assert_equal(true, @supply_item1.lowercase?)
        assert_equal(false, @supply_item2.lowercase?)
      end

      def test_uppercase?
        assert_equal(false, @supply_item1.uppercase?)
        assert_equal(true, @supply_item2.uppercase?)
      end
    end
  end
end
