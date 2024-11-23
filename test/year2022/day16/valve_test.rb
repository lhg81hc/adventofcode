require 'test/unit'
require_relative '../../../year2022/day16/valve'

module Year2022
  module Day16
    class ValveTest < Test::Unit::TestCase
      def setup
        @valve = Year2022::Day16::Valve.new('AA', 10)
      end

      def test_initialization
        assert_equal('AA', @valve.name)
        assert_equal(10, @valve.flow_rate)
        assert_equal([], @valve.to_valves)
      end

      def test_to_s
        assert_equal('AA', @valve.to_s)
      end

      def test_add_to_valves
        assert_equal([], @valve.to_valves)
        another_valve = Year2022::Day16::Valve.new('BB', 0)

        @valve.add_to_valves(another_valve)

        assert_equal(1, @valve.to_valves.length)
        assert_equal(another_valve, @valve.to_valves.first)
      end
    end
  end
end
