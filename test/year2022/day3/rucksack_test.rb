require 'test/unit'
require '../year2022/day3/rucksack'

module Year2022
  module Day3
    class RucksackTest < Test::Unit::TestCase
      def setup
        @str = 'vJrwpWtwJgWrhcsFMMfFFhFp'
        @rucksack = Rucksack.new(@str)
      end

      def test_supply_items
        assert_equal(24, @rucksack.supply_items.length)
        assert_equal('v', @rucksack.supply_items.first.type)
        assert_equal('p', @rucksack.supply_items.last.type)
      end

      def test_char_ordinal
        assert_equal(11, @rucksack.middle_index)
      end

      def test_first_compartment
        assert_equal(12, @rucksack.first_compartment.length)
        assert_equal('v', @rucksack.first_compartment.first.type)
        assert_equal('r', @rucksack.first_compartment.last.type)
      end

      def test_second_compartment
        assert_equal(12, @rucksack.second_compartment.length)
        assert_equal('h', @rucksack.second_compartment.first.type)
        assert_equal('p', @rucksack.second_compartment.last.type)
      end

      def test_common_item_types
        assert_equal(['p'], @rucksack.common_item_types)
      end
    end
  end
end
