require_relative 'group_item'
require_relative 'stand_alone_item'

module Year2022
  module Day13
    class PackageParser
      def parse(line)
        stack = []
        curr_num_str = ''
        curr_group_item = nil

        line.each_char do |c|
          case c
          when '['
            stack << Year2022::Day13::GroupItem.new
          when ']'
            update_current_stand_alone_items(curr_num_str, stack)

            curr_num_str = ''
            curr_group_item = stack.pop
            prev_group_item = stack.last
            prev_group_item.add_item(curr_group_item) unless prev_group_item.nil?
          when ','
            update_current_stand_alone_items(curr_num_str, stack)
            curr_num_str = ''
          when '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
            curr_num_str += c
          else
            raise ArgumentError, "Unknown character #{c}"
          end
        end

        curr_group_item.nil? ? [] : curr_group_item.stand_alone_items
      end

      def update_current_stand_alone_items(curr_num_str, stack)
        return if curr_num_str.empty?

        curr_num = curr_num_str.to_i
        curr_group_item = stack.last
        curr_group_item.add_item(Year2022::Day13::StandAloneItem.new(curr_num)) unless curr_group_item.nil?
      end
    end
  end
end
