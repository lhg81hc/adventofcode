module Year2022
  module Day16
    class Valve
      attr_reader :name, :flow_rate
      attr_accessor :to_valves

      def initialize(name, flow_rate, to_valves = [])
        @name = name
        @flow_rate = flow_rate
        @to_valves = to_valves
      end

      def add_to_valves(v)
        @to_valves << v
      end

      def to_s
        name
      end
    end
  end
end
