require_relative '../digger'
require_relative '../lagoon'

module Day18
  module Part1
    class Answer
      INPUT_FILE = '../input.txt'

      def self.run
        new.run
      end

      def run
        # trenches.each do |trench|
        #   puts trench.map { |n| n.join(',') }.join(' | ')
        # end
        lagoon.sketch.each do |line|
          puts line.join
        end

        puts "northernmost_lat: #{lagoon.northernmost_lat}"
        puts "southernmost_lat: #{lagoon.southernmost_lat}"
        puts "westernmost_lng: #{lagoon.westernmost_lng}"
        puts "easternmost_lng: #{lagoon.easternmost_lng}"


        lagoon.polygon_coordinates.each do |coordinate|
          puts "#{coordinate.join(',')}"
        end

        a = lagoon.area_by_shoelace_formula + (trenches.map(&:length).sum / 2 + 1)
        #
        puts "The number of cubes that the laggon can hold: #{a}"
        puts "trenches.map(&:length).sum: #{trenches.map(&:length).sum}"

      end

      def lagoon
        @lagoon ||= Day18::Lagoon.new(trenches)
      end

      def trenches
        @trenches ||= digger.dig
      end

      def digger
        @digger ||= Day18::Digger.new(lines)
      end

      def input_path
        File.join(File.dirname(__FILE__), INPUT_FILE)
      end

      def lines
        @lines ||=
          File.open(input_path).inject([]) do |r, line|
            r << line.strip
            r
          end
      end
    end
  end
end
