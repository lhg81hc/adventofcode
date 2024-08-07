require_relative 'group_item'
require_relative 'package_comparison'

module Year2022
  module Day13
    class Pair
      include PackageComparison

      LEFT_EQUALS_RIGHT = 0
      RIGHT_ORDER = -1
      WRONG_ORDER = 1

      attr_reader :first_package, :second_package, :first_group_item, :second_group_item

      def initialize(first_package, second_package)
        @first_package = first_package
        @second_package = second_package
        @first_group_item = Year2022::Day13::GroupItem.new(first_package.items)
        @second_group_item = Year2022::Day13::GroupItem.new(second_package.items)
      end

      def right_order?
        compare_group_items(first_group_item, second_group_item) == RIGHT_ORDER
      end
    end
  end
end
