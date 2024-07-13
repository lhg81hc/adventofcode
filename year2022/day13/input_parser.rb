require_relative 'package_parser'
require_relative 'package'
require_relative 'pair'

module Year2022
  module Day13
    class InputParser
      attr_reader :input_path

      def initialize(input_path)
        @input_path = input_path
      end

      def self.parse(*args)
        new(*args).parse
      end

      def parse
        pairs = []
        current_pair = []

        File.foreach(input_path) do |line|
          parse_line(line.strip, pairs, current_pair) unless line.empty?
        end

        pairs
      end

      def parse_line(line, pairs, current_pair)
        current_pair << build_package(line)
        pairs << Year2022::Day13::Pair.new(current_pair.shift, current_pair.shift) if current_pair.length == 2
      end

      def build_package(line)
        items = Year2022::Day13::PackageParser.new.parse(line)
        Year2022::Day13::Package.new(items)
      end
    end
  end
end