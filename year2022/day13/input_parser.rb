require_relative 'package_parser'
require_relative 'pair'

module Year2022
  module Day13
    class InputParser
      attr_reader :input_path

      def initialize(input_path)
        @input_path = input_path
      end

      def self.parse_pairs(*args)
        new(*args).parse_pairs
      end

      def self.parse_packages(*args)
        new(*args).parse_packages
      end

      def parse_pairs
        pairs = []
        current_pair = []

        File.foreach(input_path) do |line|
          striped_line = line.strip
          parse_line(striped_line, pairs, current_pair) unless striped_line.empty?
        end

        pairs
      end

      def parse_packages
        File.foreach(input_path).inject([]) do |r, line|
          striped_line = line.strip

          r << parse_package_from_line(striped_line) unless striped_line.empty?
          r
        end
      end

      def parse_line(line, pairs, current_pair)
        current_pair << parse_package_from_line(line)
        pairs << Year2022::Day13::Pair.new(current_pair.shift, current_pair.shift) if current_pair.length == 2
      end

      def parse_package_from_line(line)
        Year2022::Day13::PackageParser.new.parse(line)
      end
    end
  end
end
