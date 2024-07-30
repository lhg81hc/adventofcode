require_relative 'stand_alone_item'
require_relative 'group_item'

module Year2022
  module Day13
    class Pair
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

      private

      def compare_group_items(left_group, right_group)
        unless left_group.is_a?(Year2022::Day13::GroupItem) && right_group.is_a?(Year2022::Day13::GroupItem)
          raise ArgumentError, 'Both items must be GroupItems'
        end

        left_group.stand_alone_items.each.with_index do |left_item, index|
          right_item = right_group.stand_alone_items[index]
          comparison_result = compare_items(left_item, right_item)
          return comparison_result unless comparison_result.zero?
        end

        compare_group_sizes(left_group, right_group)
      end

      def compare_items(left_item, right_item)
        return compare_nil(left_item, right_item) if left_item.nil? || right_item.nil?

        if left_item.is_a?(Year2022::Day13::StandAloneItem) && right_item.is_a?(Year2022::Day13::StandAloneItem)
          compare_stand_alone_items(left_item, right_item)
        elsif left_item.is_a?(Year2022::Day13::GroupItem) && right_item.is_a?(Year2022::Day13::GroupItem)
          compare_group_items(left_item, right_item)
        elsif left_item.is_a?(Year2022::Day13::StandAloneItem)
          compare_group_items(Year2022::Day13::GroupItem.new([left_item]), right_item)
        elsif right_item.is_a?(Year2022::Day13::StandAloneItem)
          compare_group_items(left_item, Year2022::Day13::GroupItem.new([right_item]))
        else
          raise ArgumentError, 'Unknown comparison item types'
        end
      end

      def compare_nil(left, right)
        raise ArgumentError, 'Invalid inputs' unless left.nil? || right.nil?

        return LEFT_EQUALS_RIGHT if left.nil? && right.nil?
        return RIGHT_ORDER if left.nil?

        WRONG_ORDER
      end

      def compare_stand_alone_items(left, right)
        raise ArgumentError unless left.is_a?(Year2022::Day13::StandAloneItem) && right.is_a?(Year2022::Day13::StandAloneItem)

        if left.value == right.value
          LEFT_EQUALS_RIGHT
        elsif left.value < right.value
          RIGHT_ORDER
        else
          WRONG_ORDER
        end
      end

      def compare_group_sizes(left_group, right_group)
        if left_group.stand_alone_items.length < right_group.stand_alone_items.length
          RIGHT_ORDER
        else
          LEFT_EQUALS_RIGHT
        end
      end
    end
  end
end
