require_relative 'valve'

module Year2022
  module Day16
    class CaveScanner
      SINGLE_TUNNEL_PHRASE = 'tunnel leads to valve'.freeze

      attr_reader :input_path, :valves

      def initialize(input_path)
        @input_path = input_path
        @valves = []

        @scanned = false
      end

      def scan
        lead_to_valve_names_map = {}
        valve_map = {}

        File.foreach(input_path) do |line|
          name, flow_rate, lead_to_valve_names = parse_line(line)
          lead_to_valve_names_map[name] = lead_to_valve_names

          valve = Year2022::Day16::Valve.new(name, flow_rate)
          valve_map[name] = valve

          add_valve(valve)
        end

        @valves.each do |valve|
          lead_to_valve_names_map[valve.name].each { |name| valve.add_to_valves(valve_map[name]) }
        end

        @scanned = true
        @valves
      end

      def scanned?
        @scanned
      end

      def add_valve(valve)
        @valves << valve
      end

      private

      def parse_line(line)
        [
          parse_valve_name(line),
          parse_flow_rate(line),
          parse_lead_to_valve_names(line),
        ]
      end

      def parse_valve_name(line)
        line.match(/(?<=Valve )(.*)(?= has)/)[0]
      end

      def parse_flow_rate(line)
        line.match(/(?<=flow rate\=)(.*)(?=;)/)[0].to_i
      end

      def parse_lead_to_valve_names(line)
        if line.include?(SINGLE_TUNNEL_PHRASE)
          [line.match(/(?<=tunnel leads to valve )(.*)/)[0]]
        else
          line.match(/(?<=lead to valves )(.*)/)[0].split(', ')
        end
      end
    end
  end
end
