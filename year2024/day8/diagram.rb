require_relative './antenna'
require_relative './antinode_finder'

module Year2024
  module Day8
    class Diagram
      include AntinodeFinder

      attr_reader :input_path
      attr_accessor :width, :height

      def initialize(input_path)
        @input_path = input_path
      end

      def antennas
        @antennas ||=
          File.foreach(input_path).with_index.inject([]) do |r, (line, line_idx)|
            @width ||= line.strip.length
            @height ||= 0
            @height += 1

            r += parse_line(line.strip, line_idx)
            r
          end
      end

      def all_antenna_frequencies
        @all_antenna_frequencies ||=
          begin
            s = Set.new([])
            antennas.each { |a| s.add(a.frequency) }
            s
          end
      end

      def filter_antennas_by_frequency(frequency)
        antennas.select { |a| a.frequency == frequency }
      end

      private

      def parse_line(line, line_index)
        line.each_char.with_index.inject([]) do |r, (char, char_idx)|
          r << Year2024::Day8::Antenna.new(char, line_index, char_idx) if char != '.'
          r
        end
      end
    end
  end
end
