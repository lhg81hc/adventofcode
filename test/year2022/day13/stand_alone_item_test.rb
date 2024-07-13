require 'test/unit'
require_relative '../../../year2022/day13/stand_alone_item'

module Year2022
  module Day13
    class StandAloneItemTest < Test::Unit::TestCase
      def setup
        @stand_alone_item = Year2022::Day13::StandAloneItem.new(10)
      end

      def test_initialization
        assert_equal(10, @stand_alone_item.value)
      end
    end
  end
end
