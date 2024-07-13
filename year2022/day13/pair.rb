require_relative 'stand_alone_item'
require_relative 'group_item'

module Year2022
  module Day13
    LEFT_EQUALS_RIGHT = 0
    RIGHT_ORDER = -1
    WRONG_ORDER = 1

    class Pair
      attr_reader :first_package, :second_package

      def initialize(first_package, second_package)
        @first_package = first_package
        @second_package = second_package
      end

      def right_order?
        compare == RIGHT_ORDER
      end

      def compare
        first_group_item = Year2022::Day13::GroupItem.new(first_package.items)
        second_group_item = Year2022::Day13::GroupItem.new(second_package.items)

        compare_group_item(first_group_item, second_group_item)
      end

      def compare_nil(left, right)
        return LEFT_EQUALS_RIGHT if left.nil? && right.nil?
        return WRONG_ORDER if !left.nil? && right.nil?
        return RIGHT_ORDER if left.nil? && !right.nil?

        raise ArgumentError, 'None of the inputs are nil'
      end

      def compare_stand_alone_item(left, right)
        raise ArgumentError unless left.is_a?(Year2022::Day13::StandAloneItem) && right.is_a?(Year2022::Day13::StandAloneItem)

        if left.value == right.value
          LEFT_EQUALS_RIGHT
        elsif left.value < right.value
          RIGHT_ORDER
        else
          WRONG_ORDER
        end
      end

      def compare_group_item(left_group, right_group)
        raise ArgumentError unless left_group.is_a?(Year2022::Day13::GroupItem) && right_group.is_a?(Year2022::Day13::GroupItem)


        left_group.stand_alone_items.each.with_index do |left_group_item, index|
          right_group_item = right_group.stand_alone_items[index]

          comparison_result =
            if left_group_item.nil? || right_group_item.nil?
              compare_nil(left_group_item, right_group_item)
            elsif left_group_item.is_a?(Year2022::Day13::StandAloneItem) && right_group_item.is_a?(Year2022::Day13::StandAloneItem)
              compare_stand_alone_item(left_group_item, right_group_item)
            elsif left_group_item.is_a?(Year2022::Day13::GroupItem) && right_group_item.is_a?(Year2022::Day13::GroupItem)
              compare_group_item(left_group_item, right_group_item)
            elsif left_group_item.is_a?(Year2022::Day13::StandAloneItem) && right_group_item.is_a?(Year2022::Day13::GroupItem)
              temp_group_item = Year2022::Day13::GroupItem.new([left_group_item])
              compare_group_item(temp_group_item, right_group_item)
            elsif left_group_item.is_a?(Year2022::Day13::GroupItem) && right_group_item.is_a?(Year2022::Day13::StandAloneItem)
              temp_group_item = Year2022::Day13::GroupItem.new([right_group_item])
              compare_group_item(left_group_item, temp_group_item)
            else
              raise ArgumentError, 'Unknown comparison item types'
            end

          return comparison_result unless comparison_result.zero?
        end

        if left_group.stand_alone_items.length < right_group.stand_alone_items.length
          return RIGHT_ORDER
        end

        LEFT_EQUALS_RIGHT
      end
    end
  end
end
