require_relative 'supply_item'

module Year2022
  module Day3
    class CommonItemTypesFinder
      attr_accessor :supply_items_lists

      def initialize(supply_items_lists)
        @supply_items_lists = supply_items_lists
      end

      def self.find(supply_items_lists)
        new(supply_items_lists).find
      end

      def find
        return [] if supply_items_lists.empty? || supply_items_lists.length == 1

        supply_items_lists.reduce(supply_items_lists.first.map(&:type)) do |types, supply_items|
          types &= supply_items.map(&:type)
          types
        end
      end
    end
  end
end
