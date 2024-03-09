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
        puts "The number of cubes that the laggon can hold: #{lagoon.area}"
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
