require_relative 'package_item'

module Year2022
  module Day13
    class GroupItem < PackageItem
      attr_accessor :stand_alone_items

      def initialize(stand_alone_items = [])
        @stand_alone_items = stand_alone_items
      end

      def add_item(item)
        @stand_alone_items << item
      end
    end
  end
end
