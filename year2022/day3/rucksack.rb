require_relative 'supply_item'

module Year2022
  module Day3
    class Rucksack
      attr_accessor :str

      def initialize(str)
        @str = str
      end

      def supply_items
        @supply_items ||=
          str.each_char.each_with_object([]) do |item_type, list|
            list << SupplyItem.new(item_type)
            list
          end
      end

      def middle_index
        supply_items.length / 2 - 1
      end

      def first_compartment
        supply_items[0..middle_index]
      end

      def second_compartment
        supply_items[(middle_index + 1)..-1]
      end
    end
  end
end
