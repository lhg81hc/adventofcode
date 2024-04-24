require_relative '../snapshot_parser'

module Day22
  module Part1
    class Answer
      def initialize

      end

      def self.run
        new.run
      end

      def run
        puts bricks.first.first_coordinates_set
      end

      def bricks
        @bricks ||= Day22::SnapshotParser.parse(filepath)
      end

      def filepath
        File.join(File.dirname(__FILE__), '../input.txt')
      end
    end
  end
end