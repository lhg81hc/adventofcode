require 'test/unit'
require './year2022/day3/common_item_types_finder'
require './year2022/day3/rucksack'

module Year2022
  module Day3
    class CommonItemTypesFinderTest < Test::Unit::TestCase
      class SupplyItemsFromRucksackCompartments < CommonItemTypesFinderTest
        def setup
          @rucksack = Year2022::Day3::Rucksack.new('vJrwpWtwJgWrhcsFMMfFFhFp')
          @first_supply_items_list = @rucksack.first_compartment
          @second_supply_items_list = @rucksack.second_compartment
          @finder = Year2022::Day3::CommonItemTypesFinder.new([@first_supply_items_list, @second_supply_items_list])
        end

        def test_find
          assert_equal(['p'], @finder.find)
        end
      end

      class SupplyItemsFromDifferentRucksacks < CommonItemTypesFinderTest
        def setup
          @first_rucksack = Year2022::Day3::Rucksack.new('vJrwpWtwJgWrhcsFMMfFFhFp')
          @second_rucksack = Year2022::Day3::Rucksack.new('jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL')
          @third_rucksack = Year2022::Day3::Rucksack.new('PmmdzqPrVvPwwTWBwg')
          @finder = Year2022::Day3::CommonItemTypesFinder.new(
            [@first_rucksack.supply_items, @second_rucksack.supply_items, @third_rucksack.supply_items]
          )
        end

        def test_find
          assert_equal(['r'], @finder.find)
        end
      end

      class BlankSupplyItems < CommonItemTypesFinderTest
        def setup
          @finder = Year2022::Day3::CommonItemTypesFinder.new([])
        end

        def test_find
          assert_equal([], @finder.find)
        end
      end
    end
  end
end
